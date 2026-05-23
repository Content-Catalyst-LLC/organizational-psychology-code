"""
Institutional Values and Behavioral Expectations
Exceptional synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, values-governance review, organizational ethics
education, legitimacy analysis, and reproducible workflows. It is not an
employee-screening, hiring, promotion, compensation, discipline, termination,
workplace surveillance, individual performance-management, cultural-loyalty
scoring, morality scoring, values-alignment scoring of workers, productivity-
ranking, or psychological assessment tool.
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler


ROOT = Path(__file__).resolve().parents[1]
RAW_DATA = ROOT / "data" / "raw" / "institutional_values_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "value_clarity",
    "leadership_consistency",
    "reinforcement_alignment",
    "psychological_safety",
    "accountability_strength",
    "decoupling_risk",
    "incentive_contradiction",
    "hierarchy_exemption",
    "legitimacy_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic institutional-values data."""
    return pd.read_csv(RAW_DATA)


def add_values_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create value-practice alignment, values risk, and review-priority scores."""
    scored = df.copy()

    scored["value_practice_alignment_score"] = (
        0.17 * scored["value_clarity"]
        + 0.16 * scored["leadership_consistency"]
        + 0.16 * scored["reinforcement_alignment"]
        + 0.14 * scored["psychological_safety"]
        + 0.14 * scored["accountability_strength"]
        - 0.10 * scored["decoupling_risk"]
        - 0.09 * scored["incentive_contradiction"]
        - 0.09 * scored["hierarchy_exemption"]
        - 0.05 * scored["legitimacy_pressure"]
    ).clip(0, 100)

    scored["institutional_values_risk_score"] = (
        0.12 * (100 - scored["value_clarity"])
        + 0.14 * (100 - scored["leadership_consistency"])
        + 0.14 * (100 - scored["reinforcement_alignment"])
        + 0.10 * (100 - scored["psychological_safety"])
        + 0.14 * (100 - scored["accountability_strength"])
        + 0.14 * scored["decoupling_risk"]
        + 0.10 * scored["incentive_contradiction"]
        + 0.08 * scored["hierarchy_exemption"]
        + 0.04 * scored["legitimacy_pressure"]
    ).clip(0, 100)

    scored["values_governance_review_priority"] = np.select(
        [
            (scored["institutional_values_risk_score"] >= 70)
            | (scored["value_practice_alignment_score"] < 45)
            | (scored["symbolic_values_risk"] == 1),
            (scored["institutional_values_risk_score"] >= 50)
            | (scored["value_practice_alignment_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize values-governance conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_value_practice_alignment=("value_practice_alignment_score", "mean"),
            avg_institutional_values_risk=("institutional_values_risk_score", "mean"),
            avg_value_clarity=("value_clarity", "mean"),
            avg_leadership_consistency=("leadership_consistency", "mean"),
            avg_reinforcement_alignment=("reinforcement_alignment", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_accountability_strength=("accountability_strength", "mean"),
            avg_decoupling_risk=("decoupling_risk", "mean"),
            avg_incentive_contradiction=("incentive_contradiction", "mean"),
            avg_hierarchy_exemption=("hierarchy_exemption", "mean"),
            avg_legitimacy_pressure=("legitimacy_pressure", "mean"),
            values_credibility_rate=("values_credible", "mean"),
            symbolic_values_risk_rate=("symbolic_values_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_institutional_values_risk", ascending=False)
    )


def fit_values_credibility_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic values-credibility classifier."""
    x = df[FEATURES]
    y = df["values_credible"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=606, stratify=y
    )

    model = Pipeline(
        steps=[
            ("scale", StandardScaler()),
            ("logit", LogisticRegression(max_iter=3000)),
        ]
    )

    model.fit(x_train, y_train)

    probabilities = model.predict_proba(x_test)[:, 1]
    predictions = model.predict(x_test)

    auc = roc_auc_score(y_test, probabilities)
    report = classification_report(y_test, predictions)

    coefficients = pd.DataFrame(
        {
            "feature": FEATURES,
            "coefficient": model.named_steps["logit"].coef_[0],
        }
    ).sort_values("coefficient", ascending=False)

    return model, coefficients, report, auc


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare two synthetic institutional-values scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Credible and reinforced values system",
                "value_clarity": 86,
                "leadership_consistency": 83,
                "reinforcement_alignment": 81,
                "psychological_safety": 82,
                "accountability_strength": 80,
                "decoupling_risk": 16,
                "incentive_contradiction": 20,
                "hierarchy_exemption": 12,
                "legitimacy_pressure": 58,
            },
            {
                "scenario": "Symbolic and decoupled values system",
                "value_clarity": 48,
                "leadership_consistency": 36,
                "reinforcement_alignment": 31,
                "psychological_safety": 38,
                "accountability_strength": 34,
                "decoupling_risk": 74,
                "incentive_contradiction": 70,
                "hierarchy_exemption": 76,
                "legitimacy_pressure": 58,
            },
        ]
    )

    scenarios["predicted_values_credibility_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["institutional_values_risk_score"] = (
        0.12 * (100 - scenarios["value_clarity"])
        + 0.14 * (100 - scenarios["leadership_consistency"])
        + 0.14 * (100 - scenarios["reinforcement_alignment"])
        + 0.10 * (100 - scenarios["psychological_safety"])
        + 0.14 * (100 - scenarios["accountability_strength"])
        + 0.14 * scenarios["decoupling_risk"]
        + 0.10 * scenarios["incentive_contradiction"]
        + 0.08 * scenarios["hierarchy_exemption"]
        + 0.04 * scenarios["legitimacy_pressure"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_values_scores(df)

    scored.to_csv(TABLE_DIR / "scored_institutional_values_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_institutional_values_summary.csv", index=False)

    model, coefficients, report, auc = fit_values_credibility_model(scored)
    coefficients.to_csv(TABLE_DIR / "values_credibility_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "institutional_values_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "values_credibility_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic institutional values credibility model\n")
        handle.write("================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and values-governance review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, morality scoring, values-alignment scoring, "
            "productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

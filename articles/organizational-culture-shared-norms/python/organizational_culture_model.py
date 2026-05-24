"""
Organizational Culture and Shared Norms
Exceptional synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, culture review, organizational development education,
legitimacy analysis, and reproducible workflows. It is not an employee-screening,
hiring, promotion, compensation, discipline, termination, workplace surveillance,
individual performance-management, cultural-loyalty scoring, cultural-fit scoring,
productivity-ranking, or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "organizational_culture_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "value_alignment",
    "normative_consistency",
    "leadership_credibility",
    "psychological_safety",
    "shared_meaning",
    "contradiction",
    "fragmentation",
    "incentive_distortion",
    "external_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic organizational-culture data."""
    return pd.read_csv(RAW_DATA)


def add_culture_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create cultural coherence, culture risk, and review-priority scores."""
    scored = df.copy()

    scored["cultural_coherence_score"] = (
        0.18 * scored["value_alignment"]
        + 0.16 * scored["normative_consistency"]
        + 0.15 * scored["leadership_credibility"]
        + 0.14 * scored["psychological_safety"]
        + 0.14 * scored["shared_meaning"]
        - 0.10 * scored["contradiction"]
        - 0.08 * scored["fragmentation"]
        - 0.10 * scored["incentive_distortion"]
        - 0.05 * scored["external_pressure"]
    ).clip(0, 100)

    scored["culture_risk_score"] = (
        0.14 * (100 - scored["value_alignment"])
        + 0.12 * (100 - scored["normative_consistency"])
        + 0.12 * (100 - scored["leadership_credibility"])
        + 0.12 * (100 - scored["psychological_safety"])
        + 0.12 * (100 - scored["shared_meaning"])
        + 0.14 * scored["contradiction"]
        + 0.10 * scored["fragmentation"]
        + 0.10 * scored["incentive_distortion"]
        + 0.04 * scored["external_pressure"]
    ).clip(0, 100)

    scored["culture_review_priority"] = np.select(
        [
            (scored["culture_risk_score"] >= 70)
            | (scored["cultural_coherence_score"] < 45)
            | (scored["symbolic_culture_risk"] == 1),
            (scored["culture_risk_score"] >= 50)
            | (scored["cultural_coherence_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize cultural conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_cultural_coherence=("cultural_coherence_score", "mean"),
            avg_culture_risk=("culture_risk_score", "mean"),
            avg_value_alignment=("value_alignment", "mean"),
            avg_normative_consistency=("normative_consistency", "mean"),
            avg_leadership_credibility=("leadership_credibility", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_shared_meaning=("shared_meaning", "mean"),
            avg_contradiction=("contradiction", "mean"),
            avg_fragmentation=("fragmentation", "mean"),
            avg_incentive_distortion=("incentive_distortion", "mean"),
            avg_external_pressure=("external_pressure", "mean"),
            performance_integrity_rate=("strong_institutional_performance", "mean"),
            symbolic_culture_risk_rate=("symbolic_culture_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_culture_risk", ascending=False)
    )


def fit_performance_integrity_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic strong-institutional-performance classifier."""
    x = df[FEATURES]
    y = df["strong_institutional_performance"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=303, stratify=y
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
    """Compare two synthetic organizational-culture scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Coherent learning-oriented culture",
                "value_alignment": 84,
                "normative_consistency": 80,
                "leadership_credibility": 81,
                "psychological_safety": 84,
                "shared_meaning": 82,
                "contradiction": 16,
                "fragmentation": 22,
                "incentive_distortion": 20,
                "external_pressure": 58,
            },
            {
                "scenario": "Fragmented symbolic culture risk",
                "value_alignment": 39,
                "normative_consistency": 41,
                "leadership_credibility": 36,
                "psychological_safety": 34,
                "shared_meaning": 38,
                "contradiction": 73,
                "fragmentation": 69,
                "incentive_distortion": 71,
                "external_pressure": 58,
            },
        ]
    )

    scenarios["predicted_strong_institutional_performance_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["culture_risk_score"] = (
        0.14 * (100 - scenarios["value_alignment"])
        + 0.12 * (100 - scenarios["normative_consistency"])
        + 0.12 * (100 - scenarios["leadership_credibility"])
        + 0.12 * (100 - scenarios["psychological_safety"])
        + 0.12 * (100 - scenarios["shared_meaning"])
        + 0.14 * scenarios["contradiction"]
        + 0.10 * scenarios["fragmentation"]
        + 0.10 * scenarios["incentive_distortion"]
        + 0.04 * scenarios["external_pressure"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_culture_scores(df)

    scored.to_csv(TABLE_DIR / "scored_organizational_culture_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_organizational_culture_summary.csv", index=False)

    model, coefficients, report, auc = fit_performance_integrity_model(scored)
    coefficients.to_csv(TABLE_DIR / "performance_integrity_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "organizational_culture_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "performance_integrity_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic organizational culture performance-integrity model\n")
        handle.write("============================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and culture review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, cultural-fit scoring, productivity ranking, or "
            "psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

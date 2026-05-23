"""
Cognitive Bias in Institutional Decisions
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, decision-governance review, bias-risk analysis,
and reproducible workflows. It is not an employee-screening, hiring,
promotion, compensation, discipline, termination, workplace surveillance,
individual performance-management, executive-ranking, productivity-ranking,
or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "bias_pressure_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "signal_quality",
    "viewpoint_diversity",
    "analytical_discipline",
    "structured_challenge",
    "hierarchy_suppression",
    "time_pressure",
    "routine_reinforcement",
    "learning_review",
    "group_conformity",
]


def load_data() -> pd.DataFrame:
    """Load synthetic bias-pressure data."""
    return pd.read_csv(RAW_DATA)


def add_bias_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create bias pressure, bias risk, and review-priority scores."""
    scored = df.copy()

    scored["bias_pressure_score"] = (
        0.16 * scored["hierarchy_suppression"]
        + 0.15 * scored["time_pressure"]
        + 0.14 * scored["routine_reinforcement"]
        + 0.13 * scored["group_conformity"]
        - 0.16 * scored["viewpoint_diversity"]
        - 0.13 * scored["analytical_discipline"]
        - 0.14 * scored["structured_challenge"]
        - 0.12 * scored["learning_review"]
        - 0.10 * scored["signal_quality"]
    ).clip(0, 100)

    scored["bias_risk_score"] = (
        0.10 * (100 - scored["signal_quality"])
        + 0.13 * (100 - scored["viewpoint_diversity"])
        + 0.12 * (100 - scored["analytical_discipline"])
        + 0.12 * (100 - scored["structured_challenge"])
        + 0.15 * scored["hierarchy_suppression"]
        + 0.12 * scored["time_pressure"]
        + 0.10 * scored["routine_reinforcement"]
        + 0.08 * (100 - scored["learning_review"])
        + 0.08 * scored["group_conformity"]
    ).clip(0, 100)

    scored["bias_governance_review_priority"] = np.select(
        [
            (scored["bias_risk_score"] >= 70)
            | (scored["bias_pressure_score"] >= 70)
            | (scored["escalation_of_commitment"] == 1),
            (scored["bias_risk_score"] >= 50)
            | (scored["bias_pressure_score"] >= 55),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize bias-pressure conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_bias_pressure=("bias_pressure_score", "mean"),
            avg_bias_risk=("bias_risk_score", "mean"),
            avg_signal_quality=("signal_quality", "mean"),
            avg_viewpoint_diversity=("viewpoint_diversity", "mean"),
            avg_analytical_discipline=("analytical_discipline", "mean"),
            avg_structured_challenge=("structured_challenge", "mean"),
            avg_hierarchy_suppression=("hierarchy_suppression", "mean"),
            avg_time_pressure=("time_pressure", "mean"),
            avg_learning_review=("learning_review", "mean"),
            decision_error_rate=("decision_error", "mean"),
            escalation_rate=("escalation_of_commitment", "mean"),
        )
        .reset_index()
        .sort_values("avg_bias_risk", ascending=False)
    )


def fit_decision_error_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic decision-error classifier."""
    x = df[FEATURES]
    y = df["decision_error"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=404, stratify=y
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
    """Compare two synthetic decision-governance scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Strong corrective decision architecture",
                "signal_quality": 84,
                "viewpoint_diversity": 80,
                "analytical_discipline": 82,
                "structured_challenge": 81,
                "hierarchy_suppression": 14,
                "time_pressure": 38,
                "routine_reinforcement": 36,
                "learning_review": 79,
                "group_conformity": 28,
            },
            {
                "scenario": "High bias-pressure decision architecture",
                "signal_quality": 48,
                "viewpoint_diversity": 36,
                "analytical_discipline": 41,
                "structured_challenge": 24,
                "hierarchy_suppression": 72,
                "time_pressure": 74,
                "routine_reinforcement": 69,
                "learning_review": 31,
                "group_conformity": 70,
            },
        ]
    )

    scenarios["predicted_decision_error_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["bias_risk_score"] = (
        0.10 * (100 - scenarios["signal_quality"])
        + 0.13 * (100 - scenarios["viewpoint_diversity"])
        + 0.12 * (100 - scenarios["analytical_discipline"])
        + 0.12 * (100 - scenarios["structured_challenge"])
        + 0.15 * scenarios["hierarchy_suppression"]
        + 0.12 * scenarios["time_pressure"]
        + 0.10 * scenarios["routine_reinforcement"]
        + 0.08 * (100 - scenarios["learning_review"])
        + 0.08 * scenarios["group_conformity"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_bias_scores(df)

    scored.to_csv(TABLE_DIR / "scored_bias_pressure_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_bias_pressure_summary.csv", index=False)

    model, coefficients, report, auc = fit_decision_error_model(scored)
    coefficients.to_csv(TABLE_DIR / "decision_error_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "bias_pressure_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "decision_error_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic bias-pressure decision-error model\n")
        handle.write("============================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and decision-governance review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, executive "
            "ranking, productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

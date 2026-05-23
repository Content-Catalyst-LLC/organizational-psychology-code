"""
Information Flow and Organizational Communication
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, organizational communication review, knowledge-flow
governance, decision-process review, and reproducible workflows. It is not
an employee-screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance-management,
communication-surveillance, productivity-ranking, or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "information_flow_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "signal_quality",
    "timeliness",
    "interpretive_clarity",
    "cross_functional_connectivity",
    "psychological_safety",
    "distortion_risk",
    "overload_pressure",
    "hierarchy_delay",
    "external_signal_turbulence",
]


def load_data() -> pd.DataFrame:
    """Load synthetic information-flow data."""
    return pd.read_csv(RAW_DATA)


def add_information_flow_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create information flow quality, communication risk, and review-priority scores."""
    scored = df.copy()

    scored["information_flow_quality_score"] = (
        0.18 * scored["signal_quality"]
        + 0.15 * scored["timeliness"]
        + 0.15 * scored["interpretive_clarity"]
        + 0.14 * scored["cross_functional_connectivity"]
        + 0.13 * scored["psychological_safety"]
        - 0.10 * scored["distortion_risk"]
        - 0.08 * scored["overload_pressure"]
        - 0.10 * scored["hierarchy_delay"]
        - 0.05 * scored["external_signal_turbulence"]
    ).clip(0, 100)

    scored["communication_risk_score"] = (
        0.16 * (100 - scored["signal_quality"])
        + 0.13 * (100 - scored["timeliness"])
        + 0.12 * (100 - scored["interpretive_clarity"])
        + 0.11 * (100 - scored["cross_functional_connectivity"])
        + 0.12 * (100 - scored["psychological_safety"])
        + 0.13 * scored["distortion_risk"]
        + 0.10 * scored["overload_pressure"]
        + 0.09 * scored["hierarchy_delay"]
        + 0.04 * scored["external_signal_turbulence"]
    ).clip(0, 100)

    scored["communication_review_priority"] = np.select(
        [
            (scored["communication_risk_score"] >= 70)
            | (scored["information_flow_quality_score"] < 45)
            | (scored["escalation_failure"] == 1),
            (scored["communication_risk_score"] >= 50)
            | (scored["information_flow_quality_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize communication conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_information_flow_quality=("information_flow_quality_score", "mean"),
            avg_communication_risk=("communication_risk_score", "mean"),
            avg_signal_quality=("signal_quality", "mean"),
            avg_timeliness=("timeliness", "mean"),
            avg_interpretive_clarity=("interpretive_clarity", "mean"),
            avg_cross_functional_connectivity=("cross_functional_connectivity", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_distortion_risk=("distortion_risk", "mean"),
            avg_overload_pressure=("overload_pressure", "mean"),
            avg_hierarchy_delay=("hierarchy_delay", "mean"),
            decision_error_rate=("decision_error", "mean"),
            escalation_failure_rate=("escalation_failure", "mean"),
        )
        .reset_index()
        .sort_values("avg_communication_risk", ascending=False)
    )


def fit_decision_error_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic decision-error classifier."""
    x = df[FEATURES]
    y = df["decision_error"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=515, stratify=y
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
    """Compare two synthetic communication-system scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High-quality knowledge flow",
                "signal_quality": 84,
                "timeliness": 82,
                "interpretive_clarity": 80,
                "cross_functional_connectivity": 79,
                "psychological_safety": 83,
                "distortion_risk": 14,
                "overload_pressure": 32,
                "hierarchy_delay": 18,
                "external_signal_turbulence": 58,
            },
            {
                "scenario": "Suppressed and overloaded communication",
                "signal_quality": 46,
                "timeliness": 41,
                "interpretive_clarity": 38,
                "cross_functional_connectivity": 35,
                "psychological_safety": 31,
                "distortion_risk": 71,
                "overload_pressure": 72,
                "hierarchy_delay": 68,
                "external_signal_turbulence": 58,
            },
        ]
    )

    scenarios["predicted_decision_error_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["communication_risk_score"] = (
        0.16 * (100 - scenarios["signal_quality"])
        + 0.13 * (100 - scenarios["timeliness"])
        + 0.12 * (100 - scenarios["interpretive_clarity"])
        + 0.11 * (100 - scenarios["cross_functional_connectivity"])
        + 0.12 * (100 - scenarios["psychological_safety"])
        + 0.13 * scenarios["distortion_risk"]
        + 0.10 * scenarios["overload_pressure"]
        + 0.09 * scenarios["hierarchy_delay"]
        + 0.04 * scenarios["external_signal_turbulence"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_information_flow_scores(df)

    scored.to_csv(TABLE_DIR / "scored_information_flow_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_information_flow_summary.csv", index=False)

    model, coefficients, report, auc = fit_decision_error_model(scored)
    coefficients.to_csv(TABLE_DIR / "decision_error_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "information_flow_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "decision_error_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic information flow decision-error model\n")
        handle.write("===============================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and organizational communication "
            "review. It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, communication "
            "monitoring, productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

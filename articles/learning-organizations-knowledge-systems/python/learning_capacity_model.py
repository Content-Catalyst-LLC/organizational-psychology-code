"""
Learning Organizations and Knowledge Systems
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, organizational knowledge governance, and reproducible
workflows. It is not an employee-screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance-
management, or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "organizational_learning_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "information_quality",
    "interpretive_openness",
    "memory_retention",
    "communication_flow",
    "psychological_safety",
    "governance_support",
    "complexity_load",
    "silo_intensity",
    "incentive_distortion",
    "turnover_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic organizational learning data."""
    return pd.read_csv(RAW_DATA)


def add_learning_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create institutional learning capacity and knowledge decay scores."""
    scored = df.copy()

    scored["learning_capacity_score"] = (
        0.17 * scored["information_quality"]
        + 0.18 * scored["interpretive_openness"]
        + 0.15 * scored["memory_retention"]
        + 0.15 * scored["communication_flow"]
        + 0.13 * scored["psychological_safety"]
        + 0.10 * scored["governance_support"]
        - 0.07 * scored["complexity_load"]
        - 0.10 * scored["silo_intensity"]
        - 0.10 * scored["incentive_distortion"]
        - 0.05 * scored["turnover_pressure"]
    ).clip(0, 100)

    scored["knowledge_decay_risk_score"] = (
        0.28 * (100 - scored["memory_retention"])
        + 0.18 * scored["turnover_pressure"]
        + 0.16 * scored["silo_intensity"]
        + 0.12 * (100 - scored["communication_flow"])
        + 0.10 * (100 - scored["governance_support"])
        + 0.10 * scored["incentive_distortion"]
        + 0.06 * scored["complexity_load"]
    ).clip(0, 100)

    scored["learning_review_priority"] = np.select(
        [
            (scored["knowledge_decay_risk_score"] >= 65)
            | (scored["learning_capacity_score"] < 45)
            | (scored["knowledge_decay_event"] == 1),
            (scored["knowledge_decay_risk_score"] >= 45)
            | (scored["learning_capacity_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize organizational learning conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_learning_capacity=("learning_capacity_score", "mean"),
            avg_knowledge_decay_risk=("knowledge_decay_risk_score", "mean"),
            avg_interpretive_openness=("interpretive_openness", "mean"),
            avg_memory_retention=("memory_retention", "mean"),
            avg_communication_flow=("communication_flow", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_silo_intensity=("silo_intensity", "mean"),
            avg_incentive_distortion=("incentive_distortion", "mean"),
            adaptive_improvement_rate=("adaptive_improvement", "mean"),
            knowledge_decay_event_rate=("knowledge_decay_event", "mean"),
        )
        .reset_index()
        .sort_values("avg_knowledge_decay_risk", ascending=False)
    )


def fit_adaptive_improvement_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic adaptive-improvement classifier."""
    x = df[FEATURES]
    y = df["adaptive_improvement"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=321, stratify=y
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
    """Compare two synthetic institutional learning scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High learning infrastructure",
                "information_quality": 84,
                "interpretive_openness": 82,
                "memory_retention": 83,
                "communication_flow": 86,
                "psychological_safety": 84,
                "governance_support": 78,
                "complexity_load": 48,
                "silo_intensity": 20,
                "incentive_distortion": 17,
                "turnover_pressure": 19,
            },
            {
                "scenario": "Fragmented knowledge system",
                "information_quality": 57,
                "interpretive_openness": 38,
                "memory_retention": 42,
                "communication_flow": 45,
                "psychological_safety": 36,
                "governance_support": 39,
                "complexity_load": 75,
                "silo_intensity": 78,
                "incentive_distortion": 67,
                "turnover_pressure": 59,
            },
        ]
    )

    scenarios["predicted_adaptive_improvement_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["knowledge_decay_risk_score"] = (
        0.28 * (100 - scenarios["memory_retention"])
        + 0.18 * scenarios["turnover_pressure"]
        + 0.16 * scenarios["silo_intensity"]
        + 0.12 * (100 - scenarios["communication_flow"])
        + 0.10 * (100 - scenarios["governance_support"])
        + 0.10 * scenarios["incentive_distortion"]
        + 0.06 * scenarios["complexity_load"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_learning_scores(df)

    scored.to_csv(TABLE_DIR / "scored_learning_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_learning_summary.csv", index=False)

    model, coefficients, report, auc = fit_adaptive_improvement_model(scored)
    coefficients.to_csv(TABLE_DIR / "adaptive_improvement_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "learning_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "adaptive_improvement_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic organizational learning adaptive-improvement model\n")
        handle.write("===========================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and organizational knowledge "
            "governance. It must not be used for employee screening, employment "
            "selection, workplace surveillance, individual performance management, "
            "or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

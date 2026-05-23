"""
Adaptive Organizations: Institutional Change and Strategic Transformation
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, organizational change governance, and reproducible
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
RAW_DATA = ROOT / "data" / "raw" / "adaptive_change_capacity_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "sensing_quality",
    "interpretive_coherence",
    "governance_alignment",
    "learning_capability",
    "resource_flexibility",
    "institutional_legitimacy",
    "organizational_inertia",
    "fragmentation",
    "resistance_friction",
    "environmental_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic adaptive-change data."""
    return pd.read_csv(RAW_DATA)


def add_adaptive_change_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create adaptive change capacity, adaptation risk, and review-priority scores."""
    scored = df.copy()

    scored["adaptive_change_capacity_score"] = (
        0.17 * scored["sensing_quality"]
        + 0.16 * scored["interpretive_coherence"]
        + 0.15 * scored["governance_alignment"]
        + 0.16 * scored["learning_capability"]
        + 0.12 * scored["resource_flexibility"]
        + 0.12 * scored["institutional_legitimacy"]
        - 0.13 * scored["organizational_inertia"]
        - 0.11 * scored["fragmentation"]
        - 0.10 * scored["resistance_friction"]
        - 0.05 * scored["environmental_pressure"]
    ).clip(0, 100)

    scored["adaptation_risk_score"] = (
        0.16 * (100 - scored["sensing_quality"])
        + 0.14 * (100 - scored["interpretive_coherence"])
        + 0.14 * (100 - scored["governance_alignment"])
        + 0.14 * (100 - scored["learning_capability"])
        + 0.10 * (100 - scored["resource_flexibility"])
        + 0.10 * (100 - scored["institutional_legitimacy"])
        + 0.10 * scored["organizational_inertia"]
        + 0.06 * scored["fragmentation"]
        + 0.04 * scored["resistance_friction"]
        + 0.02 * scored["environmental_pressure"]
    ).clip(0, 100)

    scored["change_governance_review_priority"] = np.select(
        [
            (scored["adaptation_risk_score"] >= 70)
            | (scored["adaptive_change_capacity_score"] < 45)
            | (scored["symbolic_change"] == 1),
            (scored["adaptation_risk_score"] >= 50)
            | (scored["adaptive_change_capacity_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize adaptive change conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_adaptive_change_capacity=("adaptive_change_capacity_score", "mean"),
            avg_adaptation_risk=("adaptation_risk_score", "mean"),
            avg_sensing_quality=("sensing_quality", "mean"),
            avg_governance_alignment=("governance_alignment", "mean"),
            avg_learning_capability=("learning_capability", "mean"),
            avg_institutional_legitimacy=("institutional_legitimacy", "mean"),
            avg_organizational_inertia=("organizational_inertia", "mean"),
            avg_fragmentation=("fragmentation", "mean"),
            transformation_rate=("successful_transformation", "mean"),
            symbolic_change_rate=("symbolic_change", "mean"),
        )
        .reset_index()
        .sort_values("avg_adaptation_risk", ascending=False)
    )


def fit_transformation_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic successful-transformation classifier."""
    x = df[FEATURES]
    y = df["successful_transformation"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=909, stratify=y
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
    """Compare two synthetic adaptive-change scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High adaptive capacity",
                "sensing_quality": 84,
                "interpretive_coherence": 81,
                "governance_alignment": 79,
                "learning_capability": 83,
                "resource_flexibility": 74,
                "institutional_legitimacy": 80,
                "organizational_inertia": 20,
                "fragmentation": 18,
                "resistance_friction": 24,
                "environmental_pressure": 62,
            },
            {
                "scenario": "High inertia and fragmentation",
                "sensing_quality": 52,
                "interpretive_coherence": 44,
                "governance_alignment": 39,
                "learning_capability": 46,
                "resource_flexibility": 41,
                "institutional_legitimacy": 43,
                "organizational_inertia": 73,
                "fragmentation": 66,
                "resistance_friction": 68,
                "environmental_pressure": 62,
            },
        ]
    )

    scenarios["predicted_successful_transformation_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["adaptation_risk_score"] = (
        0.16 * (100 - scenarios["sensing_quality"])
        + 0.14 * (100 - scenarios["interpretive_coherence"])
        + 0.14 * (100 - scenarios["governance_alignment"])
        + 0.14 * (100 - scenarios["learning_capability"])
        + 0.10 * (100 - scenarios["resource_flexibility"])
        + 0.10 * (100 - scenarios["institutional_legitimacy"])
        + 0.10 * scenarios["organizational_inertia"]
        + 0.06 * scenarios["fragmentation"]
        + 0.04 * scenarios["resistance_friction"]
        + 0.02 * scenarios["environmental_pressure"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_adaptive_change_scores(df)

    scored.to_csv(TABLE_DIR / "scored_adaptive_change_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_adaptive_change_summary.csv", index=False)

    model, coefficients, report, auc = fit_transformation_model(scored)
    coefficients.to_csv(TABLE_DIR / "successful_transformation_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "adaptive_change_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "successful_transformation_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic adaptive change successful-transformation model\n")
        handle.write("========================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and organizational change "
            "governance. It must not be used for employee screening, employment "
            "selection, workplace surveillance, individual performance management, "
            "or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

"""
Python Workflow: Simulating Feedback, Adaptation, and System Risk

Responsible-use scope:
This workflow is for synthetic-data research, methods demonstration,
institutional learning, and organizational psychology education.
It is not an employee-screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance-management,
productivity-ranking, loyalty-scoring, dissent-tracking, or psychological
assessment tool.
"""

from __future__ import annotations

from pathlib import Path

import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression, LinearRegression
from sklearn.metrics import classification_report, roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler


ROOT = Path(__file__).resolve().parents[1]
RAW_DATA = ROOT / "data" / "raw" / "complex_behavioral_systems_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)

FEATURES = [
    "capability",
    "motivation",
    "role_clarity",
    "psychological_safety",
    "leadership_trust",
    "cultural_coherence",
    "incentive_alignment",
    "information_flow",
    "learning_capacity",
    "redundancy_slack",
    "workload_pressure",
    "silence_risk",
    "fragmentation_pressure",
    "environmental_uncertainty",
]


def load_data() -> pd.DataFrame:
    """Load synthetic complex behavioral systems data."""
    return pd.read_csv(RAW_DATA)


def add_system_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Add transparent behavior quality and complex system risk scores."""
    scored = df.copy()

    scored["modeled_behavior_quality"] = (
        0.13 * scored["capability"]
        + 0.12 * scored["motivation"]
        + 0.12 * scored["role_clarity"]
        + 0.11 * scored["psychological_safety"]
        + 0.11 * scored["leadership_trust"]
        + 0.09 * scored["cultural_coherence"]
        + 0.09 * scored["incentive_alignment"]
        + 0.08 * scored["information_flow"]
        + 0.07 * scored["learning_capacity"]
        + 0.05 * scored["redundancy_slack"]
        - 0.08 * scored["workload_pressure"]
        - 0.06 * scored["silence_risk"]
        - 0.06 * scored["fragmentation_pressure"]
        - 0.05 * scored["environmental_uncertainty"]
    ).clip(0, 100)

    scored["modeled_complex_system_risk"] = (
        0.11 * (100 - scored["psychological_safety"])
        + 0.11 * (100 - scored["leadership_trust"])
        + 0.09 * (100 - scored["cultural_coherence"])
        + 0.09 * (100 - scored["incentive_alignment"])
        + 0.09 * (100 - scored["information_flow"])
        + 0.10 * (100 - scored["learning_capacity"])
        + 0.08 * (100 - scored["redundancy_slack"])
        + 0.09 * scored["workload_pressure"]
        + 0.08 * scored["silence_risk"]
        + 0.10 * scored["fragmentation_pressure"]
        + 0.08 * scored["environmental_uncertainty"]
    ).clip(0, 100)

    scored["review_priority"] = np.select(
        [
            (scored["modeled_complex_system_risk"] >= 70)
            | (scored["modeled_behavior_quality"] < 45),
            (scored["modeled_complex_system_risk"] >= 50)
            | (scored["modeled_behavior_quality"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    scored["resilience_capacity_index"] = (
        0.18 * scored["psychological_safety"]
        + 0.17 * scored["leadership_trust"]
        + 0.16 * scored["information_flow"]
        + 0.18 * scored["learning_capacity"]
        + 0.14 * scored["redundancy_slack"]
        + 0.09 * scored["cultural_coherence"]
        + 0.08 * scored["incentive_alignment"]
    ).clip(0, 100)

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Create unit-level complex behavioral system summaries."""
    return (
        df.groupby("unit_id")
        .agg(
            people=("person_id", "count"),
            avg_modeled_behavior_quality=("modeled_behavior_quality", "mean"),
            avg_modeled_complex_system_risk=("modeled_complex_system_risk", "mean"),
            avg_resilience_capacity=("resilience_capacity_index", "mean"),
            avg_capability=("capability", "mean"),
            avg_motivation=("motivation", "mean"),
            avg_role_clarity=("role_clarity", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_leadership_trust=("leadership_trust", "mean"),
            avg_cultural_coherence=("cultural_coherence", "mean"),
            avg_incentive_alignment=("incentive_alignment", "mean"),
            avg_information_flow=("information_flow", "mean"),
            avg_learning_capacity=("learning_capacity", "mean"),
            avg_redundancy_slack=("redundancy_slack", "mean"),
            avg_workload_pressure=("workload_pressure", "mean"),
            avg_silence_risk=("silence_risk", "mean"),
            avg_fragmentation_pressure=("fragmentation_pressure", "mean"),
            avg_environmental_uncertainty=("environmental_uncertainty", "mean"),
        )
        .reset_index()
        .sort_values("avg_modeled_complex_system_risk", ascending=False)
    )


def fit_behavior_models(scored: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame, str, float]:
    """Fit synthetic behavior-quality models for demonstration."""
    modeled = scored.copy()
    modeled["high_behavior_quality"] = (
        modeled["modeled_behavior_quality"] > modeled["modeled_behavior_quality"].median()
    ).astype(int)

    x = modeled[FEATURES]
    y = modeled["high_behavior_quality"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=626, stratify=y
    )

    classifier = Pipeline(
        steps=[
            ("scale", StandardScaler()),
            ("logit", LogisticRegression(max_iter=3000)),
        ]
    )
    classifier.fit(x_train, y_train)

    probabilities = classifier.predict_proba(x_test)[:, 1]
    predictions = classifier.predict(x_test)

    auc = roc_auc_score(y_test, probabilities)
    report = classification_report(y_test, predictions)

    classification_coefficients = pd.DataFrame(
        {
            "feature": FEATURES,
            "coefficient": classifier.named_steps["logit"].coef_[0],
        }
    ).sort_values("coefficient", ascending=False)

    regressor = LinearRegression()
    regressor.fit(modeled[FEATURES], modeled["modeled_behavior_quality"])
    regression_coefficients = pd.DataFrame(
        {"feature": FEATURES, "coefficient": regressor.coef_}
    ).sort_values("coefficient", ascending=False)

    return classification_coefficients, regression_coefficients, report, auc


def build_scenarios() -> pd.DataFrame:
    """Compare healthy and fragile complex behavioral system scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High-trust learning-oriented complex system",
                "capability": 72,
                "motivation": 78,
                "role_clarity": 82,
                "psychological_safety": 84,
                "leadership_trust": 85,
                "cultural_coherence": 82,
                "incentive_alignment": 80,
                "information_flow": 83,
                "learning_capacity": 82,
                "redundancy_slack": 68,
                "workload_pressure": 30,
                "silence_risk": 18,
                "fragmentation_pressure": 22,
                "environmental_uncertainty": 42,
                "unit_id": "Scenario",
                "person_id": "Scenario_A",
            },
            {
                "scenario": "Fragmented overloaded silence-prone system",
                "capability": 72,
                "motivation": 48,
                "role_clarity": 38,
                "psychological_safety": 30,
                "leadership_trust": 32,
                "cultural_coherence": 36,
                "incentive_alignment": 34,
                "information_flow": 35,
                "learning_capacity": 28,
                "redundancy_slack": 18,
                "workload_pressure": 82,
                "silence_risk": 76,
                "fragmentation_pressure": 78,
                "environmental_uncertainty": 72,
                "unit_id": "Scenario",
                "person_id": "Scenario_B",
            },
        ]
    )

    scored = add_system_scores(scenarios)
    return scored[
        [
            "scenario",
            "modeled_behavior_quality",
            "modeled_complex_system_risk",
            "resilience_capacity_index",
            "review_priority",
        ]
    ]


def main() -> None:
    df = load_data()
    scored = add_system_scores(df)
    scored.to_csv(TABLE_DIR / "scored_complex_behavioral_system_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_complex_behavioral_system_summary.csv", index=False)

    class_coef, reg_coef, report, auc = fit_behavior_models(scored)
    class_coef.to_csv(TABLE_DIR / "behavior_quality_classification_coefficients.csv", index=False)
    reg_coef.to_csv(TABLE_DIR / "behavior_quality_regression_coefficients.csv", index=False)

    scenarios = build_scenarios()
    scenarios.to_csv(TABLE_DIR / "complex_behavioral_system_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic organizations as complex behavioral systems model\n")
        handle.write("==========================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This is a synthetic methods demonstration "
            "for institutional learning. It must not be used for employee screening, "
            "employment selection, surveillance, individual performance management, "
            "productivity ranking, loyalty scoring, dissent tracking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenarios)


if __name__ == "__main__":
    main()

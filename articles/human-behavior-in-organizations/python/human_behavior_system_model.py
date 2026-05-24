"""
Python Workflow: Simulating Human Behavior in Organizational Systems

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
RAW_DATA = ROOT / "data" / "raw" / "human_behavior_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)

BEHAVIOR_FEATURES = [
    "capability",
    "motivation",
    "role_clarity",
    "psychological_safety",
    "leadership_trust",
    "cultural_norm_strength",
    "incentive_alignment",
    "workload_pressure",
    "burnout_pressure",
    "hierarchical_pressure",
]

VOICE_FEATURES = [
    "psychological_safety",
    "leadership_trust",
    "perceived_voice_efficacy",
    "fear_of_retaliation",
    "hierarchical_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic human behavior data."""
    return pd.read_csv(RAW_DATA)


def add_system_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Add transparent behavior quality, voice, and system-risk scores."""
    scored = df.copy()

    scored["modeled_behavior_quality"] = (
        0.16 * scored["capability"]
        + 0.15 * scored["motivation"]
        + 0.14 * scored["role_clarity"]
        + 0.12 * scored["psychological_safety"]
        + 0.12 * scored["leadership_trust"]
        + 0.10 * scored["cultural_norm_strength"]
        + 0.09 * scored["incentive_alignment"]
        - 0.08 * scored["workload_pressure"]
        - 0.08 * scored["burnout_pressure"]
        - 0.06 * scored["hierarchical_pressure"]
    ).clip(0, 100)

    scored["modeled_behavior_system_risk"] = (
        0.12 * (100 - scored["role_clarity"])
        + 0.15 * (100 - scored["psychological_safety"])
        + 0.15 * (100 - scored["leadership_trust"])
        + 0.10 * (100 - scored["cultural_norm_strength"])
        + 0.10 * (100 - scored["incentive_alignment"])
        + 0.13 * scored["workload_pressure"]
        + 0.13 * scored["burnout_pressure"]
        + 0.07 * scored["hierarchical_pressure"]
        + 0.05 * scored["fear_of_retaliation"]
    ).clip(0, 100)

    voice_logit = (
        -2.0
        + 0.030 * scored["psychological_safety"]
        + 0.024 * scored["leadership_trust"]
        + 0.022 * scored["perceived_voice_efficacy"]
        - 0.026 * scored["fear_of_retaliation"]
        - 0.020 * scored["hierarchical_pressure"]
    )
    scored["modeled_voice_probability"] = 1.0 / (1.0 + np.exp(-voice_logit))

    scored["review_priority"] = np.select(
        [
            (scored["modeled_behavior_system_risk"] >= 70)
            | (scored["modeled_behavior_quality"] < 45),
            (scored["modeled_behavior_system_risk"] >= 50)
            | (scored["modeled_behavior_quality"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Create unit-level behavior-system summaries."""
    return (
        df.groupby("unit_id")
        .agg(
            people=("person_id", "count"),
            avg_modeled_behavior_quality=("modeled_behavior_quality", "mean"),
            avg_modeled_behavior_system_risk=("modeled_behavior_system_risk", "mean"),
            avg_voice_probability=("modeled_voice_probability", "mean"),
            voice_rate=("voice_behavior", "mean"),
            avg_capability=("capability", "mean"),
            avg_motivation=("motivation", "mean"),
            avg_role_clarity=("role_clarity", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_leadership_trust=("leadership_trust", "mean"),
            avg_cultural_norm_strength=("cultural_norm_strength", "mean"),
            avg_incentive_alignment=("incentive_alignment", "mean"),
            avg_workload_pressure=("workload_pressure", "mean"),
            avg_burnout_pressure=("burnout_pressure", "mean"),
            avg_hierarchical_pressure=("hierarchical_pressure", "mean"),
            avg_perceived_voice_efficacy=("perceived_voice_efficacy", "mean"),
            avg_fear_of_retaliation=("fear_of_retaliation", "mean"),
        )
        .reset_index()
        .sort_values("avg_modeled_behavior_system_risk", ascending=False)
    )


def fit_behavior_models(scored: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame, str, float]:
    """Fit synthetic behavior-quality models for demonstration."""
    modeled = scored.copy()
    modeled["high_behavior_quality"] = (
        modeled["modeled_behavior_quality"] > modeled["modeled_behavior_quality"].median()
    ).astype(int)

    x = modeled[BEHAVIOR_FEATURES]
    y = modeled["high_behavior_quality"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=515, stratify=y
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
            "feature": BEHAVIOR_FEATURES,
            "coefficient": classifier.named_steps["logit"].coef_[0],
        }
    ).sort_values("coefficient", ascending=False)

    regressor = LinearRegression()
    regressor.fit(modeled[BEHAVIOR_FEATURES], modeled["modeled_behavior_quality"])
    regression_coefficients = pd.DataFrame(
        {"feature": BEHAVIOR_FEATURES, "coefficient": regressor.coef_}
    ).sort_values("coefficient", ascending=False)

    return classification_coefficients, regression_coefficients, report, auc


def fit_voice_model(scored: pd.DataFrame) -> pd.DataFrame:
    """Fit a synthetic voice behavior model for demonstration only."""
    model = Pipeline(
        steps=[
            ("scale", StandardScaler()),
            ("logit", LogisticRegression(max_iter=3000)),
        ]
    )
    model.fit(scored[VOICE_FEATURES], scored["voice_behavior"])

    return pd.DataFrame(
        {
            "feature": VOICE_FEATURES,
            "coefficient": model.named_steps["logit"].coef_[0],
        }
    ).sort_values("coefficient", ascending=False)


def build_scenarios() -> pd.DataFrame:
    """Compare two transparent organizational behavior scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High-trust learning-oriented organization",
                "capability": 72,
                "motivation": 78,
                "role_clarity": 82,
                "psychological_safety": 84,
                "leadership_trust": 85,
                "cultural_norm_strength": 82,
                "incentive_alignment": 80,
                "workload_pressure": 30,
                "burnout_pressure": 24,
                "hierarchical_pressure": 22,
                "perceived_voice_efficacy": 80,
                "fear_of_retaliation": 12,
                "voice_behavior": 1,
                "unit_id": "Scenario",
                "person_id": "Scenario_A",
            },
            {
                "scenario": "Low-trust overloaded fear-based organization",
                "capability": 72,
                "motivation": 48,
                "role_clarity": 38,
                "psychological_safety": 30,
                "leadership_trust": 32,
                "cultural_norm_strength": 36,
                "incentive_alignment": 34,
                "workload_pressure": 82,
                "burnout_pressure": 78,
                "hierarchical_pressure": 76,
                "perceived_voice_efficacy": 26,
                "fear_of_retaliation": 72,
                "voice_behavior": 0,
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
            "modeled_behavior_system_risk",
            "modeled_voice_probability",
            "review_priority",
        ]
    ]


def main() -> None:
    df = load_data()
    scored = add_system_scores(df)
    scored.to_csv(TABLE_DIR / "scored_human_behavior_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_human_behavior_summary.csv", index=False)

    class_coef, reg_coef, report, auc = fit_behavior_models(scored)
    class_coef.to_csv(TABLE_DIR / "behavior_quality_classification_coefficients.csv", index=False)
    reg_coef.to_csv(TABLE_DIR / "behavior_quality_regression_coefficients.csv", index=False)

    voice_coef = fit_voice_model(scored)
    voice_coef.to_csv(TABLE_DIR / "voice_behavior_coefficients.csv", index=False)

    scenarios = build_scenarios()
    scenarios.to_csv(TABLE_DIR / "human_behavior_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic human behavior in organizations model\n")
        handle.write("================================================\n\n")
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

"""
Python Workflow: Simulating Organizational Psychology as a Multilevel Work System

Responsible-use scope:
This workflow is for synthetic-data research, methods demonstration,
institutional learning, and reproducible organizational psychology education.
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
RAW_DATA = ROOT / "data" / "raw" / "organizational_psychology_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)

FEATURES = [
    "capability",
    "motivation",
    "role_clarity",
    "autonomy",
    "fairness",
    "team_coordination",
    "leadership_trust",
    "psychological_safety",
    "communication_quality",
    "culture_strength",
    "workload_pressure",
    "burnout_pressure",
    "institutional_support",
    "voice_access",
]


def load_data() -> pd.DataFrame:
    """Load synthetic organizational psychology data."""
    return pd.read_csv(RAW_DATA)


def add_system_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Add transparent work-system scores."""
    scored = df.copy()

    scored["modeled_outcome_quality"] = (
        0.11 * scored["capability"]
        + 0.10 * scored["motivation"]
        + 0.10 * scored["role_clarity"]
        + 0.07 * scored["autonomy"]
        + 0.08 * scored["fairness"]
        + 0.09 * scored["team_coordination"]
        + 0.10 * scored["leadership_trust"]
        + 0.10 * scored["psychological_safety"]
        + 0.08 * scored["communication_quality"]
        + 0.06 * scored["culture_strength"]
        + 0.08 * scored["institutional_support"]
        + 0.06 * scored["voice_access"]
        - 0.07 * scored["workload_pressure"]
        - 0.08 * scored["burnout_pressure"]
    ).clip(0, 100)

    scored["modeled_work_system_risk"] = (
        0.08 * (100 - scored["role_clarity"])
        + 0.08 * (100 - scored["autonomy"])
        + 0.09 * (100 - scored["fairness"])
        + 0.09 * (100 - scored["team_coordination"])
        + 0.10 * (100 - scored["leadership_trust"])
        + 0.10 * (100 - scored["psychological_safety"])
        + 0.08 * (100 - scored["communication_quality"])
        + 0.07 * (100 - scored["culture_strength"])
        + 0.08 * (100 - scored["institutional_support"])
        + 0.08 * (100 - scored["voice_access"])
        + 0.12 * scored["workload_pressure"]
        + 0.13 * scored["burnout_pressure"]
    ).clip(0, 100)

    scored["review_priority"] = np.select(
        [
            (scored["modeled_work_system_risk"] >= 70)
            | (scored["modeled_outcome_quality"] < 45),
            (scored["modeled_work_system_risk"] >= 50)
            | (scored["modeled_outcome_quality"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_teams(df: pd.DataFrame) -> pd.DataFrame:
    """Create team-level system summaries."""
    return (
        df.groupby("team_id")
        .agg(
            people=("person_id", "count"),
            avg_modeled_outcome_quality=("modeled_outcome_quality", "mean"),
            avg_modeled_work_system_risk=("modeled_work_system_risk", "mean"),
            avg_capability=("capability", "mean"),
            avg_motivation=("motivation", "mean"),
            avg_role_clarity=("role_clarity", "mean"),
            avg_autonomy=("autonomy", "mean"),
            avg_fairness=("fairness", "mean"),
            avg_team_coordination=("team_coordination", "mean"),
            avg_leadership_trust=("leadership_trust", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_communication_quality=("communication_quality", "mean"),
            avg_culture_strength=("culture_strength", "mean"),
            avg_workload_pressure=("workload_pressure", "mean"),
            avg_burnout_pressure=("burnout_pressure", "mean"),
            avg_institutional_support=("institutional_support", "mean"),
            avg_voice_access=("voice_access", "mean"),
        )
        .reset_index()
        .sort_values("avg_modeled_work_system_risk", ascending=False)
    )


def fit_outcome_model(df: pd.DataFrame) -> tuple[pd.DataFrame, pd.DataFrame, str, float]:
    """Fit synthetic outcome models for demonstration."""
    modeled = df.copy()
    modeled["high_outcome_quality"] = (
        modeled["modeled_outcome_quality"] > modeled["modeled_outcome_quality"].median()
    ).astype(int)

    x = modeled[FEATURES]
    y = modeled["high_outcome_quality"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=424, stratify=y
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
    regressor.fit(modeled[FEATURES], modeled["modeled_outcome_quality"])
    regression_coefficients = pd.DataFrame(
        {"feature": FEATURES, "coefficient": regressor.coef_}
    ).sort_values("coefficient", ascending=False)

    return classification_coefficients, regression_coefficients, report, auc


def build_scenarios() -> pd.DataFrame:
    """Compare two transparent work-system scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High-trust, clear-role, psychologically safe work system",
                "capability": 72,
                "motivation": 76,
                "role_clarity": 82,
                "autonomy": 78,
                "fairness": 80,
                "team_coordination": 80,
                "leadership_trust": 84,
                "psychological_safety": 81,
                "communication_quality": 82,
                "culture_strength": 79,
                "workload_pressure": 28,
                "burnout_pressure": 25,
                "institutional_support": 82,
                "voice_access": 80,
            },
            {
                "scenario": "High-load, low-trust, ambiguous work system",
                "capability": 72,
                "motivation": 52,
                "role_clarity": 38,
                "autonomy": 36,
                "fairness": 34,
                "team_coordination": 41,
                "leadership_trust": 34,
                "psychological_safety": 33,
                "communication_quality": 37,
                "culture_strength": 35,
                "workload_pressure": 78,
                "burnout_pressure": 75,
                "institutional_support": 36,
                "voice_access": 34,
            },
        ]
    )

    scored = add_system_scores(scenarios.assign(team_id="Scenario", person_id="Scenario"))
    return scored[
        [
            "scenario",
            "modeled_outcome_quality",
            "modeled_work_system_risk",
            "review_priority",
        ]
    ]


def main() -> None:
    df = load_data()
    scored = add_system_scores(df)
    scored.to_csv(TABLE_DIR / "scored_organizational_psychology_observations.csv", index=False)

    team_summary = summarize_teams(scored)
    team_summary.to_csv(TABLE_DIR / "team_work_system_summary.csv", index=False)

    class_coef, reg_coef, report, auc = fit_outcome_model(scored)
    class_coef.to_csv(TABLE_DIR / "classification_coefficients.csv", index=False)
    reg_coef.to_csv(TABLE_DIR / "outcome_quality_regression_coefficients.csv", index=False)

    scenarios = build_scenarios()
    scenarios.to_csv(TABLE_DIR / "work_system_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic organizational psychology work-system model\n")
        handle.write("=====================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This is a synthetic methods demonstration "
            "for institutional learning. It must not be used for employee screening, "
            "employment selection, surveillance, individual performance management, "
            "productivity ranking, loyalty scoring, dissent tracking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(team_summary)
    print(scenarios)


if __name__ == "__main__":
    main()

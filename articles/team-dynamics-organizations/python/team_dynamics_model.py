"""
Team Dynamics in Organizations
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, team-system review, collaboration-system education,
communication and coordination analysis, leadership and team-design review,
and reproducible workflows. It is not an employee-screening, hiring, promotion,
compensation, discipline, termination, workplace surveillance, individual
performance-management, cultural-loyalty scoring, team-fit scoring,
collaboration scoring of workers, productivity-ranking, or psychological
assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "team_dynamics_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "communication_quality",
    "trust_level",
    "role_clarity",
    "psychological_safety",
    "leadership_support",
    "conflict_load",
    "task_ambiguity",
    "coordination_cost",
    "participation_equity",
    "learning_routine_quality",
]


def load_data() -> pd.DataFrame:
    """Load synthetic team-dynamics data."""
    return pd.read_csv(RAW_DATA)


def add_team_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create team effectiveness, team risk, and review-priority scores."""
    scored = df.copy()

    scored["team_effectiveness_score"] = (
        0.14 * scored["communication_quality"]
        + 0.12 * scored["trust_level"]
        + 0.12 * scored["role_clarity"]
        + 0.13 * scored["psychological_safety"]
        + 0.12 * scored["leadership_support"]
        + 0.11 * scored["participation_equity"]
        + 0.11 * scored["learning_routine_quality"]
        - 0.09 * scored["conflict_load"]
        - 0.08 * scored["task_ambiguity"]
        - 0.09 * scored["coordination_cost"]
    ).clip(0, 100)

    scored["team_system_risk_score"] = (
        0.11 * (100 - scored["communication_quality"])
        + 0.10 * (100 - scored["trust_level"])
        + 0.11 * (100 - scored["role_clarity"])
        + 0.12 * (100 - scored["psychological_safety"])
        + 0.10 * (100 - scored["leadership_support"])
        + 0.10 * (100 - scored["participation_equity"])
        + 0.10 * (100 - scored["learning_routine_quality"])
        + 0.12 * scored["conflict_load"]
        + 0.12 * scored["task_ambiguity"]
        + 0.12 * scored["coordination_cost"]
    ).clip(0, 100)

    scored["coordination_breakdown_score"] = (
        0.30 * scored["coordination_cost"]
        + 0.25 * scored["task_ambiguity"]
        + 0.20 * scored["conflict_load"]
        + 0.15 * (100 - scored["role_clarity"])
        + 0.10 * (100 - scored["communication_quality"])
    ).clip(0, 100)

    scored["team_review_priority"] = np.select(
        [
            (scored["team_system_risk_score"] >= 70)
            | (scored["team_effectiveness_score"] < 45)
            | (scored["symbolic_teamwork_risk"] == 1),
            (scored["team_system_risk_score"] >= 50)
            | (scored["team_effectiveness_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_teams(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize team-dynamics conditions by synthetic team."""
    return (
        df.groupby("team_id")
        .agg(
            observations=("period", "count"),
            avg_team_effectiveness=("team_effectiveness_score", "mean"),
            avg_team_system_risk=("team_system_risk_score", "mean"),
            avg_coordination_breakdown=("coordination_breakdown_score", "mean"),
            avg_communication_quality=("communication_quality", "mean"),
            avg_trust_level=("trust_level", "mean"),
            avg_role_clarity=("role_clarity", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_leadership_support=("leadership_support", "mean"),
            avg_conflict_load=("conflict_load", "mean"),
            avg_task_ambiguity=("task_ambiguity", "mean"),
            avg_coordination_cost=("coordination_cost", "mean"),
            avg_participation_equity=("participation_equity", "mean"),
            avg_learning_routine_quality=("learning_routine_quality", "mean"),
            strong_collective_performance_rate=("strong_collective_performance", "mean"),
            symbolic_teamwork_risk_rate=("symbolic_teamwork_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_team_system_risk", ascending=False)
    )


def fit_performance_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic strong-collective-performance classifier."""
    x = df[FEATURES]
    y = df["strong_collective_performance"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=222, stratify=y
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
    """Compare strong and weak synthetic team-dynamics scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Strong team dynamics",
                "communication_quality": 84,
                "trust_level": 82,
                "role_clarity": 79,
                "psychological_safety": 83,
                "leadership_support": 80,
                "conflict_load": 22,
                "task_ambiguity": 30,
                "coordination_cost": 34,
                "participation_equity": 82,
                "learning_routine_quality": 80,
            },
            {
                "scenario": "High-friction symbolic teamwork risk",
                "communication_quality": 38,
                "trust_level": 36,
                "role_clarity": 41,
                "psychological_safety": 34,
                "leadership_support": 39,
                "conflict_load": 71,
                "task_ambiguity": 68,
                "coordination_cost": 72,
                "participation_equity": 35,
                "learning_routine_quality": 33,
            },
        ]
    )

    scenarios["predicted_strong_collective_performance_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["team_system_risk_score"] = (
        0.11 * (100 - scenarios["communication_quality"])
        + 0.10 * (100 - scenarios["trust_level"])
        + 0.11 * (100 - scenarios["role_clarity"])
        + 0.12 * (100 - scenarios["psychological_safety"])
        + 0.10 * (100 - scenarios["leadership_support"])
        + 0.10 * (100 - scenarios["participation_equity"])
        + 0.10 * (100 - scenarios["learning_routine_quality"])
        + 0.12 * scenarios["conflict_load"]
        + 0.12 * scenarios["task_ambiguity"]
        + 0.12 * scenarios["coordination_cost"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_team_scores(df)

    scored.to_csv(TABLE_DIR / "scored_team_dynamics_observations.csv", index=False)

    team_summary = summarize_teams(scored)
    team_summary.to_csv(TABLE_DIR / "team_dynamics_summary.csv", index=False)

    model, coefficients, report, auc = fit_performance_model(scored)
    coefficients.to_csv(TABLE_DIR / "strong_collective_performance_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "team_dynamics_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "strong_collective_performance_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic team dynamics strong-collective-performance model\n")
        handle.write("==========================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and team-system review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, team-fit scoring, collaboration scoring of workers, "
            "productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(team_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

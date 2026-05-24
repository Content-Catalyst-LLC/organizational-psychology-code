"""
Conflict Resolution in Organizational Systems
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, conflict-system review, mediation-process education,
procedural fairness analysis, leadership and dispute-system analysis, and
reproducible workflows. It is not an employee-screening, hiring, promotion,
compensation, discipline, termination, workplace surveillance, individual
performance-management, cultural-loyalty scoring, conflict-proneness scoring,
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
RAW_DATA = ROOT / "data" / "raw" / "conflict_resolution_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "trust_level",
    "communication_clarity",
    "psychological_safety",
    "procedural_fairness",
    "integrative_skill",
    "blame_intensity",
    "power_asymmetry",
    "resource_strain",
    "mediation_access",
]


def load_data() -> pd.DataFrame:
    """Load synthetic conflict-resolution data."""
    return pd.read_csv(RAW_DATA)


def add_conflict_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create constructive conflict capacity, risk, escalation, and review-priority scores."""
    scored = df.copy()

    scored["constructive_conflict_capacity_score"] = (
        0.16 * scored["trust_level"]
        + 0.15 * scored["communication_clarity"]
        + 0.14 * scored["psychological_safety"]
        + 0.15 * scored["procedural_fairness"]
        + 0.12 * scored["integrative_skill"]
        + 0.10 * scored["mediation_access"]
        - 0.10 * scored["blame_intensity"]
        - 0.09 * scored["power_asymmetry"]
        - 0.07 * scored["resource_strain"]
    ).clip(0, 100)

    scored["conflict_risk_score"] = (
        0.13 * (100 - scored["trust_level"])
        + 0.12 * (100 - scored["communication_clarity"])
        + 0.11 * (100 - scored["psychological_safety"])
        + 0.13 * (100 - scored["procedural_fairness"])
        + 0.10 * (100 - scored["integrative_skill"])
        + 0.10 * (100 - scored["mediation_access"])
        + 0.14 * scored["blame_intensity"]
        + 0.13 * scored["power_asymmetry"]
        + 0.14 * scored["resource_strain"]
    ).clip(0, 100)

    scored["escalation_pressure_score"] = (
        0.28 * scored["blame_intensity"]
        + 0.25 * scored["power_asymmetry"]
        + 0.22 * scored["resource_strain"]
        + 0.15 * (100 - scored["communication_clarity"])
        + 0.10 * (100 - scored["procedural_fairness"])
    ).clip(0, 100)

    scored["conflict_review_priority"] = np.select(
        [
            (scored["conflict_risk_score"] >= 70)
            | (scored["constructive_conflict_capacity_score"] < 45)
            | (scored["symbolic_resolution_risk"] == 1),
            (scored["conflict_risk_score"] >= 50)
            | (scored["constructive_conflict_capacity_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_teams(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize conflict-system conditions by synthetic team."""
    return (
        df.groupby("team_id")
        .agg(
            observations=("period", "count"),
            avg_constructive_conflict_capacity=("constructive_conflict_capacity_score", "mean"),
            avg_conflict_risk=("conflict_risk_score", "mean"),
            avg_escalation_pressure=("escalation_pressure_score", "mean"),
            avg_trust=("trust_level", "mean"),
            avg_communication_clarity=("communication_clarity", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_procedural_fairness=("procedural_fairness", "mean"),
            avg_integrative_skill=("integrative_skill", "mean"),
            avg_blame_intensity=("blame_intensity", "mean"),
            avg_power_asymmetry=("power_asymmetry", "mean"),
            avg_resource_strain=("resource_strain", "mean"),
            avg_mediation_access=("mediation_access", "mean"),
            collaborative_resolution_rate=("collaborative_resolution", "mean"),
            symbolic_resolution_risk_rate=("symbolic_resolution_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_conflict_risk", ascending=False)
    )


def fit_resolution_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic collaborative-resolution classifier."""
    x = df[FEATURES]
    y = df["collaborative_resolution"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=626, stratify=y
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
    """Compare constructive and destructive synthetic conflict-system scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Constructive conflict system",
                "trust_level": 82,
                "communication_clarity": 80,
                "psychological_safety": 81,
                "procedural_fairness": 83,
                "integrative_skill": 76,
                "blame_intensity": 18,
                "power_asymmetry": 22,
                "resource_strain": 45,
                "mediation_access": 84,
            },
            {
                "scenario": "High-escalation symbolic resolution risk",
                "trust_level": 33,
                "communication_clarity": 36,
                "psychological_safety": 34,
                "procedural_fairness": 31,
                "integrative_skill": 38,
                "blame_intensity": 73,
                "power_asymmetry": 70,
                "resource_strain": 68,
                "mediation_access": 32,
            },
        ]
    )

    scenarios["predicted_collaborative_resolution_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["conflict_risk_score"] = (
        0.13 * (100 - scenarios["trust_level"])
        + 0.12 * (100 - scenarios["communication_clarity"])
        + 0.11 * (100 - scenarios["psychological_safety"])
        + 0.13 * (100 - scenarios["procedural_fairness"])
        + 0.10 * (100 - scenarios["integrative_skill"])
        + 0.10 * (100 - scenarios["mediation_access"])
        + 0.14 * scenarios["blame_intensity"]
        + 0.13 * scenarios["power_asymmetry"]
        + 0.14 * scenarios["resource_strain"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_conflict_scores(df)

    scored.to_csv(TABLE_DIR / "scored_conflict_resolution_observations.csv", index=False)

    team_summary = summarize_teams(scored)
    team_summary.to_csv(TABLE_DIR / "team_conflict_resolution_summary.csv", index=False)

    model, coefficients, report, auc = fit_resolution_model(scored)
    coefficients.to_csv(TABLE_DIR / "collaborative_resolution_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "conflict_resolution_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "collaborative_resolution_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic conflict resolution collaborative-resolution model\n")
        handle.write("==========================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and conflict-system review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, conflict-proneness scoring, collaboration scoring "
            "of workers, productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(team_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

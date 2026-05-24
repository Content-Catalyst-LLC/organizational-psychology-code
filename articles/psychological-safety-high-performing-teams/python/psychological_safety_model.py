"""
Psychological Safety in High-Performing Teams
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, team-learning review, psychological safety education,
leadership and voice-system analysis, and reproducible workflows. It is not an
employee-screening, hiring, promotion, compensation, discipline, termination,
workplace surveillance, individual performance-management, cultural-loyalty
scoring, courage scoring, voice scoring of workers, productivity-ranking, or
psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "psychological_safety_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "leadership_openness",
    "inclusion_quality",
    "learning_review_quality",
    "knowledge_sharing",
    "blame_intensity",
    "status_asymmetry",
    "perceived_penalty",
    "workload_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic psychological-safety data."""
    return pd.read_csv(RAW_DATA)


def add_safety_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create psychological safety, safety risk, and review-priority scores."""
    scored = df.copy()

    scored["psychological_safety_score"] = (
        0.18 * scored["leadership_openness"]
        + 0.16 * scored["inclusion_quality"]
        + 0.15 * scored["learning_review_quality"]
        + 0.14 * scored["knowledge_sharing"]
        - 0.13 * scored["blame_intensity"]
        - 0.11 * scored["status_asymmetry"]
        - 0.10 * scored["perceived_penalty"]
        - 0.06 * scored["workload_pressure"]
    ).clip(0, 100)

    scored["safety_risk_score"] = (
        0.15 * (100 - scored["leadership_openness"])
        + 0.13 * (100 - scored["inclusion_quality"])
        + 0.12 * (100 - scored["learning_review_quality"])
        + 0.12 * (100 - scored["knowledge_sharing"])
        + 0.14 * scored["blame_intensity"]
        + 0.12 * scored["status_asymmetry"]
        + 0.14 * scored["perceived_penalty"]
        + 0.08 * scored["workload_pressure"]
    ).clip(0, 100)

    scored["safety_review_priority"] = np.select(
        [
            (scored["safety_risk_score"] >= 70)
            | (scored["psychological_safety_score"] < 45)
            | (scored["symbolic_voice_risk"] == 1),
            (scored["safety_risk_score"] >= 50)
            | (scored["psychological_safety_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_teams(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize psychological-safety conditions by synthetic team."""
    return (
        df.groupby("team_id")
        .agg(
            observations=("period", "count"),
            avg_psychological_safety=("psychological_safety_score", "mean"),
            avg_safety_risk=("safety_risk_score", "mean"),
            avg_leadership_openness=("leadership_openness", "mean"),
            avg_inclusion_quality=("inclusion_quality", "mean"),
            avg_learning_review_quality=("learning_review_quality", "mean"),
            avg_knowledge_sharing=("knowledge_sharing", "mean"),
            avg_blame_intensity=("blame_intensity", "mean"),
            avg_status_asymmetry=("status_asymmetry", "mean"),
            avg_perceived_penalty=("perceived_penalty", "mean"),
            avg_workload_pressure=("workload_pressure", "mean"),
            strong_team_performance_rate=("strong_team_performance", "mean"),
            symbolic_voice_risk_rate=("symbolic_voice_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_safety_risk", ascending=False)
    )


def fit_team_performance_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic strong-team-performance classifier."""
    x = df[FEATURES]
    y = df["strong_team_performance"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=707, stratify=y
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
    """Compare two synthetic psychological-safety scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High-safety learning-oriented team",
                "leadership_openness": 84,
                "inclusion_quality": 82,
                "learning_review_quality": 80,
                "knowledge_sharing": 81,
                "blame_intensity": 16,
                "status_asymmetry": 20,
                "perceived_penalty": 18,
                "workload_pressure": 52,
            },
            {
                "scenario": "Low-safety blame-intensive team",
                "leadership_openness": 34,
                "inclusion_quality": 38,
                "learning_review_quality": 36,
                "knowledge_sharing": 39,
                "blame_intensity": 72,
                "status_asymmetry": 69,
                "perceived_penalty": 74,
                "workload_pressure": 52,
            },
        ]
    )

    scenarios["predicted_strong_team_performance_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["safety_risk_score"] = (
        0.15 * (100 - scenarios["leadership_openness"])
        + 0.13 * (100 - scenarios["inclusion_quality"])
        + 0.12 * (100 - scenarios["learning_review_quality"])
        + 0.12 * (100 - scenarios["knowledge_sharing"])
        + 0.14 * scenarios["blame_intensity"]
        + 0.12 * scenarios["status_asymmetry"]
        + 0.14 * scenarios["perceived_penalty"]
        + 0.08 * scenarios["workload_pressure"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_safety_scores(df)

    scored.to_csv(TABLE_DIR / "scored_psychological_safety_observations.csv", index=False)

    team_summary = summarize_teams(scored)
    team_summary.to_csv(TABLE_DIR / "team_psychological_safety_summary.csv", index=False)

    model, coefficients, report, auc = fit_team_performance_model(scored)
    coefficients.to_csv(TABLE_DIR / "team_performance_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "psychological_safety_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "team_performance_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic psychological safety team-performance model\n")
        handle.write("=====================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and team-safety review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, courage scoring, voice scoring of workers, "
            "productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(team_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

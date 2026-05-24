"""
Goal Setting and Performance Systems
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, goal-system review, performance-system education,
feedback-quality analysis, metric-governance review, strategic-alignment
analysis, and reproducible workflows. It is not an employee-screening, hiring,
promotion, compensation, discipline, termination, workplace surveillance,
individual performance-management, productivity-ranking, goal-compliance
scoring, cultural-loyalty scoring, or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "goal_system_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "goal_clarity",
    "goal_challenge",
    "feedback_quality",
    "employee_commitment",
    "strategic_alignment",
    "overload_pressure",
    "metric_distortion",
    "incentive_misalignment",
    "review_quality",
    "proxy_drift",
    "goal_feasibility",
]


def load_data() -> pd.DataFrame:
    """Load synthetic goal-system data."""
    return pd.read_csv(RAW_DATA)


def add_goal_system_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create goal-system effectiveness, risk, and review-priority scores."""
    scored = df.copy()

    scored["goal_system_effectiveness_score"] = (
        0.13 * scored["goal_clarity"]
        + 0.10 * scored["goal_challenge"]
        + 0.13 * scored["feedback_quality"]
        + 0.11 * scored["employee_commitment"]
        + 0.13 * scored["strategic_alignment"]
        + 0.11 * scored["review_quality"]
        + 0.11 * scored["goal_feasibility"]
        - 0.07 * scored["overload_pressure"]
        - 0.06 * scored["metric_distortion"]
        - 0.05 * scored["incentive_misalignment"]
        - 0.04 * scored["proxy_drift"]
    ).clip(0, 100)

    scored["goal_system_risk_score"] = (
        0.12 * (100 - scored["goal_clarity"])
        + 0.08 * (100 - scored["goal_challenge"])
        + 0.13 * (100 - scored["feedback_quality"])
        + 0.10 * (100 - scored["employee_commitment"])
        + 0.13 * (100 - scored["strategic_alignment"])
        + 0.10 * (100 - scored["review_quality"])
        + 0.10 * (100 - scored["goal_feasibility"])
        + 0.11 * scored["overload_pressure"]
        + 0.09 * scored["metric_distortion"]
        + 0.08 * scored["incentive_misalignment"]
        + 0.06 * scored["proxy_drift"]
    ).clip(0, 100)

    scored["metric_governance_risk_score"] = (
        0.28 * scored["metric_distortion"]
        + 0.26 * scored["proxy_drift"]
        + 0.20 * scored["incentive_misalignment"]
        + 0.14 * (100 - scored["review_quality"])
        + 0.12 * scored["metric_gaming_risk"] * 100
    ).clip(0, 100)

    scored["goal_review_priority"] = np.select(
        [
            (scored["goal_system_risk_score"] >= 70)
            | (scored["goal_system_effectiveness_score"] < 45)
            | (scored["performance_risk"] == 1)
            | (scored["symbolic_alignment_risk"] == 1),
            (scored["goal_system_risk_score"] >= 50)
            | (scored["goal_system_effectiveness_score"] < 60)
            | (scored["metric_governance_risk_score"] >= 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize goal-system conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_goal_system_effectiveness=("goal_system_effectiveness_score", "mean"),
            avg_goal_system_risk=("goal_system_risk_score", "mean"),
            avg_metric_governance_risk=("metric_governance_risk_score", "mean"),
            avg_goal_clarity=("goal_clarity", "mean"),
            avg_goal_challenge=("goal_challenge", "mean"),
            avg_feedback_quality=("feedback_quality", "mean"),
            avg_employee_commitment=("employee_commitment", "mean"),
            avg_strategic_alignment=("strategic_alignment", "mean"),
            avg_overload_pressure=("overload_pressure", "mean"),
            avg_metric_distortion=("metric_distortion", "mean"),
            avg_incentive_misalignment=("incentive_misalignment", "mean"),
            avg_review_quality=("review_quality", "mean"),
            avg_proxy_drift=("proxy_drift", "mean"),
            avg_goal_feasibility=("goal_feasibility", "mean"),
            performance_risk_rate=("performance_risk", "mean"),
            metric_gaming_risk_rate=("metric_gaming_risk", "mean"),
            symbolic_alignment_risk_rate=("symbolic_alignment_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_goal_system_risk", ascending=False)
    )


def fit_performance_risk_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic performance-risk classifier."""
    x = df[FEATURES]
    y = df["performance_risk"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=323, stratify=y
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


def fit_effectiveness_model(df: pd.DataFrame) -> pd.DataFrame:
    """Fit a simple synthetic goal-system effectiveness model for interpretation."""
    predictors = [
        "goal_clarity",
        "goal_challenge",
        "feedback_quality",
        "employee_commitment",
        "strategic_alignment",
        "review_quality",
        "goal_feasibility",
        "overload_pressure",
        "metric_distortion",
        "incentive_misalignment",
        "proxy_drift",
    ]
    model = LinearRegression()
    model.fit(df[predictors], df["goal_system_effectiveness_score"])
    return pd.DataFrame({"feature": predictors, "coefficient": model.coef_}).sort_values(
        "coefficient", ascending=False
    )


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare high-quality and high-risk synthetic goal-system scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Clear, aligned, and well-governed goal system",
                "goal_clarity": 84,
                "goal_challenge": 78,
                "feedback_quality": 82,
                "employee_commitment": 79,
                "strategic_alignment": 83,
                "overload_pressure": 22,
                "metric_distortion": 18,
                "incentive_misalignment": 16,
                "review_quality": 82,
                "proxy_drift": 15,
                "goal_feasibility": 80,
            },
            {
                "scenario": "High-pressure metric-distortion risk",
                "goal_clarity": 38,
                "goal_challenge": 41,
                "feedback_quality": 36,
                "employee_commitment": 39,
                "strategic_alignment": 40,
                "overload_pressure": 74,
                "metric_distortion": 69,
                "incentive_misalignment": 72,
                "review_quality": 34,
                "proxy_drift": 68,
                "goal_feasibility": 32,
            },
        ]
    )

    scenarios["predicted_performance_risk_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["goal_system_risk_score"] = (
        0.12 * (100 - scenarios["goal_clarity"])
        + 0.08 * (100 - scenarios["goal_challenge"])
        + 0.13 * (100 - scenarios["feedback_quality"])
        + 0.10 * (100 - scenarios["employee_commitment"])
        + 0.13 * (100 - scenarios["strategic_alignment"])
        + 0.10 * (100 - scenarios["review_quality"])
        + 0.10 * (100 - scenarios["goal_feasibility"])
        + 0.11 * scenarios["overload_pressure"]
        + 0.09 * scenarios["metric_distortion"]
        + 0.08 * scenarios["incentive_misalignment"]
        + 0.06 * scenarios["proxy_drift"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_goal_system_scores(df)

    scored.to_csv(TABLE_DIR / "scored_goal_system_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_goal_system_summary.csv", index=False)

    model, coefficients, report, auc = fit_performance_risk_model(scored)
    coefficients.to_csv(TABLE_DIR / "performance_risk_coefficients.csv", index=False)

    effectiveness_coefficients = fit_effectiveness_model(scored)
    effectiveness_coefficients.to_csv(TABLE_DIR / "goal_system_effectiveness_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "goal_system_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "performance_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic goal system performance-risk model\n")
        handle.write("============================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and goal-system review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, productivity "
            "ranking, goal-compliance scoring, cultural loyalty scoring, or "
            "psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

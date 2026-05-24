"""
Incentives and Workplace Behavior
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, incentive-system review, reward-governance education,
fairness and metric-distortion analysis, ethical-risk review, cooperation and
culture review, and reproducible workflows. It is not an employee-screening,
hiring, promotion, compensation, discipline, termination, workplace surveillance,
individual performance-management, productivity-ranking, incentive-compliance
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
RAW_DATA = ROOT / "data" / "raw" / "incentive_system_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "expectancy_strength",
    "fairness_perception",
    "strategic_alignment",
    "intrinsic_support",
    "feedback_clarity",
    "distortion_risk",
    "overload_pressure",
    "ethical_risk",
    "cooperation_support",
    "recognition_legitimacy",
    "reward_transparency",
    "hidden_labor_recognition",
]


def load_data() -> pd.DataFrame:
    """Load synthetic incentive-system data."""
    return pd.read_csv(RAW_DATA)


def add_incentive_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create incentive effectiveness, risk, and review-priority scores."""
    scored = df.copy()

    scored["incentive_effectiveness_score"] = (
        0.12 * scored["expectancy_strength"]
        + 0.13 * scored["fairness_perception"]
        + 0.12 * scored["strategic_alignment"]
        + 0.10 * scored["intrinsic_support"]
        + 0.11 * scored["feedback_clarity"]
        + 0.10 * scored["cooperation_support"]
        + 0.10 * scored["recognition_legitimacy"]
        + 0.09 * scored["reward_transparency"]
        + 0.08 * scored["hidden_labor_recognition"]
        - 0.08 * scored["distortion_risk"]
        - 0.07 * scored["overload_pressure"]
        - 0.08 * scored["ethical_risk"]
    ).clip(0, 100)

    scored["incentive_system_risk_score"] = (
        0.10 * (100 - scored["expectancy_strength"])
        + 0.13 * (100 - scored["fairness_perception"])
        + 0.11 * (100 - scored["strategic_alignment"])
        + 0.09 * (100 - scored["intrinsic_support"])
        + 0.10 * (100 - scored["feedback_clarity"])
        + 0.09 * (100 - scored["cooperation_support"])
        + 0.08 * (100 - scored["recognition_legitimacy"])
        + 0.08 * (100 - scored["reward_transparency"])
        + 0.07 * (100 - scored["hidden_labor_recognition"])
        + 0.10 * scored["distortion_risk"]
        + 0.08 * scored["overload_pressure"]
        + 0.07 * scored["ethical_risk"]
    ).clip(0, 100)

    scored["reward_governance_risk_score"] = (
        0.25 * scored["distortion_risk"]
        + 0.22 * scored["ethical_risk"]
        + 0.18 * scored["overload_pressure"]
        + 0.14 * (100 - scored["reward_transparency"])
        + 0.12 * (100 - scored["fairness_perception"])
        + 0.09 * scored["incentive_gaming_risk"] * 100
    ).clip(0, 100)

    scored["incentive_review_priority"] = np.select(
        [
            (scored["incentive_system_risk_score"] >= 70)
            | (scored["incentive_effectiveness_score"] < 45)
            | (scored["performance_risk"] == 1)
            | (scored["symbolic_reward_risk"] == 1),
            (scored["incentive_system_risk_score"] >= 50)
            | (scored["incentive_effectiveness_score"] < 60)
            | (scored["reward_governance_risk_score"] >= 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize incentive-system conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_incentive_effectiveness=("incentive_effectiveness_score", "mean"),
            avg_incentive_system_risk=("incentive_system_risk_score", "mean"),
            avg_reward_governance_risk=("reward_governance_risk_score", "mean"),
            avg_expectancy_strength=("expectancy_strength", "mean"),
            avg_fairness_perception=("fairness_perception", "mean"),
            avg_strategic_alignment=("strategic_alignment", "mean"),
            avg_intrinsic_support=("intrinsic_support", "mean"),
            avg_feedback_clarity=("feedback_clarity", "mean"),
            avg_distortion_risk=("distortion_risk", "mean"),
            avg_overload_pressure=("overload_pressure", "mean"),
            avg_ethical_risk=("ethical_risk", "mean"),
            avg_cooperation_support=("cooperation_support", "mean"),
            avg_recognition_legitimacy=("recognition_legitimacy", "mean"),
            avg_reward_transparency=("reward_transparency", "mean"),
            avg_hidden_labor_recognition=("hidden_labor_recognition", "mean"),
            performance_risk_rate=("performance_risk", "mean"),
            incentive_gaming_risk_rate=("incentive_gaming_risk", "mean"),
            symbolic_reward_risk_rate=("symbolic_reward_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_incentive_system_risk", ascending=False)
    )


def fit_performance_risk_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic performance-risk classifier."""
    x = df[FEATURES]
    y = df["performance_risk"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=535, stratify=y
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
    """Fit a simple synthetic incentive-effectiveness model for interpretation."""
    predictors = [
        "expectancy_strength",
        "fairness_perception",
        "strategic_alignment",
        "intrinsic_support",
        "feedback_clarity",
        "cooperation_support",
        "recognition_legitimacy",
        "reward_transparency",
        "hidden_labor_recognition",
        "distortion_risk",
        "overload_pressure",
        "ethical_risk",
    ]
    model = LinearRegression()
    model.fit(df[predictors], df["incentive_effectiveness_score"])
    return pd.DataFrame({"feature": predictors, "coefficient": model.coef_}).sort_values(
        "coefficient", ascending=False
    )


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare high-quality and high-risk synthetic incentive-system scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Fair, aligned, and low-distortion incentive system",
                "expectancy_strength": 83,
                "fairness_perception": 81,
                "strategic_alignment": 82,
                "intrinsic_support": 79,
                "feedback_clarity": 80,
                "distortion_risk": 18,
                "overload_pressure": 24,
                "ethical_risk": 16,
                "cooperation_support": 82,
                "recognition_legitimacy": 80,
                "reward_transparency": 81,
                "hidden_labor_recognition": 78,
            },
            {
                "scenario": "High-pressure incentive distortion risk",
                "expectancy_strength": 39,
                "fairness_perception": 34,
                "strategic_alignment": 41,
                "intrinsic_support": 36,
                "feedback_clarity": 38,
                "distortion_risk": 72,
                "overload_pressure": 70,
                "ethical_risk": 71,
                "cooperation_support": 35,
                "recognition_legitimacy": 33,
                "reward_transparency": 34,
                "hidden_labor_recognition": 31,
            },
        ]
    )

    scenarios["predicted_performance_risk_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["incentive_system_risk_score"] = (
        0.10 * (100 - scenarios["expectancy_strength"])
        + 0.13 * (100 - scenarios["fairness_perception"])
        + 0.11 * (100 - scenarios["strategic_alignment"])
        + 0.09 * (100 - scenarios["intrinsic_support"])
        + 0.10 * (100 - scenarios["feedback_clarity"])
        + 0.09 * (100 - scenarios["cooperation_support"])
        + 0.08 * (100 - scenarios["recognition_legitimacy"])
        + 0.08 * (100 - scenarios["reward_transparency"])
        + 0.07 * (100 - scenarios["hidden_labor_recognition"])
        + 0.10 * scenarios["distortion_risk"]
        + 0.08 * scenarios["overload_pressure"]
        + 0.07 * scenarios["ethical_risk"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_incentive_scores(df)

    scored.to_csv(TABLE_DIR / "scored_incentive_system_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_incentive_system_summary.csv", index=False)

    model, coefficients, report, auc = fit_performance_risk_model(scored)
    coefficients.to_csv(TABLE_DIR / "performance_risk_coefficients.csv", index=False)

    effectiveness_coefficients = fit_effectiveness_model(scored)
    effectiveness_coefficients.to_csv(TABLE_DIR / "incentive_effectiveness_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "incentive_system_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "performance_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic incentive system performance-risk model\n")
        handle.write("================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and incentive-system review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, productivity "
            "ranking, incentive-compliance scoring, cultural loyalty scoring, or "
            "psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

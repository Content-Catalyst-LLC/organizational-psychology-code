"""
Employee Motivation in Organizations
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, motivational-systems review, work-design education,
autonomy/fairness/trust/workload analysis, leadership and culture review, and
reproducible workflows. It is not an employee-screening, hiring, promotion,
compensation, discipline, termination, workplace surveillance, individual
performance-management, productivity-ranking, motivation scoring, loyalty
scoring, or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "motivation_system_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "autonomy_support",
    "competence_development",
    "recognition_quality",
    "institutional_trust",
    "goal_clarity",
    "fairness_perception",
    "workload_strain",
    "control_pressure",
    "relatedness",
    "meaningful_work",
    "psychological_safety",
    "leadership_credibility",
]


def load_data() -> pd.DataFrame:
    """Load synthetic motivational-system data."""
    return pd.read_csv(RAW_DATA)


def add_motivation_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create motivation quality, adaptive capacity, risk, and review-priority scores."""
    scored = df.copy()

    scored["motivation_quality_score"] = (
        0.12 * scored["autonomy_support"]
        + 0.11 * scored["competence_development"]
        + 0.10 * scored["recognition_quality"]
        + 0.12 * scored["institutional_trust"]
        + 0.10 * scored["goal_clarity"]
        + 0.11 * scored["fairness_perception"]
        + 0.10 * scored["relatedness"]
        + 0.11 * scored["meaningful_work"]
        + 0.10 * scored["psychological_safety"]
        + 0.10 * scored["leadership_credibility"]
        - 0.08 * scored["workload_strain"]
        - 0.07 * scored["control_pressure"]
    ).clip(0, 100)

    scored["adaptive_motivation_capacity_score"] = (
        0.18 * scored["motivation_quality_score"]
        + 0.12 * scored["autonomy_support"]
        + 0.12 * scored["competence_development"]
        + 0.13 * scored["institutional_trust"]
        + 0.11 * scored["goal_clarity"]
        + 0.12 * scored["psychological_safety"]
        + 0.10 * scored["leadership_credibility"]
        + 0.08 * scored["meaningful_work"]
        + 0.04 * scored["relatedness"]
    ).clip(0, 100)

    scored["motivation_system_risk_score"] = (
        0.10 * (100 - scored["autonomy_support"])
        + 0.09 * (100 - scored["competence_development"])
        + 0.08 * (100 - scored["recognition_quality"])
        + 0.12 * (100 - scored["institutional_trust"])
        + 0.08 * (100 - scored["goal_clarity"])
        + 0.11 * (100 - scored["fairness_perception"])
        + 0.08 * (100 - scored["relatedness"])
        + 0.09 * (100 - scored["meaningful_work"])
        + 0.10 * (100 - scored["psychological_safety"])
        + 0.09 * (100 - scored["leadership_credibility"])
        + 0.11 * scored["workload_strain"]
        + 0.10 * scored["control_pressure"]
    ).clip(0, 100)

    scored["burnout_control_risk_score"] = (
        0.30 * scored["workload_strain"]
        + 0.25 * scored["control_pressure"]
        + 0.15 * (100 - scored["autonomy_support"])
        + 0.12 * (100 - scored["psychological_safety"])
        + 0.10 * scored["burnout_risk"] * 100
        + 0.08 * scored["controlled_motivation_risk"] * 100
    ).clip(0, 100)

    scored["motivation_review_priority"] = np.select(
        [
            (scored["motivation_system_risk_score"] >= 70)
            | (scored["motivation_quality_score"] < 45)
            | (scored["performance_risk"] == 1)
            | (scored["burnout_risk"] == 1)
            | (scored["controlled_motivation_risk"] == 1),
            (scored["motivation_system_risk_score"] >= 50)
            | (scored["motivation_quality_score"] < 60)
            | (scored["burnout_control_risk_score"] >= 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize motivational-system conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_motivation_quality=("motivation_quality_score", "mean"),
            avg_adaptive_motivation_capacity=("adaptive_motivation_capacity_score", "mean"),
            avg_motivation_system_risk=("motivation_system_risk_score", "mean"),
            avg_burnout_control_risk=("burnout_control_risk_score", "mean"),
            avg_autonomy_support=("autonomy_support", "mean"),
            avg_competence_development=("competence_development", "mean"),
            avg_recognition_quality=("recognition_quality", "mean"),
            avg_institutional_trust=("institutional_trust", "mean"),
            avg_goal_clarity=("goal_clarity", "mean"),
            avg_fairness_perception=("fairness_perception", "mean"),
            avg_workload_strain=("workload_strain", "mean"),
            avg_control_pressure=("control_pressure", "mean"),
            avg_relatedness=("relatedness", "mean"),
            avg_meaningful_work=("meaningful_work", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_leadership_credibility=("leadership_credibility", "mean"),
            performance_risk_rate=("performance_risk", "mean"),
            burnout_risk_rate=("burnout_risk", "mean"),
            controlled_motivation_risk_rate=("controlled_motivation_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_motivation_system_risk", ascending=False)
    )


def fit_performance_risk_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic performance-risk classifier."""
    x = df[FEATURES]
    y = df["performance_risk"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=242, stratify=y
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


def fit_motivation_quality_model(df: pd.DataFrame) -> pd.DataFrame:
    """Fit a simple synthetic motivation-quality model for interpretation."""
    predictors = [
        "autonomy_support",
        "competence_development",
        "recognition_quality",
        "institutional_trust",
        "goal_clarity",
        "fairness_perception",
        "relatedness",
        "meaningful_work",
        "psychological_safety",
        "leadership_credibility",
        "workload_strain",
        "control_pressure",
    ]
    model = LinearRegression()
    model.fit(df[predictors], df["motivation_quality_score"])
    return pd.DataFrame({"feature": predictors, "coefficient": model.coef_}).sort_values(
        "coefficient", ascending=False
    )


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare healthy and high-risk synthetic motivational-system scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Autonomy-supported, trust-based motivational environment",
                "autonomy_support": 84,
                "competence_development": 80,
                "recognition_quality": 79,
                "institutional_trust": 82,
                "goal_clarity": 83,
                "fairness_perception": 81,
                "workload_strain": 22,
                "control_pressure": 18,
                "relatedness": 82,
                "meaningful_work": 84,
                "psychological_safety": 80,
                "leadership_credibility": 82,
            },
            {
                "scenario": "Controlled, strained, low-trust motivational environment",
                "autonomy_support": 34,
                "competence_development": 39,
                "recognition_quality": 36,
                "institutional_trust": 31,
                "goal_clarity": 40,
                "fairness_perception": 35,
                "workload_strain": 73,
                "control_pressure": 71,
                "relatedness": 37,
                "meaningful_work": 38,
                "psychological_safety": 34,
                "leadership_credibility": 33,
            },
        ]
    )

    scenarios["predicted_performance_risk_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["motivation_system_risk_score"] = (
        0.10 * (100 - scenarios["autonomy_support"])
        + 0.09 * (100 - scenarios["competence_development"])
        + 0.08 * (100 - scenarios["recognition_quality"])
        + 0.12 * (100 - scenarios["institutional_trust"])
        + 0.08 * (100 - scenarios["goal_clarity"])
        + 0.11 * (100 - scenarios["fairness_perception"])
        + 0.08 * (100 - scenarios["relatedness"])
        + 0.09 * (100 - scenarios["meaningful_work"])
        + 0.10 * (100 - scenarios["psychological_safety"])
        + 0.09 * (100 - scenarios["leadership_credibility"])
        + 0.11 * scenarios["workload_strain"]
        + 0.10 * scenarios["control_pressure"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_motivation_scores(df)

    scored.to_csv(TABLE_DIR / "scored_motivation_system_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_motivation_system_summary.csv", index=False)

    model, coefficients, report, auc = fit_performance_risk_model(scored)
    coefficients.to_csv(TABLE_DIR / "performance_risk_coefficients.csv", index=False)

    motivation_coefficients = fit_motivation_quality_model(scored)
    motivation_coefficients.to_csv(TABLE_DIR / "motivation_quality_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "motivation_system_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "performance_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic motivation system performance-risk model\n")
        handle.write("=================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and motivational-system review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, productivity "
            "ranking, motivation scoring, loyalty scoring, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

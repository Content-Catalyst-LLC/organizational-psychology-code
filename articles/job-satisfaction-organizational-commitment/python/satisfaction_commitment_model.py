"""
Job Satisfaction and Organizational Commitment
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, work-attitude review, retention-system education,
fairness and workload analysis, leadership and culture review, and reproducible
workflows. It is not an employee-screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance-
management, cultural-loyalty scoring, commitment scoring of workers, retention-
risk scoring of individual workers, productivity-ranking, or psychological
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
RAW_DATA = ROOT / "data" / "raw" / "satisfaction_commitment_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "leadership_support",
    "reward_fairness",
    "developmental_opportunity",
    "workload_balance",
    "institutional_trust",
    "cultural_alignment",
    "role_insecurity",
    "exhaustion_pressure",
    "affective_commitment",
    "continuance_commitment",
    "normative_commitment",
]


def load_data() -> pd.DataFrame:
    """Load synthetic satisfaction and commitment data."""
    return pd.read_csv(RAW_DATA)


def add_work_attitude_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create satisfaction, commitment, attachment, and retention-system risk scores."""
    scored = df.copy()

    scored["job_satisfaction_score"] = (
        0.16 * scored["leadership_support"]
        + 0.15 * scored["reward_fairness"]
        + 0.13 * scored["developmental_opportunity"]
        + 0.14 * scored["workload_balance"]
        + 0.13 * scored["institutional_trust"]
        + 0.10 * scored["cultural_alignment"]
        - 0.09 * scored["role_insecurity"]
        - 0.10 * scored["exhaustion_pressure"]
    ).clip(0, 100)

    scored["organizational_commitment_score"] = (
        0.18 * scored["affective_commitment"]
        + 0.12 * scored["normative_commitment"]
        + 0.13 * scored["institutional_trust"]
        + 0.11 * scored["cultural_alignment"]
        + 0.10 * scored["leadership_support"]
        + 0.08 * scored["developmental_opportunity"]
        - 0.08 * scored["role_insecurity"]
        - 0.08 * scored["exhaustion_pressure"]
        - 0.04 * scored["continuance_commitment"]
    ).clip(0, 100)

    scored["healthy_attachment_score"] = (
        0.25 * scored["job_satisfaction_score"]
        + 0.30 * scored["organizational_commitment_score"]
        + 0.18 * scored["institutional_trust"]
        + 0.12 * scored["workload_balance"]
        + 0.15 * scored["developmental_opportunity"]
    ).clip(0, 100)

    scored["retention_system_risk_score"] = (
        0.13 * (100 - scored["job_satisfaction_score"])
        + 0.14 * (100 - scored["organizational_commitment_score"])
        + 0.11 * (100 - scored["institutional_trust"])
        + 0.10 * (100 - scored["reward_fairness"])
        + 0.10 * (100 - scored["workload_balance"])
        + 0.12 * scored["role_insecurity"]
        + 0.14 * scored["exhaustion_pressure"]
        + 0.08 * scored["continuance_commitment"]
        + 0.08 * scored["symbolic_commitment_risk"] * 100
    ).clip(0, 100)

    scored["work_attitude_review_priority"] = np.select(
        [
            (scored["retention_system_risk_score"] >= 70)
            | (scored["healthy_attachment_score"] < 45)
            | (scored["high_retention_risk"] == 1)
            | (scored["symbolic_commitment_risk"] == 1),
            (scored["retention_system_risk_score"] >= 50)
            | (scored["healthy_attachment_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize work-attitude and retention-system conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_job_satisfaction=("job_satisfaction_score", "mean"),
            avg_organizational_commitment=("organizational_commitment_score", "mean"),
            avg_healthy_attachment=("healthy_attachment_score", "mean"),
            avg_retention_system_risk=("retention_system_risk_score", "mean"),
            avg_leadership_support=("leadership_support", "mean"),
            avg_reward_fairness=("reward_fairness", "mean"),
            avg_developmental_opportunity=("developmental_opportunity", "mean"),
            avg_workload_balance=("workload_balance", "mean"),
            avg_institutional_trust=("institutional_trust", "mean"),
            avg_cultural_alignment=("cultural_alignment", "mean"),
            avg_role_insecurity=("role_insecurity", "mean"),
            avg_exhaustion_pressure=("exhaustion_pressure", "mean"),
            avg_affective_commitment=("affective_commitment", "mean"),
            avg_continuance_commitment=("continuance_commitment", "mean"),
            avg_normative_commitment=("normative_commitment", "mean"),
            high_retention_risk_rate=("high_retention_risk", "mean"),
            symbolic_commitment_risk_rate=("symbolic_commitment_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_retention_system_risk", ascending=False)
    )


def fit_retention_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic high-retention-risk classifier."""
    x = df[FEATURES]
    y = df["high_retention_risk"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=414, stratify=y
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


def fit_commitment_model(df: pd.DataFrame) -> pd.DataFrame:
    """Fit a simple synthetic commitment model for interpretation."""
    predictors = [
        "job_satisfaction_score",
        "institutional_trust",
        "cultural_alignment",
        "leadership_support",
        "role_insecurity",
        "exhaustion_pressure",
    ]
    model = LinearRegression()
    model.fit(df[predictors], df["organizational_commitment_score"])
    return pd.DataFrame({"feature": predictors, "coefficient": model.coef_}).sort_values(
        "coefficient", ascending=False
    )


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare healthy attachment and constrained retention-risk scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Healthy satisfaction and commitment",
                "leadership_support": 84,
                "reward_fairness": 79,
                "developmental_opportunity": 82,
                "workload_balance": 76,
                "institutional_trust": 83,
                "cultural_alignment": 81,
                "role_insecurity": 18,
                "exhaustion_pressure": 22,
                "affective_commitment": 84,
                "continuance_commitment": 38,
                "normative_commitment": 68,
            },
            {
                "scenario": "Constrained retention and symbolic commitment risk",
                "leadership_support": 34,
                "reward_fairness": 31,
                "developmental_opportunity": 36,
                "workload_balance": 28,
                "institutional_trust": 29,
                "cultural_alignment": 33,
                "role_insecurity": 72,
                "exhaustion_pressure": 74,
                "affective_commitment": 28,
                "continuance_commitment": 78,
                "normative_commitment": 42,
            },
        ]
    )

    scenarios["predicted_high_retention_risk_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["work_attitude_risk_score"] = (
        0.12 * (100 - scenarios["leadership_support"])
        + 0.12 * (100 - scenarios["reward_fairness"])
        + 0.10 * (100 - scenarios["developmental_opportunity"])
        + 0.12 * (100 - scenarios["workload_balance"])
        + 0.14 * (100 - scenarios["institutional_trust"])
        + 0.10 * (100 - scenarios["cultural_alignment"])
        + 0.13 * scenarios["role_insecurity"]
        + 0.13 * scenarios["exhaustion_pressure"]
        + 0.04 * scenarios["continuance_commitment"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_work_attitude_scores(df)

    scored.to_csv(TABLE_DIR / "scored_satisfaction_commitment_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_satisfaction_commitment_summary.csv", index=False)

    model, coefficients, report, auc = fit_retention_model(scored)
    coefficients.to_csv(TABLE_DIR / "high_retention_risk_coefficients.csv", index=False)

    commitment_coefficients = fit_commitment_model(scored)
    commitment_coefficients.to_csv(TABLE_DIR / "commitment_model_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "satisfaction_commitment_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "high_retention_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic satisfaction and commitment high-retention-risk model\n")
        handle.write("===============================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and work-attitude review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, commitment scoring of workers, retention-risk "
            "scoring of individual workers, productivity ranking, or psychological "
            "assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

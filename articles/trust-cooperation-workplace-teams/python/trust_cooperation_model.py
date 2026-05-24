"""
Trust and Cooperation in Workplace Teams
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, trust-and-cooperation review, collaboration-system
education, reciprocity analysis, leadership and governance review, and
reproducible workflows. It is not an employee-screening, hiring, promotion,
compensation, discipline, termination, workplace surveillance, individual
performance-management, cultural-loyalty scoring, trustworthiness scoring,
cooperation scoring of workers, productivity-ranking, or psychological
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
RAW_DATA = ROOT / "data" / "raw" / "trust_cooperation_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "competence_trust",
    "integrity_trust",
    "benevolence_trust",
    "reciprocity_norms",
    "communication_reliability",
    "opportunism_risk",
    "power_imbalance",
    "uncertainty_load",
    "leadership_credibility",
    "institutional_trust",
]


def load_data() -> pd.DataFrame:
    """Load synthetic trust-and-cooperation data."""
    return pd.read_csv(RAW_DATA)


def add_trust_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create cooperative capacity, trust risk, and review-priority scores."""
    scored = df.copy()

    scored["cooperative_capacity_score"] = (
        0.13 * scored["competence_trust"]
        + 0.14 * scored["integrity_trust"]
        + 0.12 * scored["benevolence_trust"]
        + 0.13 * scored["reciprocity_norms"]
        + 0.12 * scored["communication_reliability"]
        + 0.11 * scored["leadership_credibility"]
        + 0.11 * scored["institutional_trust"]
        - 0.10 * scored["opportunism_risk"]
        - 0.08 * scored["power_imbalance"]
        - 0.05 * scored["uncertainty_load"]
    ).clip(0, 100)

    scored["trust_risk_score"] = (
        0.10 * (100 - scored["competence_trust"])
        + 0.14 * (100 - scored["integrity_trust"])
        + 0.10 * (100 - scored["benevolence_trust"])
        + 0.12 * (100 - scored["reciprocity_norms"])
        + 0.10 * (100 - scored["communication_reliability"])
        + 0.10 * (100 - scored["leadership_credibility"])
        + 0.12 * (100 - scored["institutional_trust"])
        + 0.14 * scored["opportunism_risk"]
        + 0.10 * scored["power_imbalance"]
        + 0.08 * scored["uncertainty_load"]
    ).clip(0, 100)

    scored["reciprocity_gap_score"] = (
        0.35 * (100 - scored["reciprocity_norms"])
        + 0.25 * scored["power_imbalance"]
        + 0.20 * scored["opportunism_risk"]
        + 0.20 * (100 - scored["institutional_trust"])
    ).clip(0, 100)

    scored["trust_review_priority"] = np.select(
        [
            (scored["trust_risk_score"] >= 70)
            | (scored["cooperative_capacity_score"] < 45)
            | (scored["symbolic_cooperation_risk"] == 1),
            (scored["trust_risk_score"] >= 50)
            | (scored["cooperative_capacity_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_teams(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize trust-and-cooperation conditions by synthetic team."""
    return (
        df.groupby("team_id")
        .agg(
            observations=("period", "count"),
            avg_cooperative_capacity=("cooperative_capacity_score", "mean"),
            avg_trust_risk=("trust_risk_score", "mean"),
            avg_reciprocity_gap=("reciprocity_gap_score", "mean"),
            avg_competence_trust=("competence_trust", "mean"),
            avg_integrity_trust=("integrity_trust", "mean"),
            avg_benevolence_trust=("benevolence_trust", "mean"),
            avg_reciprocity_norms=("reciprocity_norms", "mean"),
            avg_communication_reliability=("communication_reliability", "mean"),
            avg_opportunism_risk=("opportunism_risk", "mean"),
            avg_power_imbalance=("power_imbalance", "mean"),
            avg_uncertainty_load=("uncertainty_load", "mean"),
            avg_leadership_credibility=("leadership_credibility", "mean"),
            avg_institutional_trust=("institutional_trust", "mean"),
            strong_collaboration_rate=("strong_collaboration", "mean"),
            symbolic_cooperation_risk_rate=("symbolic_cooperation_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_trust_risk", ascending=False)
    )


def fit_collaboration_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic strong-collaboration classifier."""
    x = df[FEATURES]
    y = df["strong_collaboration"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=515, stratify=y
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
    """Compare high-trust and low-trust synthetic collaboration scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Trust-supported cooperative team",
                "competence_trust": 84,
                "integrity_trust": 82,
                "benevolence_trust": 78,
                "reciprocity_norms": 81,
                "communication_reliability": 83,
                "opportunism_risk": 16,
                "power_imbalance": 20,
                "uncertainty_load": 52,
                "leadership_credibility": 84,
                "institutional_trust": 82,
            },
            {
                "scenario": "Low-trust symbolic cooperation risk",
                "competence_trust": 43,
                "integrity_trust": 36,
                "benevolence_trust": 34,
                "reciprocity_norms": 39,
                "communication_reliability": 41,
                "opportunism_risk": 72,
                "power_imbalance": 69,
                "uncertainty_load": 52,
                "leadership_credibility": 34,
                "institutional_trust": 32,
            },
        ]
    )

    scenarios["predicted_strong_collaboration_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["trust_risk_score"] = (
        0.10 * (100 - scenarios["competence_trust"])
        + 0.14 * (100 - scenarios["integrity_trust"])
        + 0.10 * (100 - scenarios["benevolence_trust"])
        + 0.12 * (100 - scenarios["reciprocity_norms"])
        + 0.10 * (100 - scenarios["communication_reliability"])
        + 0.10 * (100 - scenarios["leadership_credibility"])
        + 0.12 * (100 - scenarios["institutional_trust"])
        + 0.14 * scenarios["opportunism_risk"]
        + 0.10 * scenarios["power_imbalance"]
        + 0.08 * scenarios["uncertainty_load"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_trust_scores(df)

    scored.to_csv(TABLE_DIR / "scored_trust_cooperation_observations.csv", index=False)

    team_summary = summarize_teams(scored)
    team_summary.to_csv(TABLE_DIR / "team_trust_cooperation_summary.csv", index=False)

    model, coefficients, report, auc = fit_collaboration_model(scored)
    coefficients.to_csv(TABLE_DIR / "strong_collaboration_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "trust_cooperation_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "strong_collaboration_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic trust and cooperation strong-collaboration model\n")
        handle.write("=========================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and trust-and-cooperation "
            "review. It must not be used for employee screening, employment "
            "selection, workplace surveillance, individual performance management, "
            "cultural loyalty scoring, trustworthiness scoring, cooperation scoring "
            "of workers, productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(team_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

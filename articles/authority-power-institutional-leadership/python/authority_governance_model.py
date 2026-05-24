"""
Authority and Power in Institutional Leadership
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, authority/governance-system review, legitimacy and
procedural-fairness analysis, informal-power and information-flow review,
ethical-leadership education, and reproducible workflows. It is not an
employee-screening, hiring, promotion, compensation, discipline, termination,
workplace surveillance, individual performance-management, productivity-ranking,
loyalty scoring, political-influence scoring, dissent tracking, or psychological
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
RAW_DATA = ROOT / "data" / "raw" / "authority_governance_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "formal_legitimacy",
    "procedural_fairness",
    "informational_access",
    "practical_influence",
    "ethical_credibility",
    "accountability_quality",
    "voice_access",
    "oversight_strength",
    "arbitrariness_risk",
    "governance_fragmentation",
    "distrust_pressure",
    "informal_power_concentration",
]


def load_data() -> pd.DataFrame:
    """Load synthetic authority/governance data."""
    return pd.read_csv(RAW_DATA)


def add_authority_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create authority effectiveness, governance risk, and review-priority scores."""
    scored = df.copy()

    scored["authority_effectiveness_score"] = (
        0.12 * scored["formal_legitimacy"]
        + 0.12 * scored["procedural_fairness"]
        + 0.10 * scored["informational_access"]
        + 0.10 * scored["practical_influence"]
        + 0.12 * scored["ethical_credibility"]
        + 0.11 * scored["accountability_quality"]
        + 0.10 * scored["voice_access"]
        + 0.09 * scored["oversight_strength"]
        - 0.08 * scored["arbitrariness_risk"]
        - 0.07 * scored["governance_fragmentation"]
        - 0.07 * scored["distrust_pressure"]
        - 0.05 * scored["informal_power_concentration"]
    ).clip(0, 100)

    scored["governance_risk_score"] = (
        0.11 * (100 - scored["formal_legitimacy"])
        + 0.12 * (100 - scored["procedural_fairness"])
        + 0.08 * (100 - scored["informational_access"])
        + 0.08 * (100 - scored["practical_influence"])
        + 0.12 * (100 - scored["ethical_credibility"])
        + 0.11 * (100 - scored["accountability_quality"])
        + 0.09 * (100 - scored["voice_access"])
        + 0.08 * (100 - scored["oversight_strength"])
        + 0.10 * scored["arbitrariness_risk"]
        + 0.09 * scored["governance_fragmentation"]
        + 0.09 * scored["distrust_pressure"]
        + 0.08 * scored["informal_power_concentration"]
    ).clip(0, 100)

    scored["shadow_governance_risk_score"] = (
        0.26 * scored["informal_power_concentration"]
        + 0.22 * scored["governance_fragmentation"]
        + 0.18 * scored["arbitrariness_risk"]
        + 0.14 * (100 - scored["accountability_quality"])
        + 0.10 * (100 - scored["oversight_strength"])
        + 0.10 * scored["shadow_governance_risk"] * 100
    ).clip(0, 100)

    scored["legitimacy_decay_score"] = (
        0.24 * scored["distrust_pressure"]
        + 0.19 * scored["arbitrariness_risk"]
        + 0.17 * (100 - scored["procedural_fairness"])
        + 0.15 * (100 - scored["ethical_credibility"])
        + 0.13 * (100 - scored["voice_access"])
        + 0.12 * scored["legitimacy_decay_risk"] * 100
    ).clip(0, 100)

    scored["authority_review_priority"] = np.select(
        [
            (scored["governance_risk_score"] >= 70)
            | (scored["authority_effectiveness_score"] < 45)
            | (scored["governance_risk"] == 1)
            | (scored["shadow_governance_risk"] == 1)
            | (scored["legitimacy_decay_risk"] == 1),
            (scored["governance_risk_score"] >= 50)
            | (scored["authority_effectiveness_score"] < 60)
            | (scored["shadow_governance_risk_score"] >= 60)
            | (scored["legitimacy_decay_score"] >= 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize authority/governance conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_authority_effectiveness=("authority_effectiveness_score", "mean"),
            avg_governance_risk=("governance_risk_score", "mean"),
            avg_shadow_governance_risk=("shadow_governance_risk_score", "mean"),
            avg_legitimacy_decay=("legitimacy_decay_score", "mean"),
            avg_formal_legitimacy=("formal_legitimacy", "mean"),
            avg_procedural_fairness=("procedural_fairness", "mean"),
            avg_informational_access=("informational_access", "mean"),
            avg_practical_influence=("practical_influence", "mean"),
            avg_ethical_credibility=("ethical_credibility", "mean"),
            avg_accountability_quality=("accountability_quality", "mean"),
            avg_voice_access=("voice_access", "mean"),
            avg_oversight_strength=("oversight_strength", "mean"),
            avg_arbitrariness_risk=("arbitrariness_risk", "mean"),
            avg_governance_fragmentation=("governance_fragmentation", "mean"),
            avg_distrust_pressure=("distrust_pressure", "mean"),
            avg_informal_power_concentration=("informal_power_concentration", "mean"),
            governance_risk_rate=("governance_risk", "mean"),
            shadow_governance_risk_rate=("shadow_governance_risk", "mean"),
            legitimacy_decay_risk_rate=("legitimacy_decay_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_governance_risk", ascending=False)
    )


def fit_governance_risk_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic governance-risk classifier."""
    x = df[FEATURES]
    y = df["governance_risk"]

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


def fit_authority_effectiveness_model(df: pd.DataFrame) -> pd.DataFrame:
    """Fit a simple synthetic authority-effectiveness model for interpretation."""
    predictors = [
        "formal_legitimacy",
        "procedural_fairness",
        "informational_access",
        "practical_influence",
        "ethical_credibility",
        "accountability_quality",
        "voice_access",
        "oversight_strength",
        "arbitrariness_risk",
        "governance_fragmentation",
        "distrust_pressure",
        "informal_power_concentration",
    ]
    model = LinearRegression()
    model.fit(df[predictors], df["authority_effectiveness_score"])
    return pd.DataFrame({"feature": predictors, "coefficient": model.coef_}).sort_values(
        "coefficient", ascending=False
    )


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare legitimate and high-risk synthetic authority/governance scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Legitimate, accountable, procedurally fair authority",
                "formal_legitimacy": 84,
                "procedural_fairness": 82,
                "informational_access": 79,
                "practical_influence": 81,
                "ethical_credibility": 83,
                "accountability_quality": 82,
                "voice_access": 80,
                "oversight_strength": 78,
                "arbitrariness_risk": 18,
                "governance_fragmentation": 24,
                "distrust_pressure": 20,
                "informal_power_concentration": 22,
            },
            {
                "scenario": "Fragmented, arbitrary, low-trust shadow-governance risk",
                "formal_legitimacy": 39,
                "procedural_fairness": 34,
                "informational_access": 41,
                "practical_influence": 38,
                "ethical_credibility": 33,
                "accountability_quality": 35,
                "voice_access": 31,
                "oversight_strength": 34,
                "arbitrariness_risk": 72,
                "governance_fragmentation": 69,
                "distrust_pressure": 74,
                "informal_power_concentration": 76,
            },
        ]
    )

    scenarios["predicted_governance_risk_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["governance_risk_score"] = (
        0.11 * (100 - scenarios["formal_legitimacy"])
        + 0.12 * (100 - scenarios["procedural_fairness"])
        + 0.08 * (100 - scenarios["informational_access"])
        + 0.08 * (100 - scenarios["practical_influence"])
        + 0.12 * (100 - scenarios["ethical_credibility"])
        + 0.11 * (100 - scenarios["accountability_quality"])
        + 0.09 * (100 - scenarios["voice_access"])
        + 0.08 * (100 - scenarios["oversight_strength"])
        + 0.10 * scenarios["arbitrariness_risk"]
        + 0.09 * scenarios["governance_fragmentation"]
        + 0.09 * scenarios["distrust_pressure"]
        + 0.08 * scenarios["informal_power_concentration"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_authority_scores(df)

    scored.to_csv(TABLE_DIR / "scored_authority_governance_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_authority_governance_summary.csv", index=False)

    model, coefficients, report, auc = fit_governance_risk_model(scored)
    coefficients.to_csv(TABLE_DIR / "governance_risk_coefficients.csv", index=False)

    effectiveness_coefficients = fit_authority_effectiveness_model(scored)
    effectiveness_coefficients.to_csv(TABLE_DIR / "authority_effectiveness_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "authority_governance_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "governance_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic authority/governance risk model\n")
        handle.write("=========================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and authority/governance-system review. "
            "It must not be used for employee screening, employment selection, workplace "
            "surveillance, individual performance management, productivity ranking, loyalty "
            "scoring, political-influence scoring, dissent tracking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

"""
Transformational Leadership and Organizational Change
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, transformational-leadership review, change-system
analysis, vision/trust/support/fatigue diagnostics, psychological-safety and
organizational-learning education, and reproducible workflows. It is not an
employee-screening, hiring, promotion, compensation, discipline, termination,
workplace surveillance, individual performance-management, productivity-ranking,
leadership-loyalty scoring, dissent tracking, or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "transformational_leadership_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "vision_credibility",
    "motivational_alignment",
    "intellectual_stimulation",
    "developmental_support",
    "institutional_trust",
    "psychological_safety",
    "change_communication",
    "implementation_support",
    "meaning_making_quality",
    "resistance_intensity",
    "ambiguity_pressure",
    "change_fatigue",
]


def load_data() -> pd.DataFrame:
    """Load synthetic transformational-leadership data."""
    return pd.read_csv(RAW_DATA)


def add_transformational_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create transformational capacity, adaptive capacity, and risk scores."""
    scored = df.copy()

    scored["transformational_capacity_score"] = (
        0.12 * scored["vision_credibility"]
        + 0.11 * scored["motivational_alignment"]
        + 0.11 * scored["intellectual_stimulation"]
        + 0.10 * scored["developmental_support"]
        + 0.12 * scored["institutional_trust"]
        + 0.11 * scored["psychological_safety"]
        + 0.10 * scored["change_communication"]
        + 0.09 * scored["implementation_support"]
        + 0.10 * scored["meaning_making_quality"]
        - 0.08 * scored["resistance_intensity"]
        - 0.07 * scored["ambiguity_pressure"]
        - 0.08 * scored["change_fatigue"]
    ).clip(0, 100)

    scored["adaptive_change_capacity_score"] = (
        0.20 * scored["transformational_capacity_score"]
        + 0.13 * scored["vision_credibility"]
        + 0.12 * scored["intellectual_stimulation"]
        + 0.12 * scored["institutional_trust"]
        + 0.12 * scored["psychological_safety"]
        + 0.10 * scored["implementation_support"]
        + 0.09 * scored["developmental_support"]
        + 0.07 * scored["motivational_alignment"]
        + 0.05 * scored["meaning_making_quality"]
    ).clip(0, 100)

    scored["transformational_system_risk_score"] = (
        0.11 * (100 - scored["vision_credibility"])
        + 0.10 * (100 - scored["motivational_alignment"])
        + 0.09 * (100 - scored["intellectual_stimulation"])
        + 0.09 * (100 - scored["developmental_support"])
        + 0.12 * (100 - scored["institutional_trust"])
        + 0.11 * (100 - scored["psychological_safety"])
        + 0.09 * (100 - scored["change_communication"])
        + 0.09 * (100 - scored["implementation_support"])
        + 0.09 * (100 - scored["meaning_making_quality"])
        + 0.10 * scored["resistance_intensity"]
        + 0.10 * scored["ambiguity_pressure"]
        + 0.12 * scored["change_fatigue"]
    ).clip(0, 100)

    scored["fatigue_voice_purpose_risk_score"] = (
        0.22 * scored["change_fatigue"]
        + 0.18 * scored["ambiguity_pressure"]
        + 0.16 * scored["resistance_intensity"]
        + 0.14 * (100 - scored["institutional_trust"])
        + 0.12 * (100 - scored["psychological_safety"])
        + 0.08 * scored["voice_suppression_risk"] * 100
        + 0.05 * scored["purpose_exploitation_risk"] * 100
        + 0.05 * scored["style_misfit_risk"] * 100
    ).clip(0, 100)

    scored["transformational_review_priority"] = np.select(
        [
            (scored["transformational_system_risk_score"] >= 70)
            | (scored["transformational_capacity_score"] < 45)
            | (scored["adaptive_performance_risk"] == 1)
            | (scored["voice_suppression_risk"] == 1)
            | (scored["purpose_exploitation_risk"] == 1),
            (scored["transformational_system_risk_score"] >= 50)
            | (scored["transformational_capacity_score"] < 60)
            | (scored["fatigue_voice_purpose_risk_score"] >= 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize transformational-leadership conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_transformational_capacity=("transformational_capacity_score", "mean"),
            avg_adaptive_change_capacity=("adaptive_change_capacity_score", "mean"),
            avg_transformational_system_risk=("transformational_system_risk_score", "mean"),
            avg_fatigue_voice_purpose_risk=("fatigue_voice_purpose_risk_score", "mean"),
            avg_vision_credibility=("vision_credibility", "mean"),
            avg_motivational_alignment=("motivational_alignment", "mean"),
            avg_intellectual_stimulation=("intellectual_stimulation", "mean"),
            avg_developmental_support=("developmental_support", "mean"),
            avg_institutional_trust=("institutional_trust", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_change_communication=("change_communication", "mean"),
            avg_implementation_support=("implementation_support", "mean"),
            avg_meaning_making_quality=("meaning_making_quality", "mean"),
            avg_resistance_intensity=("resistance_intensity", "mean"),
            avg_ambiguity_pressure=("ambiguity_pressure", "mean"),
            avg_change_fatigue=("change_fatigue", "mean"),
            voice_suppression_risk_rate=("voice_suppression_risk", "mean"),
            adaptive_performance_risk_rate=("adaptive_performance_risk", "mean"),
            style_misfit_risk_rate=("style_misfit_risk", "mean"),
            purpose_exploitation_risk_rate=("purpose_exploitation_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_transformational_system_risk", ascending=False)
    )


def fit_adaptive_performance_risk_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic adaptive-performance-risk classifier."""
    x = df[FEATURES]
    y = df["adaptive_performance_risk"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=929, stratify=y
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


def fit_transformational_capacity_model(df: pd.DataFrame) -> pd.DataFrame:
    """Fit a simple synthetic transformational-capacity model for interpretation."""
    predictors = FEATURES
    model = LinearRegression()
    model.fit(df[predictors], df["transformational_capacity_score"])
    return pd.DataFrame({"feature": predictors, "coefficient": model.coef_}).sort_values(
        "coefficient", ascending=False
    )


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare high-capacity and high-risk synthetic transformational-leadership scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Credible, trust-based, developmentally supported transformation",
                "vision_credibility": 84,
                "motivational_alignment": 81,
                "intellectual_stimulation": 80,
                "developmental_support": 79,
                "institutional_trust": 82,
                "psychological_safety": 80,
                "change_communication": 83,
                "implementation_support": 78,
                "meaning_making_quality": 82,
                "resistance_intensity": 20,
                "ambiguity_pressure": 22,
                "change_fatigue": 24,
            },
            {
                "scenario": "Low-trust, ambiguous, fatigue-heavy transformation",
                "vision_credibility": 36,
                "motivational_alignment": 39,
                "intellectual_stimulation": 35,
                "developmental_support": 34,
                "institutional_trust": 31,
                "psychological_safety": 34,
                "change_communication": 37,
                "implementation_support": 32,
                "meaning_making_quality": 36,
                "resistance_intensity": 72,
                "ambiguity_pressure": 70,
                "change_fatigue": 74,
            },
        ]
    )

    scenarios["predicted_adaptive_performance_risk_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["transformational_system_risk_score"] = (
        0.11 * (100 - scenarios["vision_credibility"])
        + 0.10 * (100 - scenarios["motivational_alignment"])
        + 0.09 * (100 - scenarios["intellectual_stimulation"])
        + 0.09 * (100 - scenarios["developmental_support"])
        + 0.12 * (100 - scenarios["institutional_trust"])
        + 0.11 * (100 - scenarios["psychological_safety"])
        + 0.09 * (100 - scenarios["change_communication"])
        + 0.09 * (100 - scenarios["implementation_support"])
        + 0.09 * (100 - scenarios["meaning_making_quality"])
        + 0.10 * scenarios["resistance_intensity"]
        + 0.10 * scenarios["ambiguity_pressure"]
        + 0.12 * scenarios["change_fatigue"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_transformational_scores(df)

    scored.to_csv(TABLE_DIR / "scored_transformational_leadership_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_transformational_leadership_summary.csv", index=False)

    model, coefficients, report, auc = fit_adaptive_performance_risk_model(scored)
    coefficients.to_csv(TABLE_DIR / "adaptive_performance_risk_coefficients.csv", index=False)

    capacity_coefficients = fit_transformational_capacity_model(scored)
    capacity_coefficients.to_csv(TABLE_DIR / "transformational_capacity_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "transformational_leadership_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "adaptive_performance_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic transformational leadership adaptive-performance-risk model\n")
        handle.write("=====================================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and transformational-leadership review. "
            "It must not be used for employee screening, employment selection, workplace "
            "surveillance, individual performance management, productivity ranking, "
            "leadership-loyalty scoring, dissent tracking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

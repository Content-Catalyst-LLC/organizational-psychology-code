"""
Leadership Styles and Organizational Performance
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, leadership-system review, communication/trust/style-fit
analysis, psychological-safety and work-design education, and reproducible
workflows. It is not an employee-screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance-
management, productivity-ranking, leadership-loyalty scoring, dissent tracking,
or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "leadership_style_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "participative_behavior",
    "structural_guidance",
    "communication_quality",
    "trust_generation",
    "developmental_support",
    "psychological_safety",
    "decision_fit",
    "cultural_alignment",
    "control_pressure",
    "ambiguity_risk",
    "disengagement_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic leadership-style data."""
    return pd.read_csv(RAW_DATA)


def add_leadership_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create leadership effectiveness, institutional capacity, and risk scores."""
    scored = df.copy()

    scored["leadership_effectiveness_score"] = (
        0.11 * scored["participative_behavior"]
        + 0.12 * scored["structural_guidance"]
        + 0.13 * scored["communication_quality"]
        + 0.13 * scored["trust_generation"]
        + 0.11 * scored["developmental_support"]
        + 0.12 * scored["psychological_safety"]
        + 0.11 * scored["decision_fit"]
        + 0.10 * scored["cultural_alignment"]
        - 0.08 * scored["control_pressure"]
        - 0.07 * scored["ambiguity_risk"]
        - 0.07 * scored["disengagement_pressure"]
    ).clip(0, 100)

    scored["institutional_performance_capacity_score"] = (
        0.20 * scored["leadership_effectiveness_score"]
        + 0.13 * scored["communication_quality"]
        + 0.13 * scored["trust_generation"]
        + 0.12 * scored["structural_guidance"]
        + 0.12 * scored["decision_fit"]
        + 0.11 * scored["psychological_safety"]
        + 0.09 * scored["developmental_support"]
        + 0.05 * scored["participative_behavior"]
        + 0.05 * scored["cultural_alignment"]
    ).clip(0, 100)

    scored["leadership_system_risk_score"] = (
        0.09 * (100 - scored["participative_behavior"])
        + 0.10 * (100 - scored["structural_guidance"])
        + 0.12 * (100 - scored["communication_quality"])
        + 0.13 * (100 - scored["trust_generation"])
        + 0.09 * (100 - scored["developmental_support"])
        + 0.12 * (100 - scored["psychological_safety"])
        + 0.10 * (100 - scored["decision_fit"])
        + 0.08 * (100 - scored["cultural_alignment"])
        + 0.11 * scored["control_pressure"]
        + 0.10 * scored["ambiguity_risk"]
        + 0.10 * scored["disengagement_pressure"]
    ).clip(0, 100)

    scored["voice_and_style_misfit_risk_score"] = (
        0.20 * scored["control_pressure"]
        + 0.18 * scored["ambiguity_risk"]
        + 0.18 * scored["disengagement_pressure"]
        + 0.14 * (100 - scored["psychological_safety"])
        + 0.12 * (100 - scored["decision_fit"])
        + 0.08 * scored["voice_suppression_risk"] * 100
        + 0.05 * scored["authoritarian_overuse_risk"] * 100
        + 0.05 * scored["laissez_faire_absence_risk"] * 100
    ).clip(0, 100)

    scored["leadership_review_priority"] = np.select(
        [
            (scored["leadership_system_risk_score"] >= 70)
            | (scored["leadership_effectiveness_score"] < 45)
            | (scored["performance_risk"] == 1)
            | (scored["voice_suppression_risk"] == 1)
            | (scored["style_misfit_risk"] == 1),
            (scored["leadership_system_risk_score"] >= 50)
            | (scored["leadership_effectiveness_score"] < 60)
            | (scored["voice_and_style_misfit_risk_score"] >= 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize leadership-system conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_leadership_effectiveness=("leadership_effectiveness_score", "mean"),
            avg_institutional_performance_capacity=(
                "institutional_performance_capacity_score",
                "mean",
            ),
            avg_leadership_system_risk=("leadership_system_risk_score", "mean"),
            avg_voice_and_style_misfit_risk=("voice_and_style_misfit_risk_score", "mean"),
            avg_participative_behavior=("participative_behavior", "mean"),
            avg_structural_guidance=("structural_guidance", "mean"),
            avg_communication_quality=("communication_quality", "mean"),
            avg_trust_generation=("trust_generation", "mean"),
            avg_developmental_support=("developmental_support", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_decision_fit=("decision_fit", "mean"),
            avg_cultural_alignment=("cultural_alignment", "mean"),
            avg_control_pressure=("control_pressure", "mean"),
            avg_ambiguity_risk=("ambiguity_risk", "mean"),
            avg_disengagement_pressure=("disengagement_pressure", "mean"),
            performance_risk_rate=("performance_risk", "mean"),
            voice_suppression_risk_rate=("voice_suppression_risk", "mean"),
            style_misfit_risk_rate=("style_misfit_risk", "mean"),
            authoritarian_overuse_risk_rate=("authoritarian_overuse_risk", "mean"),
            laissez_faire_absence_risk_rate=("laissez_faire_absence_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_leadership_system_risk", ascending=False)
    )


def fit_performance_risk_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic institutional performance-risk classifier."""
    x = df[FEATURES]
    y = df["performance_risk"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=818, stratify=y
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


def fit_leadership_effectiveness_model(df: pd.DataFrame) -> pd.DataFrame:
    """Fit a simple synthetic leadership-effectiveness model for interpretation."""
    predictors = [
        "participative_behavior",
        "structural_guidance",
        "communication_quality",
        "trust_generation",
        "developmental_support",
        "psychological_safety",
        "decision_fit",
        "cultural_alignment",
        "control_pressure",
        "ambiguity_risk",
        "disengagement_pressure",
    ]
    model = LinearRegression()
    model.fit(df[predictors], df["leadership_effectiveness_score"])
    return pd.DataFrame({"feature": predictors, "coefficient": model.coef_}).sort_values(
        "coefficient", ascending=False
    )


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare high-quality and high-risk synthetic leadership-style scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Participatory, structured, high-trust leadership",
                "participative_behavior": 82,
                "structural_guidance": 80,
                "communication_quality": 83,
                "trust_generation": 81,
                "developmental_support": 79,
                "psychological_safety": 80,
                "decision_fit": 82,
                "cultural_alignment": 81,
                "control_pressure": 18,
                "ambiguity_risk": 22,
                "disengagement_pressure": 20,
            },
            {
                "scenario": "High-control, low-trust, style-misfit leadership",
                "participative_behavior": 34,
                "structural_guidance": 39,
                "communication_quality": 36,
                "trust_generation": 31,
                "developmental_support": 35,
                "psychological_safety": 34,
                "decision_fit": 38,
                "cultural_alignment": 33,
                "control_pressure": 72,
                "ambiguity_risk": 69,
                "disengagement_pressure": 71,
            },
        ]
    )

    scenarios["predicted_performance_risk_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["leadership_system_risk_score"] = (
        0.09 * (100 - scenarios["participative_behavior"])
        + 0.10 * (100 - scenarios["structural_guidance"])
        + 0.12 * (100 - scenarios["communication_quality"])
        + 0.13 * (100 - scenarios["trust_generation"])
        + 0.09 * (100 - scenarios["developmental_support"])
        + 0.12 * (100 - scenarios["psychological_safety"])
        + 0.10 * (100 - scenarios["decision_fit"])
        + 0.08 * (100 - scenarios["cultural_alignment"])
        + 0.11 * scenarios["control_pressure"]
        + 0.10 * scenarios["ambiguity_risk"]
        + 0.10 * scenarios["disengagement_pressure"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_leadership_scores(df)

    scored.to_csv(TABLE_DIR / "scored_leadership_style_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_leadership_style_summary.csv", index=False)

    model, coefficients, report, auc = fit_performance_risk_model(scored)
    coefficients.to_csv(TABLE_DIR / "performance_risk_coefficients.csv", index=False)

    effectiveness_coefficients = fit_leadership_effectiveness_model(scored)
    effectiveness_coefficients.to_csv(TABLE_DIR / "leadership_effectiveness_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "leadership_style_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "performance_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic leadership style performance-risk model\n")
        handle.write("=================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and leadership-system review. "
            "It must not be used for employee screening, employment selection, workplace "
            "surveillance, individual performance management, productivity ranking, "
            "leadership-loyalty scoring, dissent tracking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

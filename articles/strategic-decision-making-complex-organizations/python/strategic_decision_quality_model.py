"""
Strategic Decision-Making in Complex Organizations
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, strategic governance, decision-process review,
and reproducible workflows. It is not an employee-screening, hiring,
promotion, compensation, discipline, termination, workplace surveillance,
individual performance-management, executive-ranking, or psychological
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
RAW_DATA = ROOT / "data" / "raw" / "strategic_decision_quality_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "sensing_quality",
    "interpretive_coherence",
    "knowledge_integration",
    "option_diversity",
    "governance_quality",
    "adaptive_learning",
    "bias_pressure",
    "political_distortion",
    "complexity_load",
    "environmental_turbulence",
]


def load_data() -> pd.DataFrame:
    """Load synthetic strategic decision-quality data."""
    return pd.read_csv(RAW_DATA)


def add_strategic_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create strategic decision quality, risk, and review-priority scores."""
    scored = df.copy()

    scored["strategic_decision_quality_score"] = (
        0.17 * scored["sensing_quality"]
        + 0.16 * scored["interpretive_coherence"]
        + 0.16 * scored["knowledge_integration"]
        + 0.12 * scored["option_diversity"]
        + 0.13 * scored["governance_quality"]
        + 0.14 * scored["adaptive_learning"]
        - 0.12 * scored["bias_pressure"]
        - 0.10 * scored["political_distortion"]
        - 0.09 * scored["complexity_load"]
        - 0.08 * scored["environmental_turbulence"]
    ).clip(0, 100)

    scored["strategic_risk_score"] = (
        0.15 * (100 - scored["sensing_quality"])
        + 0.13 * (100 - scored["interpretive_coherence"])
        + 0.14 * (100 - scored["knowledge_integration"])
        + 0.08 * (100 - scored["option_diversity"])
        + 0.12 * (100 - scored["governance_quality"])
        + 0.12 * (100 - scored["adaptive_learning"])
        + 0.10 * scored["bias_pressure"]
        + 0.08 * scored["political_distortion"]
        + 0.04 * scored["complexity_load"]
        + 0.04 * scored["environmental_turbulence"]
    ).clip(0, 100)

    scored["strategic_review_priority"] = np.select(
        [
            (scored["strategic_risk_score"] >= 70)
            | (scored["strategic_decision_quality_score"] < 45)
            | (scored["symbolic_strategy"] == 1),
            (scored["strategic_risk_score"] >= 50)
            | (scored["strategic_decision_quality_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize strategic decision conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_strategic_decision_quality=("strategic_decision_quality_score", "mean"),
            avg_strategic_risk=("strategic_risk_score", "mean"),
            avg_sensing_quality=("sensing_quality", "mean"),
            avg_knowledge_integration=("knowledge_integration", "mean"),
            avg_governance_quality=("governance_quality", "mean"),
            avg_adaptive_learning=("adaptive_learning", "mean"),
            avg_bias_pressure=("bias_pressure", "mean"),
            avg_political_distortion=("political_distortion", "mean"),
            strategic_success_rate=("strategic_success", "mean"),
            symbolic_strategy_rate=("symbolic_strategy", "mean"),
        )
        .reset_index()
        .sort_values("avg_strategic_risk", ascending=False)
    )


def fit_strategy_success_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic successful-strategy classifier."""
    x = df[FEATURES]
    y = df["strategic_success"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=616, stratify=y
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
    """Compare two synthetic strategic decision scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "High strategic decision quality",
                "sensing_quality": 84,
                "interpretive_coherence": 79,
                "knowledge_integration": 82,
                "option_diversity": 74,
                "governance_quality": 77,
                "adaptive_learning": 81,
                "bias_pressure": 18,
                "political_distortion": 14,
                "complexity_load": 58,
                "environmental_turbulence": 62,
            },
            {
                "scenario": "High bias and political distortion",
                "sensing_quality": 49,
                "interpretive_coherence": 42,
                "knowledge_integration": 45,
                "option_diversity": 38,
                "governance_quality": 39,
                "adaptive_learning": 43,
                "bias_pressure": 71,
                "political_distortion": 66,
                "complexity_load": 58,
                "environmental_turbulence": 62,
            },
        ]
    )

    scenarios["predicted_successful_strategy_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["strategic_risk_score"] = (
        0.15 * (100 - scenarios["sensing_quality"])
        + 0.13 * (100 - scenarios["interpretive_coherence"])
        + 0.14 * (100 - scenarios["knowledge_integration"])
        + 0.08 * (100 - scenarios["option_diversity"])
        + 0.12 * (100 - scenarios["governance_quality"])
        + 0.12 * (100 - scenarios["adaptive_learning"])
        + 0.10 * scenarios["bias_pressure"]
        + 0.08 * scenarios["political_distortion"]
        + 0.04 * scenarios["complexity_load"]
        + 0.04 * scenarios["environmental_turbulence"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_strategic_scores(df)

    scored.to_csv(TABLE_DIR / "scored_strategic_decision_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_strategic_decision_summary.csv", index=False)

    model, coefficients, report, auc = fit_strategy_success_model(scored)
    coefficients.to_csv(TABLE_DIR / "successful_strategy_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "strategic_decision_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "successful_strategy_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic strategic decision successful-strategy model\n")
        handle.write("====================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and strategic governance. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, executive "
            "ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

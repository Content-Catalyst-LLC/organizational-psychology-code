"""
Culture Change in Organizations
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, culture-change review, organizational development
education, and reproducible workflows. It is not an employee-screening,
hiring, promotion, compensation, discipline, termination, workplace surveillance,
individual performance-management, cultural-loyalty scoring, productivity-ranking,
or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "culture_change_capacity_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "leadership_credibility",
    "narrative_coherence",
    "reinforcement_alignment",
    "adaptive_learning",
    "psychological_safety",
    "identity_adaptability",
    "resistance_intensity",
    "subcultural_fragmentation",
    "legacy_lock_in",
    "leadership_turnover",
]


def load_data() -> pd.DataFrame:
    """Load synthetic culture-change data."""
    return pd.read_csv(RAW_DATA)


def add_culture_change_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create culture change capacity, culture risk, and review-priority scores."""
    scored = df.copy()

    scored["culture_change_capacity_score"] = (
        0.17 * scored["leadership_credibility"]
        + 0.15 * scored["narrative_coherence"]
        + 0.15 * scored["reinforcement_alignment"]
        + 0.14 * scored["adaptive_learning"]
        + 0.13 * scored["psychological_safety"]
        + 0.11 * scored["identity_adaptability"]
        - 0.12 * scored["resistance_intensity"]
        - 0.10 * scored["subcultural_fragmentation"]
        - 0.11 * scored["legacy_lock_in"]
        - 4.00 * scored["leadership_turnover"]
    ).clip(0, 100)

    scored["culture_risk_score"] = (
        0.14 * (100 - scored["leadership_credibility"])
        + 0.10 * (100 - scored["narrative_coherence"])
        + 0.14 * (100 - scored["reinforcement_alignment"])
        + 0.10 * (100 - scored["adaptive_learning"])
        + 0.10 * (100 - scored["psychological_safety"])
        + 0.08 * (100 - scored["identity_adaptability"])
        + 0.14 * scored["resistance_intensity"]
        + 0.10 * scored["subcultural_fragmentation"]
        + 0.08 * scored["legacy_lock_in"]
        + 2.00 * scored["leadership_turnover"]
    ).clip(0, 100)

    scored["culture_change_review_priority"] = np.select(
        [
            (scored["culture_risk_score"] >= 70)
            | (scored["culture_change_capacity_score"] < 45)
            | (scored["symbolic_culture_change"] == 1),
            (scored["culture_risk_score"] >= 50)
            | (scored["culture_change_capacity_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize culture-change conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_culture_change_capacity=("culture_change_capacity_score", "mean"),
            avg_culture_risk=("culture_risk_score", "mean"),
            avg_leadership_credibility=("leadership_credibility", "mean"),
            avg_narrative_coherence=("narrative_coherence", "mean"),
            avg_reinforcement_alignment=("reinforcement_alignment", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_identity_adaptability=("identity_adaptability", "mean"),
            avg_resistance_intensity=("resistance_intensity", "mean"),
            avg_subcultural_fragmentation=("subcultural_fragmentation", "mean"),
            avg_legacy_lock_in=("legacy_lock_in", "mean"),
            cultural_adoption_rate=("successful_cultural_adoption", "mean"),
            symbolic_culture_change_rate=("symbolic_culture_change", "mean"),
        )
        .reset_index()
        .sort_values("avg_culture_risk", ascending=False)
    )


def fit_cultural_adoption_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic successful-cultural-adoption classifier."""
    x = df[FEATURES]
    y = df["successful_cultural_adoption"]

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


def build_scenario_table(model: Pipeline) -> pd.DataFrame:
    """Compare two synthetic culture-change scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Credible and reinforced culture change",
                "leadership_credibility": 84,
                "narrative_coherence": 82,
                "reinforcement_alignment": 81,
                "adaptive_learning": 80,
                "psychological_safety": 83,
                "identity_adaptability": 76,
                "resistance_intensity": 22,
                "subcultural_fragmentation": 26,
                "legacy_lock_in": 29,
                "leadership_turnover": 0,
            },
            {
                "scenario": "Symbolic culture change risk",
                "leadership_credibility": 34,
                "narrative_coherence": 39,
                "reinforcement_alignment": 31,
                "adaptive_learning": 42,
                "psychological_safety": 36,
                "identity_adaptability": 41,
                "resistance_intensity": 72,
                "subcultural_fragmentation": 68,
                "legacy_lock_in": 74,
                "leadership_turnover": 1,
            },
        ]
    )

    scenarios["predicted_successful_cultural_adoption_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["culture_risk_score"] = (
        0.14 * (100 - scenarios["leadership_credibility"])
        + 0.10 * (100 - scenarios["narrative_coherence"])
        + 0.14 * (100 - scenarios["reinforcement_alignment"])
        + 0.10 * (100 - scenarios["adaptive_learning"])
        + 0.10 * (100 - scenarios["psychological_safety"])
        + 0.08 * (100 - scenarios["identity_adaptability"])
        + 0.14 * scenarios["resistance_intensity"]
        + 0.10 * scenarios["subcultural_fragmentation"]
        + 0.08 * scenarios["legacy_lock_in"]
        + 2.00 * scenarios["leadership_turnover"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_culture_change_scores(df)

    scored.to_csv(TABLE_DIR / "scored_culture_change_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_culture_change_summary.csv", index=False)

    model, coefficients, report, auc = fit_cultural_adoption_model(scored)
    coefficients.to_csv(TABLE_DIR / "cultural_adoption_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "culture_change_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "cultural_adoption_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic culture change successful-adoption model\n")
        handle.write("=================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and culture-change review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, productivity ranking, or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

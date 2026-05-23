"""
Organizational Identity and Institutional Legitimacy
Advanced synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, organizational identity review, legitimacy analysis,
governance review, and reproducible workflows. It is not an employee-screening,
hiring, promotion, compensation, discipline, termination, workplace surveillance,
individual performance-management, cultural-loyalty scoring, worker legitimacy
scoring, productivity-ranking, or psychological assessment tool.
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
RAW_DATA = ROOT / "data" / "raw" / "identity_legitimacy_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


FEATURES = [
    "mission_clarity",
    "value_practice_alignment",
    "narrative_continuity",
    "leadership_credibility",
    "behavioral_consistency",
    "internal_fragmentation",
    "identity_contradiction",
    "legitimacy_pressure",
]


def load_data() -> pd.DataFrame:
    """Load synthetic identity-legitimacy data."""
    return pd.read_csv(RAW_DATA)


def add_identity_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create identity coherence, identity risk, and review-priority scores."""
    scored = df.copy()

    scored["identity_coherence_score"] = (
        0.18 * scored["mission_clarity"]
        + 0.17 * scored["value_practice_alignment"]
        + 0.15 * scored["narrative_continuity"]
        + 0.14 * scored["leadership_credibility"]
        + 0.14 * scored["behavioral_consistency"]
        - 0.10 * scored["internal_fragmentation"]
        - 0.07 * scored["identity_contradiction"]
        - 0.05 * scored["legitimacy_pressure"]
    ).clip(0, 100)

    scored["identity_risk_score"] = (
        0.14 * (100 - scored["mission_clarity"])
        + 0.16 * (100 - scored["value_practice_alignment"])
        + 0.10 * (100 - scored["narrative_continuity"])
        + 0.12 * (100 - scored["leadership_credibility"])
        + 0.10 * (100 - scored["behavioral_consistency"])
        + 0.12 * scored["internal_fragmentation"]
        + 0.16 * scored["identity_contradiction"]
        + 0.10 * scored["legitimacy_pressure"]
    ).clip(0, 100)

    scored["identity_legitimacy_review_priority"] = np.select(
        [
            (scored["identity_risk_score"] >= 70)
            | (scored["identity_coherence_score"] < 45)
            | (scored["symbolic_identity_risk"] == 1),
            (scored["identity_risk_score"] >= 50)
            | (scored["identity_coherence_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize identity-legitimacy conditions by synthetic unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_identity_coherence=("identity_coherence_score", "mean"),
            avg_identity_risk=("identity_risk_score", "mean"),
            avg_mission_clarity=("mission_clarity", "mean"),
            avg_value_practice_alignment=("value_practice_alignment", "mean"),
            avg_narrative_continuity=("narrative_continuity", "mean"),
            avg_leadership_credibility=("leadership_credibility", "mean"),
            avg_behavioral_consistency=("behavioral_consistency", "mean"),
            avg_internal_fragmentation=("internal_fragmentation", "mean"),
            avg_identity_contradiction=("identity_contradiction", "mean"),
            avg_legitimacy_pressure=("legitimacy_pressure", "mean"),
            stakeholder_legitimacy_rate=("stakeholder_legitimacy", "mean"),
            symbolic_identity_risk_rate=("symbolic_identity_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_identity_risk", ascending=False)
    )


def fit_legitimacy_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a synthetic stakeholder-legitimacy classifier."""
    x = df[FEATURES]
    y = df["stakeholder_legitimacy"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=212, stratify=y
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
    """Compare two synthetic identity-legitimacy scenarios."""
    scenarios = pd.DataFrame(
        [
            {
                "scenario": "Coherent and credible identity",
                "mission_clarity": 86,
                "value_practice_alignment": 82,
                "narrative_continuity": 79,
                "leadership_credibility": 81,
                "behavioral_consistency": 80,
                "internal_fragmentation": 20,
                "identity_contradiction": 16,
                "legitimacy_pressure": 60,
            },
            {
                "scenario": "Fragmented and contradictory identity",
                "mission_clarity": 44,
                "value_practice_alignment": 36,
                "narrative_continuity": 41,
                "leadership_credibility": 39,
                "behavioral_consistency": 38,
                "internal_fragmentation": 69,
                "identity_contradiction": 72,
                "legitimacy_pressure": 60,
            },
        ]
    )

    scenarios["predicted_stakeholder_legitimacy_probability"] = model.predict_proba(
        scenarios[FEATURES]
    )[:, 1]

    scenarios["identity_risk_score"] = (
        0.14 * (100 - scenarios["mission_clarity"])
        + 0.16 * (100 - scenarios["value_practice_alignment"])
        + 0.10 * (100 - scenarios["narrative_continuity"])
        + 0.12 * (100 - scenarios["leadership_credibility"])
        + 0.10 * (100 - scenarios["behavioral_consistency"])
        + 0.12 * scenarios["internal_fragmentation"]
        + 0.16 * scenarios["identity_contradiction"]
        + 0.10 * scenarios["legitimacy_pressure"]
    ).clip(0, 100)

    return scenarios


def main() -> None:
    df = load_data()
    scored = add_identity_scores(df)

    scored.to_csv(TABLE_DIR / "scored_identity_legitimacy_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_identity_legitimacy_summary.csv", index=False)

    model, coefficients, report, auc = fit_legitimacy_model(scored)
    coefficients.to_csv(TABLE_DIR / "stakeholder_legitimacy_coefficients.csv", index=False)

    scenario_table = build_scenario_table(model)
    scenario_table.to_csv(TABLE_DIR / "identity_legitimacy_scenario_comparison.csv", index=False)

    with open(TABLE_DIR / "stakeholder_legitimacy_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic identity-legitimacy stakeholder-legitimacy model\n")
        handle.write("=========================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic methods "
            "demonstration for institutional learning and identity-legitimacy review. "
            "It must not be used for employee screening, employment selection, "
            "workplace surveillance, individual performance management, cultural "
            "loyalty scoring, worker legitimacy scoring, productivity ranking, "
            "or psychological assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)
    print(scenario_table)


if __name__ == "__main__":
    main()

"""
Organizational Resilience in Complex Systems
Synthetic Python workflow.

Responsible-use scope:
This script is for synthetic-data research, methods demonstration,
institutional learning, and reproducible workflows. It is not an
employee-screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance-management,
or psychological assessment tool.
"""

from pathlib import Path

import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report, roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.pipeline import Pipeline


ROOT = Path(__file__).resolve().parents[1]
RAW_DATA = ROOT / "data" / "raw" / "organizational_resilience_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)


def load_data() -> pd.DataFrame:
    """Load the synthetic organizational resilience dataset."""
    return pd.read_csv(RAW_DATA)


def add_resilience_scores(df: pd.DataFrame) -> pd.DataFrame:
    """Create institutional resilience and review-priority scores."""
    scored = df.copy()

    scored["resilience_capacity_score"] = (
        0.18 * scored["robustness"]
        + 0.12 * scored["redundancy"]
        + 0.16 * scored["adaptive_learning"]
        + 0.14 * scored["coordination_integrity"]
        + 0.12 * scored["governance_responsiveness"]
        + 0.13 * scored["psychological_safety"]
        - 0.08 * scored["external_exposure"]
        - 0.07 * scored["complexity_load"]
        - 0.10 * scored["accumulated_fragility"]
    ).clip(0, 100)

    scored["institutional_risk_score"] = (
        0.20 * (100 - scored["robustness"])
        + 0.12 * (100 - scored["redundancy"])
        + 0.16 * (100 - scored["adaptive_learning"])
        + 0.12 * (100 - scored["coordination_integrity"])
        + 0.10 * (100 - scored["governance_responsiveness"])
        + 0.10 * (100 - scored["psychological_safety"])
        + 0.08 * scored["external_exposure"]
        + 0.06 * scored["complexity_load"]
        + 0.06 * scored["accumulated_fragility"]
    ).clip(0, 100)

    scored["review_priority"] = np.select(
        [
            (scored["institutional_risk_score"] >= 65)
            | (scored["major_functional_degradation"] == 1),
            scored["institutional_risk_score"] >= 45,
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )

    return scored


def fit_recovery_model(df: pd.DataFrame) -> tuple[Pipeline, pd.DataFrame, str, float]:
    """Fit a simple recovery model for demonstration purposes."""
    features = [
        "robustness",
        "redundancy",
        "adaptive_learning",
        "coordination_integrity",
        "governance_responsiveness",
        "psychological_safety",
        "external_exposure",
        "complexity_load",
        "accumulated_fragility",
        "shock_intensity",
    ]

    x = df[features]
    y = df["successful_recovery"]

    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=42, stratify=y
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
            "feature": features,
            "coefficient": model.named_steps["logit"].coef_[0],
        }
    ).sort_values("coefficient", ascending=False)

    return model, coefficients, report, auc


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    """Summarize institutional resilience by synthetic organizational unit."""
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_resilience_capacity=("resilience_capacity_score", "mean"),
            avg_institutional_risk=("institutional_risk_score", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_adaptive_learning=("adaptive_learning", "mean"),
            avg_accumulated_fragility=("accumulated_fragility", "mean"),
            recovery_rate=("successful_recovery", "mean"),
            degradation_rate=("major_functional_degradation", "mean"),
        )
        .reset_index()
        .sort_values("avg_institutional_risk", ascending=False)
    )


def main() -> None:
    df = load_data()
    scored = add_resilience_scores(df)

    scored.to_csv(TABLE_DIR / "scored_resilience_observations.csv", index=False)

    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_resilience_summary.csv", index=False)

    _model, coefficients, report, auc = fit_recovery_model(scored)
    coefficients.to_csv(TABLE_DIR / "recovery_model_coefficients.csv", index=False)

    with open(TABLE_DIR / "model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic organizational resilience recovery model\n")
        handle.write("=================================================\n\n")
        handle.write(f"AUC: {auc:.3f}\n\n")
        handle.write(report)
        handle.write(
            "\n\nResponsible-use reminder: This model is a synthetic "
            "methods demonstration for institutional learning. It must not "
            "be used for employee screening, employment selection, workplace "
            "surveillance, individual performance management, or psychological "
            "assessment.\n"
        )

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)


if __name__ == "__main__":
    main()

"""
Leadership in Organizational Psychology
Advanced synthetic Python workflow.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
leadership-system review, trust/communication/legitimacy/psychological-safety
analysis, and reproducible workflows only. Not for employment decisions,
workplace surveillance, productivity ranking, loyalty scoring, political-
influence scoring, dissent tracking, or psychological assessment.
"""

from pathlib import Path
import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression, LinearRegression
from sklearn.metrics import classification_report, roc_auc_score
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler

ROOT = Path(__file__).resolve().parents[1]
RAW_DATA = ROOT / "data" / "raw" / "leadership_capacity_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
TABLE_DIR.mkdir(parents=True, exist_ok=True)

FEATURES = [
    "trust_generation", "communication_clarity", "motivational_support",
    "legitimacy_quality", "adaptive_coordination", "psychological_safety",
    "role_clarity", "ethical_accountability", "decision_transparency",
    "voice_access", "ambiguity_pressure", "distrust_pressure",
    "fragmentation_pressure", "overload_pressure"
]


def add_scores(df: pd.DataFrame) -> pd.DataFrame:
    scored = df.copy()
    scored["leadership_capacity_score"] = (
        0.11 * scored["trust_generation"]
        + 0.11 * scored["communication_clarity"]
        + 0.10 * scored["motivational_support"]
        + 0.11 * scored["legitimacy_quality"]
        + 0.10 * scored["adaptive_coordination"]
        + 0.10 * scored["psychological_safety"]
        + 0.08 * scored["role_clarity"]
        + 0.09 * scored["ethical_accountability"]
        + 0.08 * scored["decision_transparency"]
        + 0.08 * scored["voice_access"]
        - 0.07 * scored["ambiguity_pressure"]
        - 0.08 * scored["distrust_pressure"]
        - 0.07 * scored["fragmentation_pressure"]
        - 0.06 * scored["overload_pressure"]
    ).clip(0, 100)

    scored["institutional_stability_score"] = (
        0.22 * scored["leadership_capacity_score"]
        + 0.13 * scored["legitimacy_quality"]
        + 0.12 * scored["trust_generation"]
        + 0.11 * scored["communication_clarity"]
        + 0.10 * scored["role_clarity"]
        + 0.10 * scored["adaptive_coordination"]
        + 0.10 * scored["ethical_accountability"]
        + 0.07 * scored["voice_access"]
        + 0.05 * scored["psychological_safety"]
    ).clip(0, 100)

    scored["leadership_system_risk_score"] = (
        0.10 * (100 - scored["trust_generation"])
        + 0.09 * (100 - scored["communication_clarity"])
        + 0.08 * (100 - scored["motivational_support"])
        + 0.11 * (100 - scored["legitimacy_quality"])
        + 0.08 * (100 - scored["adaptive_coordination"])
        + 0.10 * (100 - scored["psychological_safety"])
        + 0.07 * (100 - scored["role_clarity"])
        + 0.09 * (100 - scored["ethical_accountability"])
        + 0.07 * (100 - scored["decision_transparency"])
        + 0.08 * (100 - scored["voice_access"])
        + 0.08 * scored["ambiguity_pressure"]
        + 0.10 * scored["distrust_pressure"]
        + 0.09 * scored["fragmentation_pressure"]
        + 0.08 * scored["overload_pressure"]
    ).clip(0, 100)

    scored["leadership_review_priority"] = np.select(
        [
            (scored["leadership_system_risk_score"] >= 70)
            | (scored["leadership_capacity_score"] < 45)
            | (scored["performance_risk"] == 1)
            | (scored["voice_suppression_risk"] == 1)
            | (scored["legitimacy_decay_risk"] == 1)
            | (scored["fragmentation_risk"] == 1),
            (scored["leadership_system_risk_score"] >= 50)
            | (scored["leadership_capacity_score"] < 60),
        ],
        ["Immediate Review", "Structured Review"],
        default="Routine Monitoring",
    )
    return scored


def summarize_units(df: pd.DataFrame) -> pd.DataFrame:
    return (
        df.groupby("unit_id")
        .agg(
            observations=("period", "count"),
            avg_leadership_capacity=("leadership_capacity_score", "mean"),
            avg_institutional_stability=("institutional_stability_score", "mean"),
            avg_leadership_system_risk=("leadership_system_risk_score", "mean"),
            avg_trust_generation=("trust_generation", "mean"),
            avg_communication_clarity=("communication_clarity", "mean"),
            avg_legitimacy_quality=("legitimacy_quality", "mean"),
            avg_psychological_safety=("psychological_safety", "mean"),
            avg_fragmentation_pressure=("fragmentation_pressure", "mean"),
            avg_overload_pressure=("overload_pressure", "mean"),
            performance_risk_rate=("performance_risk", "mean"),
            voice_suppression_risk_rate=("voice_suppression_risk", "mean"),
            legitimacy_decay_risk_rate=("legitimacy_decay_risk", "mean"),
            fragmentation_risk_rate=("fragmentation_risk", "mean"),
        )
        .reset_index()
        .sort_values("avg_leadership_system_risk", ascending=False)
    )


def main() -> None:
    df = pd.read_csv(RAW_DATA)
    scored = add_scores(df)
    scored.to_csv(TABLE_DIR / "scored_leadership_capacity_observations.csv", index=False)
    unit_summary = summarize_units(scored)
    unit_summary.to_csv(TABLE_DIR / "unit_leadership_capacity_summary.csv", index=False)

    x = scored[FEATURES]
    y = scored["performance_risk"]
    x_train, x_test, y_train, y_test = train_test_split(
        x, y, test_size=0.30, random_state=111, stratify=y
    )
    model = Pipeline([("scale", StandardScaler()), ("logit", LogisticRegression(max_iter=3000))])
    model.fit(x_train, y_train)
    probabilities = model.predict_proba(x_test)[:, 1]
    predictions = model.predict(x_test)

    coefficients = pd.DataFrame({
        "feature": FEATURES,
        "coefficient": model.named_steps["logit"].coef_[0],
    }).sort_values("coefficient", ascending=False)
    coefficients.to_csv(TABLE_DIR / "performance_risk_coefficients.csv", index=False)

    linear_model = LinearRegression().fit(scored[FEATURES], scored["leadership_capacity_score"])
    pd.DataFrame({"feature": FEATURES, "coefficient": linear_model.coef_}).sort_values(
        "coefficient", ascending=False
    ).to_csv(TABLE_DIR / "leadership_capacity_coefficients.csv", index=False)

    with open(TABLE_DIR / "performance_risk_model_report.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic leadership capacity performance-risk model\n")
        handle.write("====================================================\n\n")
        handle.write(f"AUC: {roc_auc_score(y_test, probabilities):.3f}\n\n")
        handle.write(classification_report(y_test, predictions))
        handle.write("\n\nResponsible-use reminder: institutional learning only; not for employment decisions or surveillance.\n")

    print("Wrote outputs to:", TABLE_DIR)
    print(unit_summary)


if __name__ == "__main__":
    main()

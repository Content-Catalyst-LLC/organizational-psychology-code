# Organizational decision-making analytics scaffold.
# Synthetic-data workflow for decision quality, institutional risk, context audit,
# and implementation-error analysis.
# Not for employee screening, hiring, promotion, discipline, surveillance,
# individual performance management, or employment selection.

from pathlib import Path
import numpy as np
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report, roc_auc_score

BASE = Path(__file__).resolve().parents[1]
RAW = BASE / "data" / "raw"
OUT = BASE / "outputs" / "tables"
OUT.mkdir(parents=True, exist_ok=True)

df = pd.read_csv(RAW / "organizational_decision_panel.csv")
audit = pd.read_csv(RAW / "decision_context_audit.csv")

positive = [
    "information_quality",
    "psychological_safety",
    "incentive_alignment",
    "interpretive_diversity",
    "learning_capacity",
]
negative = [
    "coordination_load",
    "time_pressure",
    "bias_pressure",
    "leadership_fragmentation",
    "metric_distortion",
]

df["computed_decision_quality"] = df[positive].sum(axis=1) - df[negative].sum(axis=1)

risk_raw = (
    (100 - df["information_quality"]) * 0.20
    + (100 - df["psychological_safety"]) * 0.18
    + (100 - df["incentive_alignment"]) * 0.14
    + df["coordination_load"] * 0.12
    + df["time_pressure"] * 0.10
    + df["bias_pressure"] * 0.12
    + df["leadership_fragmentation"] * 0.07
    + df["metric_distortion"] * 0.07
    + df["implementation_error_rate"] * 100 * 0.10
)
df["institutional_decision_risk"] = 100 * (risk_raw - risk_raw.min()) / (risk_raw.max() - risk_raw.min())

df["review_priority"] = np.select(
    [
        (df["major_error_event"] == 1) | (df["decision_quality_score"] < 50),
        df["decision_quality_score"].between(50, 65, inclusive="left"),
    ],
    ["Immediate Review", "Structured Review"],
    default="Routine Monitoring",
)

context_cols = [
    "signal_integrity",
    "dissent_protection",
    "decision_rights_clarity",
    "criteria_documentation",
    "incentive_alignment_review",
    "metric_validity_review",
    "frontline_knowledge_channel",
    "post_decision_review",
    "anti_blame_learning_norm",
    "privacy_safeguards",
    "fairness_review",
]
audit["computed_context_quality"] = audit[context_cols].mean(axis=1)
audit["lowest_support_dimension"] = audit[context_cols].idxmin(axis=1)

features = [
    "information_quality",
    "psychological_safety",
    "incentive_alignment",
    "interpretive_diversity",
    "coordination_load",
    "time_pressure",
    "bias_pressure",
    "leadership_fragmentation",
    "metric_distortion",
]

if df["major_error_event"].nunique() > 1:
    X_train, X_test, y_train, y_test = train_test_split(
        df[features],
        df["major_error_event"],
        test_size=0.35,
        random_state=42,
        stratify=df["major_error_event"],
    )
    model = LogisticRegression(max_iter=2000)
    model.fit(X_train, y_train)
    probs = model.predict_proba(X_test)[:, 1]
    preds = model.predict(X_test)

    coef = pd.DataFrame({"feature": features, "coefficient": model.coef_[0]}).sort_values(
        "coefficient", ascending=False
    )
    coef.to_csv(OUT / "implementation_failure_logistic_coefficients.csv", index=False)

    report = pd.DataFrame(classification_report(y_test, preds, output_dict=True)).transpose()
    report.loc["roc_auc", "precision"] = roc_auc_score(y_test, probs)
    report.to_csv(OUT / "implementation_failure_model_report.csv")

team_summary = (
    df.groupby("team_id", as_index=False)
    .agg(
        avg_decision_quality=("decision_quality_score", "mean"),
        avg_information_quality=("information_quality", "mean"),
        avg_psychological_safety=("psychological_safety", "mean"),
        avg_bias_pressure=("bias_pressure", "mean"),
        avg_coordination_load=("coordination_load", "mean"),
        avg_metric_distortion=("metric_distortion", "mean"),
        major_error_rate=("major_error_event", "mean"),
        avg_institutional_decision_risk=("institutional_decision_risk", "mean"),
    )
    .sort_values("avg_institutional_decision_risk", ascending=False)
)

df.to_csv(OUT / "scored_organizational_decisions.csv", index=False)
audit.to_csv(OUT / "decision_context_audit_summary.csv", index=False)
team_summary.to_csv(OUT / "team_decision_risk_summary.csv", index=False)

print("Organizational decision-making workflow complete.")
print(f"Outputs written to: {OUT}")

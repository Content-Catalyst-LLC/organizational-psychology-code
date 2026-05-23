CREATE TABLE IF NOT EXISTS organizational_decisions (
    decision_id INTEGER PRIMARY KEY,
    team_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    decision_domain TEXT NOT NULL,
    information_quality REAL,
    psychological_safety REAL,
    incentive_alignment REAL,
    interpretive_diversity REAL,
    coordination_load REAL,
    time_pressure REAL,
    bias_pressure REAL,
    leadership_fragmentation REAL,
    metric_distortion REAL,
    cross_functional_scope INTEGER,
    decision_quality_score REAL,
    implementation_error_rate REAL,
    major_error_event INTEGER,
    learning_capacity REAL
);

CREATE TABLE IF NOT EXISTS decision_context_audit (
    audit_id INTEGER PRIMARY KEY,
    decision_context TEXT NOT NULL,
    signal_integrity REAL,
    dissent_protection REAL,
    decision_rights_clarity REAL,
    criteria_documentation REAL,
    incentive_alignment_review REAL,
    metric_validity_review REAL,
    frontline_knowledge_channel REAL,
    post_decision_review REAL,
    anti_blame_learning_norm REAL,
    privacy_safeguards REAL,
    fairness_review REAL,
    overall_context_quality REAL
);

CREATE VIEW IF NOT EXISTS decision_quality_indices AS
SELECT
    decision_id,
    team_id,
    period,
    decision_domain,
    (
        information_quality +
        psychological_safety +
        incentive_alignment +
        interpretive_diversity +
        learning_capacity -
        coordination_load -
        time_pressure -
        bias_pressure -
        leadership_fragmentation -
        metric_distortion
    ) AS computed_decision_quality,
    (
        (100 - information_quality) * 0.20 +
        (100 - psychological_safety) * 0.18 +
        (100 - incentive_alignment) * 0.14 +
        coordination_load * 0.12 +
        time_pressure * 0.10 +
        bias_pressure * 0.12 +
        leadership_fragmentation * 0.07 +
        metric_distortion * 0.07 +
        implementation_error_rate * 100 * 0.10
    ) AS institutional_decision_risk
FROM organizational_decisions;

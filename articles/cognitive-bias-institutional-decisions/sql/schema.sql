-- Cognitive Bias in Institutional Decisions
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, decision-governance review, bias-risk analysis,
-- and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline,
-- termination, workplace surveillance, individual performance-management,
-- executive-ranking, productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS bias_pressure_observations;

CREATE TABLE bias_pressure_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    signal_quality REAL NOT NULL,
    viewpoint_diversity REAL NOT NULL,
    analytical_discipline REAL NOT NULL,
    structured_challenge REAL NOT NULL,
    hierarchy_suppression REAL NOT NULL,
    time_pressure REAL NOT NULL,
    routine_reinforcement REAL NOT NULL,
    learning_review REAL NOT NULL,
    group_conformity REAL NOT NULL,
    decision_error INTEGER NOT NULL,
    escalation_of_commitment INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS bias_pressure_scores;

CREATE VIEW bias_pressure_scores AS
SELECT
    unit_id,
    period,
    (
        0.16 * hierarchy_suppression +
        0.15 * time_pressure +
        0.14 * routine_reinforcement +
        0.13 * group_conformity -
        0.16 * viewpoint_diversity -
        0.13 * analytical_discipline -
        0.14 * structured_challenge -
        0.12 * learning_review -
        0.10 * signal_quality
    ) AS bias_pressure_score,
    (
        0.10 * (100 - signal_quality) +
        0.13 * (100 - viewpoint_diversity) +
        0.12 * (100 - analytical_discipline) +
        0.12 * (100 - structured_challenge) +
        0.15 * hierarchy_suppression +
        0.12 * time_pressure +
        0.10 * routine_reinforcement +
        0.08 * (100 - learning_review) +
        0.08 * group_conformity
    ) AS bias_risk_score,
    decision_error,
    escalation_of_commitment
FROM bias_pressure_observations;

-- Example query: synthetic unit bias-governance review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(bias_pressure_score) AS avg_bias_pressure,
    AVG(bias_risk_score) AS avg_bias_risk,
    AVG(decision_error) AS decision_error_rate,
    AVG(escalation_of_commitment) AS escalation_rate
FROM bias_pressure_scores
GROUP BY unit_id
ORDER BY avg_bias_risk DESC;

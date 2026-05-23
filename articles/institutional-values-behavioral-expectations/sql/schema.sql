-- Institutional Values and Behavioral Expectations
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, values-governance review, organizational ethics
-- education, legitimacy analysis, and reproducible workflows. It is not an
-- employee-screening, employment-selection, hiring, promotion, compensation,
-- discipline, termination, workplace surveillance, individual performance-
-- management, cultural-loyalty scoring, morality scoring, values-alignment
-- scoring of workers, productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS institutional_values_observations;

CREATE TABLE institutional_values_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    value_clarity REAL NOT NULL,
    leadership_consistency REAL NOT NULL,
    reinforcement_alignment REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    accountability_strength REAL NOT NULL,
    decoupling_risk REAL NOT NULL,
    incentive_contradiction REAL NOT NULL,
    hierarchy_exemption REAL NOT NULL,
    legitimacy_pressure REAL NOT NULL,
    values_credible INTEGER NOT NULL,
    symbolic_values_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS institutional_values_scores;

CREATE VIEW institutional_values_scores AS
SELECT
    unit_id,
    period,
    (
        0.17 * value_clarity +
        0.16 * leadership_consistency +
        0.16 * reinforcement_alignment +
        0.14 * psychological_safety +
        0.14 * accountability_strength -
        0.10 * decoupling_risk -
        0.09 * incentive_contradiction -
        0.09 * hierarchy_exemption -
        0.05 * legitimacy_pressure
    ) AS value_practice_alignment_score,
    (
        0.12 * (100 - value_clarity) +
        0.14 * (100 - leadership_consistency) +
        0.14 * (100 - reinforcement_alignment) +
        0.10 * (100 - psychological_safety) +
        0.14 * (100 - accountability_strength) +
        0.14 * decoupling_risk +
        0.10 * incentive_contradiction +
        0.08 * hierarchy_exemption +
        0.04 * legitimacy_pressure
    ) AS institutional_values_risk_score,
    values_credible,
    symbolic_values_risk
FROM institutional_values_observations;

-- Example query: synthetic unit values-governance review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(value_practice_alignment_score) AS avg_value_practice_alignment,
    AVG(institutional_values_risk_score) AS avg_institutional_values_risk,
    AVG(values_credible) AS values_credibility_rate,
    AVG(symbolic_values_risk) AS symbolic_values_risk_rate
FROM institutional_values_scores
GROUP BY unit_id
ORDER BY avg_institutional_values_risk DESC;

-- Adaptive Organizations: Institutional Change and Strategic Transformation
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational change governance, and reproducible
-- workflows. It is not an employee-screening, employment-selection, hiring,
-- promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, or psychological assessment tool.

DROP TABLE IF EXISTS adaptive_change_observations;

CREATE TABLE adaptive_change_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    sensing_quality REAL NOT NULL,
    interpretive_coherence REAL NOT NULL,
    governance_alignment REAL NOT NULL,
    learning_capability REAL NOT NULL,
    resource_flexibility REAL NOT NULL,
    institutional_legitimacy REAL NOT NULL,
    organizational_inertia REAL NOT NULL,
    fragmentation REAL NOT NULL,
    resistance_friction REAL NOT NULL,
    environmental_pressure REAL NOT NULL,
    successful_transformation INTEGER NOT NULL,
    symbolic_change INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS adaptive_change_scores;

CREATE VIEW adaptive_change_scores AS
SELECT
    unit_id,
    period,
    (
        0.17 * sensing_quality +
        0.16 * interpretive_coherence +
        0.15 * governance_alignment +
        0.16 * learning_capability +
        0.12 * resource_flexibility +
        0.12 * institutional_legitimacy -
        0.13 * organizational_inertia -
        0.11 * fragmentation -
        0.10 * resistance_friction -
        0.05 * environmental_pressure
    ) AS adaptive_change_capacity_score,
    (
        0.16 * (100 - sensing_quality) +
        0.14 * (100 - interpretive_coherence) +
        0.14 * (100 - governance_alignment) +
        0.14 * (100 - learning_capability) +
        0.10 * (100 - resource_flexibility) +
        0.10 * (100 - institutional_legitimacy) +
        0.10 * organizational_inertia +
        0.06 * fragmentation +
        0.04 * resistance_friction +
        0.02 * environmental_pressure
    ) AS adaptation_risk_score,
    successful_transformation,
    symbolic_change
FROM adaptive_change_observations;

-- Example query: synthetic unit change-governance review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(adaptive_change_capacity_score) AS avg_adaptive_change_capacity,
    AVG(adaptation_risk_score) AS avg_adaptation_risk,
    AVG(successful_transformation) AS transformation_rate,
    AVG(symbolic_change) AS symbolic_change_rate
FROM adaptive_change_scores
GROUP BY unit_id
ORDER BY avg_adaptation_risk DESC;

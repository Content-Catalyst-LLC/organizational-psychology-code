-- Learning Organizations and Knowledge Systems
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational knowledge governance, and reproducible
-- workflows. It is not an employee-screening, employment-selection, hiring,
-- promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, or psychological assessment tool.

DROP TABLE IF EXISTS organizational_learning_observations;

CREATE TABLE organizational_learning_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    information_quality REAL NOT NULL,
    interpretive_openness REAL NOT NULL,
    memory_retention REAL NOT NULL,
    communication_flow REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    governance_support REAL NOT NULL,
    complexity_load REAL NOT NULL,
    silo_intensity REAL NOT NULL,
    incentive_distortion REAL NOT NULL,
    turnover_pressure REAL NOT NULL,
    adaptive_improvement INTEGER NOT NULL,
    knowledge_decay_event INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS organizational_learning_scores;

CREATE VIEW organizational_learning_scores AS
SELECT
    unit_id,
    period,
    (
        0.17 * information_quality +
        0.18 * interpretive_openness +
        0.15 * memory_retention +
        0.15 * communication_flow +
        0.13 * psychological_safety +
        0.10 * governance_support -
        0.07 * complexity_load -
        0.10 * silo_intensity -
        0.10 * incentive_distortion -
        0.05 * turnover_pressure
    ) AS learning_capacity_score,
    (
        0.28 * (100 - memory_retention) +
        0.18 * turnover_pressure +
        0.16 * silo_intensity +
        0.12 * (100 - communication_flow) +
        0.10 * (100 - governance_support) +
        0.10 * incentive_distortion +
        0.06 * complexity_load
    ) AS knowledge_decay_risk_score,
    adaptive_improvement,
    knowledge_decay_event
FROM organizational_learning_observations;

-- Example query: synthetic unit learning review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(learning_capacity_score) AS avg_learning_capacity,
    AVG(knowledge_decay_risk_score) AS avg_knowledge_decay_risk,
    AVG(adaptive_improvement) AS adaptive_improvement_rate,
    AVG(knowledge_decay_event) AS knowledge_decay_event_rate
FROM organizational_learning_scores
GROUP BY unit_id
ORDER BY avg_knowledge_decay_risk DESC;

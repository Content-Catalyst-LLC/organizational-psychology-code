-- Strategic Decision-Making in Complex Organizations
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, strategic governance, decision-process review,
-- and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline,
-- termination, workplace surveillance, individual performance-management,
-- executive-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS strategic_decision_observations;

CREATE TABLE strategic_decision_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    sensing_quality REAL NOT NULL,
    interpretive_coherence REAL NOT NULL,
    knowledge_integration REAL NOT NULL,
    option_diversity REAL NOT NULL,
    governance_quality REAL NOT NULL,
    adaptive_learning REAL NOT NULL,
    bias_pressure REAL NOT NULL,
    political_distortion REAL NOT NULL,
    complexity_load REAL NOT NULL,
    environmental_turbulence REAL NOT NULL,
    strategic_success INTEGER NOT NULL,
    symbolic_strategy INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS strategic_decision_scores;

CREATE VIEW strategic_decision_scores AS
SELECT
    unit_id,
    period,
    (
        0.17 * sensing_quality +
        0.16 * interpretive_coherence +
        0.16 * knowledge_integration +
        0.12 * option_diversity +
        0.13 * governance_quality +
        0.14 * adaptive_learning -
        0.12 * bias_pressure -
        0.10 * political_distortion -
        0.09 * complexity_load -
        0.08 * environmental_turbulence
    ) AS strategic_decision_quality_score,
    (
        0.15 * (100 - sensing_quality) +
        0.13 * (100 - interpretive_coherence) +
        0.14 * (100 - knowledge_integration) +
        0.08 * (100 - option_diversity) +
        0.12 * (100 - governance_quality) +
        0.12 * (100 - adaptive_learning) +
        0.10 * bias_pressure +
        0.08 * political_distortion +
        0.04 * complexity_load +
        0.04 * environmental_turbulence
    ) AS strategic_risk_score,
    strategic_success,
    symbolic_strategy
FROM strategic_decision_observations;

-- Example query: synthetic unit strategic review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(strategic_decision_quality_score) AS avg_strategic_decision_quality,
    AVG(strategic_risk_score) AS avg_strategic_risk,
    AVG(strategic_success) AS strategic_success_rate,
    AVG(symbolic_strategy) AS symbolic_strategy_rate
FROM strategic_decision_scores
GROUP BY unit_id
ORDER BY avg_strategic_risk DESC;

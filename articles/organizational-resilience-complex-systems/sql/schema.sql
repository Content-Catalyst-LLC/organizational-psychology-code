-- Organizational Resilience in Complex Systems
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, and reproducible workflows. It is not an
-- employee-screening, employment-selection, hiring, promotion, compensation,
-- discipline, termination, workplace surveillance, individual performance-
-- management, or psychological assessment tool.

DROP TABLE IF EXISTS organizational_resilience_observations;

CREATE TABLE organizational_resilience_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    robustness REAL NOT NULL,
    redundancy REAL NOT NULL,
    adaptive_learning REAL NOT NULL,
    coordination_integrity REAL NOT NULL,
    governance_responsiveness REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    external_exposure REAL NOT NULL,
    complexity_load REAL NOT NULL,
    accumulated_fragility REAL NOT NULL,
    shock_intensity REAL NOT NULL,
    successful_recovery INTEGER NOT NULL,
    major_functional_degradation INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

-- Example institutional resilience view.
DROP VIEW IF EXISTS organizational_resilience_scores;

CREATE VIEW organizational_resilience_scores AS
SELECT
    unit_id,
    period,
    (
        0.18 * robustness +
        0.12 * redundancy +
        0.16 * adaptive_learning +
        0.14 * coordination_integrity +
        0.12 * governance_responsiveness +
        0.13 * psychological_safety -
        0.08 * external_exposure -
        0.07 * complexity_load -
        0.10 * accumulated_fragility
    ) AS resilience_capacity_score,
    (
        0.20 * (100 - robustness) +
        0.12 * (100 - redundancy) +
        0.16 * (100 - adaptive_learning) +
        0.12 * (100 - coordination_integrity) +
        0.10 * (100 - governance_responsiveness) +
        0.10 * (100 - psychological_safety) +
        0.08 * external_exposure +
        0.06 * complexity_load +
        0.06 * accumulated_fragility
    ) AS institutional_risk_score,
    successful_recovery,
    major_functional_degradation
FROM organizational_resilience_observations;

-- Example query: unit-level review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(resilience_capacity_score) AS avg_resilience_capacity,
    AVG(institutional_risk_score) AS avg_institutional_risk,
    AVG(successful_recovery) AS recovery_rate,
    AVG(major_functional_degradation) AS degradation_rate
FROM organizational_resilience_scores
GROUP BY unit_id
ORDER BY avg_institutional_risk DESC;

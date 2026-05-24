-- Organizations as Complex Behavioral Systems
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational psychology education, complex
-- behavioral systems analysis, and reproducible workflows. It is not an
-- employee-screening, employment-selection, hiring, promotion, compensation,
-- discipline, termination, workplace surveillance, individual performance-
-- management, productivity-ranking, loyalty-scoring, dissent tracking, or
-- psychological assessment tool.

DROP TABLE IF EXISTS complex_behavioral_system_observations;

CREATE TABLE complex_behavioral_system_observations (
    unit_id TEXT NOT NULL,
    person_id TEXT NOT NULL,
    capability REAL NOT NULL,
    motivation REAL NOT NULL,
    role_clarity REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    leadership_trust REAL NOT NULL,
    cultural_coherence REAL NOT NULL,
    incentive_alignment REAL NOT NULL,
    information_flow REAL NOT NULL,
    learning_capacity REAL NOT NULL,
    redundancy_slack REAL NOT NULL,
    workload_pressure REAL NOT NULL,
    silence_risk REAL NOT NULL,
    fragmentation_pressure REAL NOT NULL,
    environmental_uncertainty REAL NOT NULL,
    behavior_quality REAL NOT NULL,
    complex_system_risk REAL NOT NULL,
    PRIMARY KEY (unit_id, person_id)
);

DROP VIEW IF EXISTS modeled_complex_behavioral_system_scores;

CREATE VIEW modeled_complex_behavioral_system_scores AS
SELECT
    unit_id,
    person_id,
    (
        0.13 * capability +
        0.12 * motivation +
        0.12 * role_clarity +
        0.11 * psychological_safety +
        0.11 * leadership_trust +
        0.09 * cultural_coherence +
        0.09 * incentive_alignment +
        0.08 * information_flow +
        0.07 * learning_capacity +
        0.05 * redundancy_slack -
        0.08 * workload_pressure -
        0.06 * silence_risk -
        0.06 * fragmentation_pressure -
        0.05 * environmental_uncertainty
    ) AS modeled_behavior_quality,
    (
        0.11 * (100 - psychological_safety) +
        0.11 * (100 - leadership_trust) +
        0.09 * (100 - cultural_coherence) +
        0.09 * (100 - incentive_alignment) +
        0.09 * (100 - information_flow) +
        0.10 * (100 - learning_capacity) +
        0.08 * (100 - redundancy_slack) +
        0.09 * workload_pressure +
        0.08 * silence_risk +
        0.10 * fragmentation_pressure +
        0.08 * environmental_uncertainty
    ) AS modeled_complex_system_risk,
    (
        0.18 * psychological_safety +
        0.17 * leadership_trust +
        0.16 * information_flow +
        0.18 * learning_capacity +
        0.14 * redundancy_slack +
        0.09 * cultural_coherence +
        0.08 * incentive_alignment
    ) AS resilience_capacity_index
FROM complex_behavioral_system_observations;

-- Example query: unit-level complex behavioral system summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(modeled_behavior_quality) AS avg_modeled_behavior_quality,
    AVG(modeled_complex_system_risk) AS avg_modeled_complex_system_risk,
    AVG(resilience_capacity_index) AS avg_resilience_capacity
FROM modeled_complex_behavioral_system_scores
GROUP BY unit_id
ORDER BY avg_modeled_complex_system_risk DESC;

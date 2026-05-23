-- Culture Change in Organizations
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, culture-change review, organizational development
-- education, and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline,
-- termination, workplace surveillance, individual performance-management,
-- cultural-loyalty scoring, productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS culture_change_observations;

CREATE TABLE culture_change_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    leadership_credibility REAL NOT NULL,
    narrative_coherence REAL NOT NULL,
    reinforcement_alignment REAL NOT NULL,
    adaptive_learning REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    identity_adaptability REAL NOT NULL,
    resistance_intensity REAL NOT NULL,
    subcultural_fragmentation REAL NOT NULL,
    legacy_lock_in REAL NOT NULL,
    leadership_turnover INTEGER NOT NULL,
    successful_cultural_adoption INTEGER NOT NULL,
    symbolic_culture_change INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS culture_change_scores;

CREATE VIEW culture_change_scores AS
SELECT
    unit_id,
    period,
    (
        0.17 * leadership_credibility +
        0.15 * narrative_coherence +
        0.15 * reinforcement_alignment +
        0.14 * adaptive_learning +
        0.13 * psychological_safety +
        0.11 * identity_adaptability -
        0.12 * resistance_intensity -
        0.10 * subcultural_fragmentation -
        0.11 * legacy_lock_in -
        4.00 * leadership_turnover
    ) AS culture_change_capacity_score,
    (
        0.14 * (100 - leadership_credibility) +
        0.10 * (100 - narrative_coherence) +
        0.14 * (100 - reinforcement_alignment) +
        0.10 * (100 - adaptive_learning) +
        0.10 * (100 - psychological_safety) +
        0.08 * (100 - identity_adaptability) +
        0.14 * resistance_intensity +
        0.10 * subcultural_fragmentation +
        0.08 * legacy_lock_in +
        2.00 * leadership_turnover
    ) AS culture_risk_score,
    successful_cultural_adoption,
    symbolic_culture_change
FROM culture_change_observations;

-- Example query: synthetic unit culture-change review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(culture_change_capacity_score) AS avg_culture_change_capacity,
    AVG(culture_risk_score) AS avg_culture_risk,
    AVG(successful_cultural_adoption) AS cultural_adoption_rate,
    AVG(symbolic_culture_change) AS symbolic_culture_change_rate
FROM culture_change_scores
GROUP BY unit_id
ORDER BY avg_culture_risk DESC;

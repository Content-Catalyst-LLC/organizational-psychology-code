-- Organizational Culture and Shared Norms
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, culture review, organizational development education,
-- legitimacy analysis, and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline, termination,
-- workplace surveillance, individual performance-management, cultural-loyalty
-- scoring, cultural-fit scoring, productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS organizational_culture_observations;

CREATE TABLE organizational_culture_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    value_alignment REAL NOT NULL,
    normative_consistency REAL NOT NULL,
    leadership_credibility REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    shared_meaning REAL NOT NULL,
    contradiction REAL NOT NULL,
    fragmentation REAL NOT NULL,
    incentive_distortion REAL NOT NULL,
    external_pressure REAL NOT NULL,
    strong_institutional_performance INTEGER NOT NULL,
    symbolic_culture_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS organizational_culture_scores;

CREATE VIEW organizational_culture_scores AS
SELECT
    unit_id,
    period,
    (
        0.18 * value_alignment +
        0.16 * normative_consistency +
        0.15 * leadership_credibility +
        0.14 * psychological_safety +
        0.14 * shared_meaning -
        0.10 * contradiction -
        0.08 * fragmentation -
        0.10 * incentive_distortion -
        0.05 * external_pressure
    ) AS cultural_coherence_score,
    (
        0.14 * (100 - value_alignment) +
        0.12 * (100 - normative_consistency) +
        0.12 * (100 - leadership_credibility) +
        0.12 * (100 - psychological_safety) +
        0.12 * (100 - shared_meaning) +
        0.14 * contradiction +
        0.10 * fragmentation +
        0.10 * incentive_distortion +
        0.04 * external_pressure
    ) AS culture_risk_score,
    strong_institutional_performance,
    symbolic_culture_risk
FROM organizational_culture_observations;

-- Example query: synthetic unit culture review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(cultural_coherence_score) AS avg_cultural_coherence,
    AVG(culture_risk_score) AS avg_culture_risk,
    AVG(strong_institutional_performance) AS performance_integrity_rate,
    AVG(symbolic_culture_risk) AS symbolic_culture_risk_rate
FROM organizational_culture_scores
GROUP BY unit_id
ORDER BY avg_culture_risk DESC;

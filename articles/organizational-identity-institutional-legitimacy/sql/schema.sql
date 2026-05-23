-- Organizational Identity and Institutional Legitimacy
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational identity review, legitimacy analysis,
-- governance review, and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline, termination,
-- workplace surveillance, individual performance-management, cultural-loyalty
-- scoring, worker legitimacy scoring, productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS identity_legitimacy_observations;

CREATE TABLE identity_legitimacy_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    mission_clarity REAL NOT NULL,
    value_practice_alignment REAL NOT NULL,
    narrative_continuity REAL NOT NULL,
    leadership_credibility REAL NOT NULL,
    behavioral_consistency REAL NOT NULL,
    internal_fragmentation REAL NOT NULL,
    identity_contradiction REAL NOT NULL,
    legitimacy_pressure REAL NOT NULL,
    stakeholder_legitimacy INTEGER NOT NULL,
    symbolic_identity_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS identity_legitimacy_scores;

CREATE VIEW identity_legitimacy_scores AS
SELECT
    unit_id,
    period,
    (
        0.18 * mission_clarity +
        0.17 * value_practice_alignment +
        0.15 * narrative_continuity +
        0.14 * leadership_credibility +
        0.14 * behavioral_consistency -
        0.10 * internal_fragmentation -
        0.07 * identity_contradiction -
        0.05 * legitimacy_pressure
    ) AS identity_coherence_score,
    (
        0.14 * (100 - mission_clarity) +
        0.16 * (100 - value_practice_alignment) +
        0.10 * (100 - narrative_continuity) +
        0.12 * (100 - leadership_credibility) +
        0.10 * (100 - behavioral_consistency) +
        0.12 * internal_fragmentation +
        0.16 * identity_contradiction +
        0.10 * legitimacy_pressure
    ) AS identity_risk_score,
    stakeholder_legitimacy,
    symbolic_identity_risk
FROM identity_legitimacy_observations;

-- Example query: synthetic unit identity-legitimacy review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(identity_coherence_score) AS avg_identity_coherence,
    AVG(identity_risk_score) AS avg_identity_risk,
    AVG(stakeholder_legitimacy) AS stakeholder_legitimacy_rate,
    AVG(symbolic_identity_risk) AS symbolic_identity_risk_rate
FROM identity_legitimacy_scores
GROUP BY unit_id
ORDER BY avg_identity_risk DESC;

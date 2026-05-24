-- Human Behavior in Organizations
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational psychology education, human-behavior
-- systems analysis, and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline,
-- termination, workplace surveillance, individual performance-management,
-- productivity-ranking, loyalty-scoring, dissent tracking, or psychological
-- assessment tool.

DROP TABLE IF EXISTS human_behavior_observations;

CREATE TABLE human_behavior_observations (
    unit_id TEXT NOT NULL,
    person_id TEXT NOT NULL,
    capability REAL NOT NULL,
    motivation REAL NOT NULL,
    role_clarity REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    leadership_trust REAL NOT NULL,
    cultural_norm_strength REAL NOT NULL,
    incentive_alignment REAL NOT NULL,
    workload_pressure REAL NOT NULL,
    burnout_pressure REAL NOT NULL,
    hierarchical_pressure REAL NOT NULL,
    perceived_voice_efficacy REAL NOT NULL,
    fear_of_retaliation REAL NOT NULL,
    behavior_quality REAL NOT NULL,
    voice_behavior INTEGER NOT NULL,
    behavior_system_risk REAL NOT NULL,
    PRIMARY KEY (unit_id, person_id)
);

DROP VIEW IF EXISTS modeled_human_behavior_scores;

CREATE VIEW modeled_human_behavior_scores AS
SELECT
    unit_id,
    person_id,
    (
        0.16 * capability +
        0.15 * motivation +
        0.14 * role_clarity +
        0.12 * psychological_safety +
        0.12 * leadership_trust +
        0.10 * cultural_norm_strength +
        0.09 * incentive_alignment -
        0.08 * workload_pressure -
        0.08 * burnout_pressure -
        0.06 * hierarchical_pressure
    ) AS modeled_behavior_quality,
    (
        0.12 * (100 - role_clarity) +
        0.15 * (100 - psychological_safety) +
        0.15 * (100 - leadership_trust) +
        0.10 * (100 - cultural_norm_strength) +
        0.10 * (100 - incentive_alignment) +
        0.13 * workload_pressure +
        0.13 * burnout_pressure +
        0.07 * hierarchical_pressure +
        0.05 * fear_of_retaliation
    ) AS modeled_behavior_system_risk,
    voice_behavior
FROM human_behavior_observations;

-- Example query: unit-level behavior-system summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(modeled_behavior_quality) AS avg_modeled_behavior_quality,
    AVG(modeled_behavior_system_risk) AS avg_modeled_behavior_system_risk,
    AVG(voice_behavior) AS voice_rate
FROM modeled_human_behavior_scores
GROUP BY unit_id
ORDER BY avg_modeled_behavior_system_risk DESC;

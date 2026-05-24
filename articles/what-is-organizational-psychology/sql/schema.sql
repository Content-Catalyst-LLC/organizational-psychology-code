-- What Is Organizational Psychology?
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational psychology education, and reproducible
-- workflows. It is not an employee-screening, employment-selection, hiring,
-- promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, productivity-ranking, loyalty-scoring,
-- dissent tracking, or psychological assessment tool.

DROP TABLE IF EXISTS organizational_psychology_observations;

CREATE TABLE organizational_psychology_observations (
    team_id TEXT NOT NULL,
    person_id TEXT NOT NULL,
    capability REAL NOT NULL,
    motivation REAL NOT NULL,
    role_clarity REAL NOT NULL,
    autonomy REAL NOT NULL,
    fairness REAL NOT NULL,
    team_coordination REAL NOT NULL,
    leadership_trust REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    communication_quality REAL NOT NULL,
    culture_strength REAL NOT NULL,
    workload_pressure REAL NOT NULL,
    burnout_pressure REAL NOT NULL,
    institutional_support REAL NOT NULL,
    voice_access REAL NOT NULL,
    outcome_quality REAL NOT NULL,
    work_system_risk REAL NOT NULL,
    PRIMARY KEY (team_id, person_id)
);

DROP VIEW IF EXISTS modeled_work_system_scores;

CREATE VIEW modeled_work_system_scores AS
SELECT
    team_id,
    person_id,
    (
        0.11 * capability +
        0.10 * motivation +
        0.10 * role_clarity +
        0.07 * autonomy +
        0.08 * fairness +
        0.09 * team_coordination +
        0.10 * leadership_trust +
        0.10 * psychological_safety +
        0.08 * communication_quality +
        0.06 * culture_strength +
        0.08 * institutional_support +
        0.06 * voice_access -
        0.07 * workload_pressure -
        0.08 * burnout_pressure
    ) AS modeled_outcome_quality,
    (
        0.08 * (100 - role_clarity) +
        0.08 * (100 - autonomy) +
        0.09 * (100 - fairness) +
        0.09 * (100 - team_coordination) +
        0.10 * (100 - leadership_trust) +
        0.10 * (100 - psychological_safety) +
        0.08 * (100 - communication_quality) +
        0.07 * (100 - culture_strength) +
        0.08 * (100 - institutional_support) +
        0.08 * (100 - voice_access) +
        0.12 * workload_pressure +
        0.13 * burnout_pressure
    ) AS modeled_work_system_risk
FROM organizational_psychology_observations;

-- Example query: team-level work-system summary.
SELECT
    team_id,
    COUNT(*) AS observations,
    AVG(modeled_outcome_quality) AS avg_modeled_outcome_quality,
    AVG(modeled_work_system_risk) AS avg_modeled_work_system_risk
FROM modeled_work_system_scores
GROUP BY team_id
ORDER BY avg_modeled_work_system_risk DESC;

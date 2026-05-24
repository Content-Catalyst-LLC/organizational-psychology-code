-- Job Satisfaction and Organizational Commitment
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, work-attitude review, retention-system education,
-- fairness and workload analysis, leadership and culture review, and reproducible
-- workflows. It is not an employee-screening, employment-selection, hiring,
-- promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, cultural-loyalty scoring, commitment
-- scoring of workers, retention-risk scoring of individual workers,
-- productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS satisfaction_commitment_observations;

CREATE TABLE satisfaction_commitment_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    leadership_support REAL NOT NULL,
    reward_fairness REAL NOT NULL,
    developmental_opportunity REAL NOT NULL,
    workload_balance REAL NOT NULL,
    institutional_trust REAL NOT NULL,
    cultural_alignment REAL NOT NULL,
    role_insecurity REAL NOT NULL,
    exhaustion_pressure REAL NOT NULL,
    affective_commitment REAL NOT NULL,
    continuance_commitment REAL NOT NULL,
    normative_commitment REAL NOT NULL,
    high_retention_risk INTEGER NOT NULL,
    symbolic_commitment_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS satisfaction_commitment_scores;

CREATE VIEW satisfaction_commitment_scores AS
SELECT
    unit_id,
    period,
    (
        0.16 * leadership_support +
        0.15 * reward_fairness +
        0.13 * developmental_opportunity +
        0.14 * workload_balance +
        0.13 * institutional_trust +
        0.10 * cultural_alignment -
        0.09 * role_insecurity -
        0.10 * exhaustion_pressure
    ) AS job_satisfaction_score,
    (
        0.18 * affective_commitment +
        0.12 * normative_commitment +
        0.13 * institutional_trust +
        0.11 * cultural_alignment +
        0.10 * leadership_support +
        0.08 * developmental_opportunity -
        0.08 * role_insecurity -
        0.08 * exhaustion_pressure -
        0.04 * continuance_commitment
    ) AS organizational_commitment_score,
    (
        0.13 * role_insecurity +
        0.14 * exhaustion_pressure +
        0.12 * continuance_commitment +
        0.12 * symbolic_commitment_risk * 100 +
        0.12 * (100 - institutional_trust) +
        0.10 * (100 - reward_fairness) +
        0.10 * (100 - workload_balance)
    ) AS retention_system_risk_score,
    high_retention_risk,
    symbolic_commitment_risk
FROM satisfaction_commitment_observations;

-- Example query: synthetic unit work-attitude review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(job_satisfaction_score) AS avg_job_satisfaction,
    AVG(organizational_commitment_score) AS avg_organizational_commitment,
    AVG(retention_system_risk_score) AS avg_retention_system_risk,
    AVG(high_retention_risk) AS high_retention_risk_rate,
    AVG(symbolic_commitment_risk) AS symbolic_commitment_risk_rate
FROM satisfaction_commitment_scores
GROUP BY unit_id
ORDER BY avg_retention_system_risk DESC;

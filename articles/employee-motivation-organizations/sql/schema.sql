-- Employee Motivation in Organizations
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, motivational-systems review, work-design education,
-- autonomy/fairness/trust/workload analysis, leadership and culture review,
-- and reproducible workflows. It is not an employee-screening, employment-
-- selection, hiring, promotion, compensation, discipline, termination,
-- workplace surveillance, individual performance-management, productivity-
-- ranking, motivation scoring, loyalty scoring, or psychological assessment
-- tool.

DROP TABLE IF EXISTS motivation_system_observations;

CREATE TABLE motivation_system_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    autonomy_support REAL NOT NULL,
    competence_development REAL NOT NULL,
    recognition_quality REAL NOT NULL,
    institutional_trust REAL NOT NULL,
    goal_clarity REAL NOT NULL,
    fairness_perception REAL NOT NULL,
    workload_strain REAL NOT NULL,
    control_pressure REAL NOT NULL,
    relatedness REAL NOT NULL,
    meaningful_work REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    leadership_credibility REAL NOT NULL,
    performance_risk INTEGER NOT NULL,
    burnout_risk INTEGER NOT NULL,
    controlled_motivation_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS motivation_system_scores;

CREATE VIEW motivation_system_scores AS
SELECT
    unit_id,
    period,
    (
        0.12 * autonomy_support +
        0.11 * competence_development +
        0.10 * recognition_quality +
        0.12 * institutional_trust +
        0.10 * goal_clarity +
        0.11 * fairness_perception +
        0.10 * relatedness +
        0.11 * meaningful_work +
        0.10 * psychological_safety +
        0.10 * leadership_credibility -
        0.08 * workload_strain -
        0.07 * control_pressure
    ) AS motivation_quality_score,
    (
        0.10 * (100 - autonomy_support) +
        0.09 * (100 - competence_development) +
        0.08 * (100 - recognition_quality) +
        0.12 * (100 - institutional_trust) +
        0.08 * (100 - goal_clarity) +
        0.11 * (100 - fairness_perception) +
        0.08 * (100 - relatedness) +
        0.09 * (100 - meaningful_work) +
        0.10 * (100 - psychological_safety) +
        0.09 * (100 - leadership_credibility) +
        0.11 * workload_strain +
        0.10 * control_pressure
    ) AS motivation_system_risk_score,
    (
        0.30 * workload_strain +
        0.25 * control_pressure +
        0.15 * (100 - autonomy_support) +
        0.12 * (100 - psychological_safety) +
        0.10 * burnout_risk * 100 +
        0.08 * controlled_motivation_risk * 100
    ) AS burnout_control_risk_score,
    performance_risk,
    burnout_risk,
    controlled_motivation_risk
FROM motivation_system_observations;

-- Example query: synthetic motivational-system review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(motivation_quality_score) AS avg_motivation_quality,
    AVG(motivation_system_risk_score) AS avg_motivation_system_risk,
    AVG(burnout_control_risk_score) AS avg_burnout_control_risk,
    AVG(performance_risk) AS performance_risk_rate,
    AVG(burnout_risk) AS burnout_risk_rate,
    AVG(controlled_motivation_risk) AS controlled_motivation_risk_rate
FROM motivation_system_scores
GROUP BY unit_id
ORDER BY avg_motivation_system_risk DESC;

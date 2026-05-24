-- Goal Setting and Performance Systems
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, goal-system review, performance-system education,
-- feedback-quality analysis, metric-governance review, strategic-alignment
-- analysis, and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline,
-- termination, workplace surveillance, individual performance-management,
-- productivity-ranking, goal-compliance scoring, cultural-loyalty scoring,
-- or psychological assessment tool.

DROP TABLE IF EXISTS goal_system_observations;

CREATE TABLE goal_system_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    goal_clarity REAL NOT NULL,
    goal_challenge REAL NOT NULL,
    feedback_quality REAL NOT NULL,
    employee_commitment REAL NOT NULL,
    strategic_alignment REAL NOT NULL,
    overload_pressure REAL NOT NULL,
    metric_distortion REAL NOT NULL,
    incentive_misalignment REAL NOT NULL,
    review_quality REAL NOT NULL,
    proxy_drift REAL NOT NULL,
    goal_feasibility REAL NOT NULL,
    performance_risk INTEGER NOT NULL,
    metric_gaming_risk INTEGER NOT NULL,
    symbolic_alignment_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS goal_system_scores;

CREATE VIEW goal_system_scores AS
SELECT
    unit_id,
    period,
    (
        0.13 * goal_clarity +
        0.10 * goal_challenge +
        0.13 * feedback_quality +
        0.11 * employee_commitment +
        0.13 * strategic_alignment +
        0.11 * review_quality +
        0.11 * goal_feasibility -
        0.07 * overload_pressure -
        0.06 * metric_distortion -
        0.05 * incentive_misalignment -
        0.04 * proxy_drift
    ) AS goal_system_effectiveness_score,
    (
        0.12 * (100 - goal_clarity) +
        0.08 * (100 - goal_challenge) +
        0.13 * (100 - feedback_quality) +
        0.10 * (100 - employee_commitment) +
        0.13 * (100 - strategic_alignment) +
        0.10 * (100 - review_quality) +
        0.10 * (100 - goal_feasibility) +
        0.11 * overload_pressure +
        0.09 * metric_distortion +
        0.08 * incentive_misalignment +
        0.06 * proxy_drift
    ) AS goal_system_risk_score,
    (
        0.28 * metric_distortion +
        0.26 * proxy_drift +
        0.20 * incentive_misalignment +
        0.14 * (100 - review_quality) +
        0.12 * metric_gaming_risk * 100
    ) AS metric_governance_risk_score,
    performance_risk,
    metric_gaming_risk,
    symbolic_alignment_risk
FROM goal_system_observations;

-- Example query: synthetic goal-system review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(goal_system_effectiveness_score) AS avg_goal_system_effectiveness,
    AVG(goal_system_risk_score) AS avg_goal_system_risk,
    AVG(metric_governance_risk_score) AS avg_metric_governance_risk,
    AVG(performance_risk) AS performance_risk_rate,
    AVG(metric_gaming_risk) AS metric_gaming_risk_rate,
    AVG(symbolic_alignment_risk) AS symbolic_alignment_risk_rate
FROM goal_system_scores
GROUP BY unit_id
ORDER BY avg_goal_system_risk DESC;

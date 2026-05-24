-- Incentives and Workplace Behavior
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, incentive-system review, reward-governance education,
-- fairness and metric-distortion analysis, ethical-risk review, cooperation and
-- culture review, and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline,
-- termination, workplace surveillance, individual performance-management,
-- productivity-ranking, incentive-compliance scoring, cultural-loyalty scoring,
-- or psychological assessment tool.

DROP TABLE IF EXISTS incentive_system_observations;

CREATE TABLE incentive_system_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    expectancy_strength REAL NOT NULL,
    fairness_perception REAL NOT NULL,
    strategic_alignment REAL NOT NULL,
    intrinsic_support REAL NOT NULL,
    feedback_clarity REAL NOT NULL,
    distortion_risk REAL NOT NULL,
    overload_pressure REAL NOT NULL,
    ethical_risk REAL NOT NULL,
    cooperation_support REAL NOT NULL,
    recognition_legitimacy REAL NOT NULL,
    reward_transparency REAL NOT NULL,
    hidden_labor_recognition REAL NOT NULL,
    performance_risk INTEGER NOT NULL,
    incentive_gaming_risk INTEGER NOT NULL,
    symbolic_reward_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS incentive_system_scores;

CREATE VIEW incentive_system_scores AS
SELECT
    unit_id,
    period,
    (
        0.12 * expectancy_strength +
        0.13 * fairness_perception +
        0.12 * strategic_alignment +
        0.10 * intrinsic_support +
        0.11 * feedback_clarity +
        0.10 * cooperation_support +
        0.10 * recognition_legitimacy +
        0.09 * reward_transparency +
        0.08 * hidden_labor_recognition -
        0.08 * distortion_risk -
        0.07 * overload_pressure -
        0.08 * ethical_risk
    ) AS incentive_effectiveness_score,
    (
        0.10 * (100 - expectancy_strength) +
        0.13 * (100 - fairness_perception) +
        0.11 * (100 - strategic_alignment) +
        0.09 * (100 - intrinsic_support) +
        0.10 * (100 - feedback_clarity) +
        0.09 * (100 - cooperation_support) +
        0.08 * (100 - recognition_legitimacy) +
        0.08 * (100 - reward_transparency) +
        0.07 * (100 - hidden_labor_recognition) +
        0.10 * distortion_risk +
        0.08 * overload_pressure +
        0.07 * ethical_risk
    ) AS incentive_system_risk_score,
    (
        0.25 * distortion_risk +
        0.22 * ethical_risk +
        0.18 * overload_pressure +
        0.14 * (100 - reward_transparency) +
        0.12 * (100 - fairness_perception) +
        0.09 * incentive_gaming_risk * 100
    ) AS reward_governance_risk_score,
    performance_risk,
    incentive_gaming_risk,
    symbolic_reward_risk
FROM incentive_system_observations;

-- Example query: synthetic incentive-system review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(incentive_effectiveness_score) AS avg_incentive_effectiveness,
    AVG(incentive_system_risk_score) AS avg_incentive_system_risk,
    AVG(reward_governance_risk_score) AS avg_reward_governance_risk,
    AVG(performance_risk) AS performance_risk_rate,
    AVG(incentive_gaming_risk) AS incentive_gaming_risk_rate,
    AVG(symbolic_reward_risk) AS symbolic_reward_risk_rate
FROM incentive_system_scores
GROUP BY unit_id
ORDER BY avg_incentive_system_risk DESC;

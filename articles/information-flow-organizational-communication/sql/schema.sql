-- Information Flow and Organizational Communication
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational communication review, knowledge-flow
-- governance, and reproducible workflows. It is not an employee-screening,
-- employment-selection, hiring, promotion, compensation, discipline,
-- termination, workplace surveillance, individual performance-management,
-- communication-surveillance, productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS information_flow_observations;

CREATE TABLE information_flow_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    signal_quality REAL NOT NULL,
    timeliness REAL NOT NULL,
    interpretive_clarity REAL NOT NULL,
    cross_functional_connectivity REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    distortion_risk REAL NOT NULL,
    overload_pressure REAL NOT NULL,
    hierarchy_delay REAL NOT NULL,
    external_signal_turbulence REAL NOT NULL,
    decision_error INTEGER NOT NULL,
    escalation_failure INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS information_flow_scores;

CREATE VIEW information_flow_scores AS
SELECT
    unit_id,
    period,
    (
        0.18 * signal_quality +
        0.15 * timeliness +
        0.15 * interpretive_clarity +
        0.14 * cross_functional_connectivity +
        0.13 * psychological_safety -
        0.10 * distortion_risk -
        0.08 * overload_pressure -
        0.10 * hierarchy_delay -
        0.05 * external_signal_turbulence
    ) AS information_flow_quality_score,
    (
        0.16 * (100 - signal_quality) +
        0.13 * (100 - timeliness) +
        0.12 * (100 - interpretive_clarity) +
        0.11 * (100 - cross_functional_connectivity) +
        0.12 * (100 - psychological_safety) +
        0.13 * distortion_risk +
        0.10 * overload_pressure +
        0.09 * hierarchy_delay +
        0.04 * external_signal_turbulence
    ) AS communication_risk_score,
    decision_error,
    escalation_failure
FROM information_flow_observations;

-- Example query: synthetic unit communication review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(information_flow_quality_score) AS avg_information_flow_quality,
    AVG(communication_risk_score) AS avg_communication_risk,
    AVG(decision_error) AS decision_error_rate,
    AVG(escalation_failure) AS escalation_failure_rate
FROM information_flow_scores
GROUP BY unit_id
ORDER BY avg_communication_risk DESC;

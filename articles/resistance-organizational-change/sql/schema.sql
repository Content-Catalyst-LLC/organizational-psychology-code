-- Resistance to Organizational Change
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational change governance, and reproducible
-- workflows. It is not an employee-screening, employment-selection, hiring,
-- promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, or psychological assessment tool.

DROP TABLE IF EXISTS change_resistance_observations;

CREATE TABLE change_resistance_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    perceived_loss REAL NOT NULL,
    uncertainty REAL NOT NULL,
    identity_threat REAL NOT NULL,
    routine_embeddedness REAL NOT NULL,
    power_displacement REAL NOT NULL,
    trust_in_leadership REAL NOT NULL,
    participation_quality REAL NOT NULL,
    implementation_clarity REAL NOT NULL,
    workload_strain REAL NOT NULL,
    failed_change_history INTEGER NOT NULL,
    constructive_adoption INTEGER NOT NULL,
    symbolic_compliance INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS change_resistance_scores;

CREATE VIEW change_resistance_scores AS
SELECT
    unit_id,
    period,
    (
        0.17 * perceived_loss +
        0.16 * uncertainty +
        0.13 * identity_threat +
        0.13 * routine_embeddedness +
        0.10 * power_displacement +
        0.10 * workload_strain +
        6.0 * failed_change_history -
        0.12 * trust_in_leadership -
        0.08 * participation_quality -
        0.09 * implementation_clarity
    ) AS resistance_intensity_score,
    (
        0.18 * perceived_loss +
        0.16 * uncertainty +
        0.12 * identity_threat +
        0.13 * routine_embeddedness +
        0.09 * power_displacement +
        0.10 * workload_strain +
        0.10 * (100 - trust_in_leadership) +
        0.06 * (100 - participation_quality) +
        0.06 * (100 - implementation_clarity) +
        4.0 * failed_change_history
    ) AS change_friction_risk_score,
    constructive_adoption,
    symbolic_compliance
FROM change_resistance_observations;

-- Example query: synthetic unit change-readiness review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(resistance_intensity_score) AS avg_resistance_intensity,
    AVG(change_friction_risk_score) AS avg_change_friction_risk,
    AVG(constructive_adoption) AS constructive_adoption_rate,
    AVG(symbolic_compliance) AS symbolic_compliance_rate
FROM change_resistance_scores
GROUP BY unit_id
ORDER BY avg_change_friction_risk DESC;

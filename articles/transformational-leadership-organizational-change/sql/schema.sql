-- Transformational Leadership and Organizational Change
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, transformational-leadership review, change-system
-- analysis, vision/trust/support/fatigue diagnostics, psychological-safety and
-- organizational-learning education, and reproducible workflows. It is not an
-- employee-screening, employment-selection, hiring, promotion, compensation,
-- discipline, termination, workplace surveillance, individual performance-
-- management, productivity-ranking, leadership-loyalty scoring, dissent tracking,
-- or psychological assessment tool.

DROP TABLE IF EXISTS transformational_leadership_observations;

CREATE TABLE transformational_leadership_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    vision_credibility REAL NOT NULL,
    motivational_alignment REAL NOT NULL,
    intellectual_stimulation REAL NOT NULL,
    developmental_support REAL NOT NULL,
    institutional_trust REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    change_communication REAL NOT NULL,
    implementation_support REAL NOT NULL,
    meaning_making_quality REAL NOT NULL,
    resistance_intensity REAL NOT NULL,
    ambiguity_pressure REAL NOT NULL,
    change_fatigue REAL NOT NULL,
    voice_suppression_risk INTEGER NOT NULL,
    adaptive_performance_risk INTEGER NOT NULL,
    style_misfit_risk INTEGER NOT NULL,
    purpose_exploitation_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS transformational_leadership_scores;

CREATE VIEW transformational_leadership_scores AS
SELECT
    unit_id,
    period,
    (
        0.12 * vision_credibility +
        0.11 * motivational_alignment +
        0.11 * intellectual_stimulation +
        0.10 * developmental_support +
        0.12 * institutional_trust +
        0.11 * psychological_safety +
        0.10 * change_communication +
        0.09 * implementation_support +
        0.10 * meaning_making_quality -
        0.08 * resistance_intensity -
        0.07 * ambiguity_pressure -
        0.08 * change_fatigue
    ) AS transformational_capacity_score,
    (
        0.11 * (100 - vision_credibility) +
        0.10 * (100 - motivational_alignment) +
        0.09 * (100 - intellectual_stimulation) +
        0.09 * (100 - developmental_support) +
        0.12 * (100 - institutional_trust) +
        0.11 * (100 - psychological_safety) +
        0.09 * (100 - change_communication) +
        0.09 * (100 - implementation_support) +
        0.09 * (100 - meaning_making_quality) +
        0.10 * resistance_intensity +
        0.10 * ambiguity_pressure +
        0.12 * change_fatigue
    ) AS transformational_system_risk_score,
    (
        0.22 * change_fatigue +
        0.18 * ambiguity_pressure +
        0.16 * resistance_intensity +
        0.14 * (100 - institutional_trust) +
        0.12 * (100 - psychological_safety) +
        0.08 * voice_suppression_risk * 100 +
        0.05 * purpose_exploitation_risk * 100 +
        0.05 * style_misfit_risk * 100
    ) AS fatigue_voice_purpose_risk_score,
    adaptive_performance_risk,
    voice_suppression_risk,
    style_misfit_risk,
    purpose_exploitation_risk
FROM transformational_leadership_observations;

-- Example query: synthetic transformational-leadership review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(transformational_capacity_score) AS avg_transformational_capacity,
    AVG(transformational_system_risk_score) AS avg_transformational_system_risk,
    AVG(fatigue_voice_purpose_risk_score) AS avg_fatigue_voice_purpose_risk,
    AVG(adaptive_performance_risk) AS adaptive_performance_risk_rate,
    AVG(voice_suppression_risk) AS voice_suppression_risk_rate,
    AVG(purpose_exploitation_risk) AS purpose_exploitation_risk_rate
FROM transformational_leadership_scores
GROUP BY unit_id
ORDER BY avg_transformational_system_risk DESC;

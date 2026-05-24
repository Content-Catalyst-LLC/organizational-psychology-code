-- Leadership Styles and Organizational Performance
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, leadership-system review, communication/trust/style-fit
-- analysis, psychological-safety and work-design education, and reproducible
-- workflows. It is not an employee-screening, employment-selection, hiring,
-- promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, productivity-ranking, leadership-loyalty
-- scoring, dissent tracking, or psychological assessment tool.

DROP TABLE IF EXISTS leadership_style_observations;

CREATE TABLE leadership_style_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    participative_behavior REAL NOT NULL,
    structural_guidance REAL NOT NULL,
    communication_quality REAL NOT NULL,
    trust_generation REAL NOT NULL,
    developmental_support REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    decision_fit REAL NOT NULL,
    cultural_alignment REAL NOT NULL,
    control_pressure REAL NOT NULL,
    ambiguity_risk REAL NOT NULL,
    disengagement_pressure REAL NOT NULL,
    voice_suppression_risk INTEGER NOT NULL,
    performance_risk INTEGER NOT NULL,
    style_misfit_risk INTEGER NOT NULL,
    authoritarian_overuse_risk INTEGER NOT NULL,
    laissez_faire_absence_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS leadership_style_scores;

CREATE VIEW leadership_style_scores AS
SELECT
    unit_id,
    period,
    (
        0.11 * participative_behavior +
        0.12 * structural_guidance +
        0.13 * communication_quality +
        0.13 * trust_generation +
        0.11 * developmental_support +
        0.12 * psychological_safety +
        0.11 * decision_fit +
        0.10 * cultural_alignment -
        0.08 * control_pressure -
        0.07 * ambiguity_risk -
        0.07 * disengagement_pressure
    ) AS leadership_effectiveness_score,
    (
        0.09 * (100 - participative_behavior) +
        0.10 * (100 - structural_guidance) +
        0.12 * (100 - communication_quality) +
        0.13 * (100 - trust_generation) +
        0.09 * (100 - developmental_support) +
        0.12 * (100 - psychological_safety) +
        0.10 * (100 - decision_fit) +
        0.08 * (100 - cultural_alignment) +
        0.11 * control_pressure +
        0.10 * ambiguity_risk +
        0.10 * disengagement_pressure
    ) AS leadership_system_risk_score,
    (
        0.20 * control_pressure +
        0.18 * ambiguity_risk +
        0.18 * disengagement_pressure +
        0.14 * (100 - psychological_safety) +
        0.12 * (100 - decision_fit) +
        0.08 * voice_suppression_risk * 100 +
        0.05 * authoritarian_overuse_risk * 100 +
        0.05 * laissez_faire_absence_risk * 100
    ) AS voice_and_style_misfit_risk_score,
    performance_risk,
    voice_suppression_risk,
    style_misfit_risk,
    authoritarian_overuse_risk,
    laissez_faire_absence_risk
FROM leadership_style_observations;

-- Example query: synthetic leadership-system review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(leadership_effectiveness_score) AS avg_leadership_effectiveness,
    AVG(leadership_system_risk_score) AS avg_leadership_system_risk,
    AVG(voice_and_style_misfit_risk_score) AS avg_voice_and_style_misfit_risk,
    AVG(performance_risk) AS performance_risk_rate,
    AVG(voice_suppression_risk) AS voice_suppression_risk_rate,
    AVG(style_misfit_risk) AS style_misfit_risk_rate
FROM leadership_style_scores
GROUP BY unit_id
ORDER BY avg_leadership_system_risk DESC;

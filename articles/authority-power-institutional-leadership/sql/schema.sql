-- Authority and Power in Institutional Leadership
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, authority/governance-system review, legitimacy and
-- procedural-fairness analysis, informal-power and information-flow review,
-- ethical-leadership education, and reproducible workflows. It is not an
-- employee-screening, employment-selection, hiring, promotion, compensation,
-- discipline, termination, workplace surveillance, individual performance-
-- management, productivity-ranking, loyalty scoring, political-influence
-- scoring, dissent tracking, or psychological assessment tool.

DROP TABLE IF EXISTS authority_governance_observations;

CREATE TABLE authority_governance_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    formal_legitimacy REAL NOT NULL,
    procedural_fairness REAL NOT NULL,
    informational_access REAL NOT NULL,
    practical_influence REAL NOT NULL,
    ethical_credibility REAL NOT NULL,
    accountability_quality REAL NOT NULL,
    voice_access REAL NOT NULL,
    oversight_strength REAL NOT NULL,
    arbitrariness_risk REAL NOT NULL,
    governance_fragmentation REAL NOT NULL,
    distrust_pressure REAL NOT NULL,
    informal_power_concentration REAL NOT NULL,
    governance_risk INTEGER NOT NULL,
    shadow_governance_risk INTEGER NOT NULL,
    legitimacy_decay_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS authority_governance_scores;

CREATE VIEW authority_governance_scores AS
SELECT
    unit_id,
    period,
    (
        0.12 * formal_legitimacy +
        0.12 * procedural_fairness +
        0.10 * informational_access +
        0.10 * practical_influence +
        0.12 * ethical_credibility +
        0.11 * accountability_quality +
        0.10 * voice_access +
        0.09 * oversight_strength -
        0.08 * arbitrariness_risk -
        0.07 * governance_fragmentation -
        0.07 * distrust_pressure -
        0.05 * informal_power_concentration
    ) AS authority_effectiveness_score,
    (
        0.11 * (100 - formal_legitimacy) +
        0.12 * (100 - procedural_fairness) +
        0.08 * (100 - informational_access) +
        0.08 * (100 - practical_influence) +
        0.12 * (100 - ethical_credibility) +
        0.11 * (100 - accountability_quality) +
        0.09 * (100 - voice_access) +
        0.08 * (100 - oversight_strength) +
        0.10 * arbitrariness_risk +
        0.09 * governance_fragmentation +
        0.09 * distrust_pressure +
        0.08 * informal_power_concentration
    ) AS governance_risk_score,
    (
        0.26 * informal_power_concentration +
        0.22 * governance_fragmentation +
        0.18 * arbitrariness_risk +
        0.14 * (100 - accountability_quality) +
        0.10 * (100 - oversight_strength) +
        0.10 * shadow_governance_risk * 100
    ) AS shadow_governance_risk_score,
    governance_risk,
    shadow_governance_risk,
    legitimacy_decay_risk
FROM authority_governance_observations;

-- Example query: synthetic authority/governance review summary.
SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(authority_effectiveness_score) AS avg_authority_effectiveness,
    AVG(governance_risk_score) AS avg_governance_risk,
    AVG(shadow_governance_risk_score) AS avg_shadow_governance_risk,
    AVG(governance_risk) AS governance_risk_rate,
    AVG(shadow_governance_risk) AS shadow_governance_risk_rate,
    AVG(legitimacy_decay_risk) AS legitimacy_decay_risk_rate
FROM authority_governance_scores
GROUP BY unit_id
ORDER BY avg_governance_risk DESC;

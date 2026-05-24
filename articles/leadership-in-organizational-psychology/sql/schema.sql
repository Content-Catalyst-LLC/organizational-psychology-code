-- Leadership in Organizational Psychology
-- Synthetic SQL schema and example queries.
-- Responsible-use scope: synthetic-data research and institutional learning only.
-- Not for employment decisions, surveillance, productivity ranking, loyalty
-- scoring, political-influence scoring, dissent tracking, or psychological assessment.

DROP TABLE IF EXISTS leadership_capacity_observations;

CREATE TABLE leadership_capacity_observations (
    unit_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    trust_generation REAL NOT NULL,
    communication_clarity REAL NOT NULL,
    motivational_support REAL NOT NULL,
    legitimacy_quality REAL NOT NULL,
    adaptive_coordination REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    role_clarity REAL NOT NULL,
    ethical_accountability REAL NOT NULL,
    decision_transparency REAL NOT NULL,
    voice_access REAL NOT NULL,
    ambiguity_pressure REAL NOT NULL,
    distrust_pressure REAL NOT NULL,
    fragmentation_pressure REAL NOT NULL,
    overload_pressure REAL NOT NULL,
    voice_suppression_risk INTEGER NOT NULL,
    performance_risk INTEGER NOT NULL,
    legitimacy_decay_risk INTEGER NOT NULL,
    fragmentation_risk INTEGER NOT NULL,
    PRIMARY KEY (unit_id, period)
);

DROP VIEW IF EXISTS leadership_capacity_scores;

CREATE VIEW leadership_capacity_scores AS
SELECT
    unit_id,
    period,
    (
        0.11 * trust_generation +
        0.11 * communication_clarity +
        0.10 * motivational_support +
        0.11 * legitimacy_quality +
        0.10 * adaptive_coordination +
        0.10 * psychological_safety +
        0.08 * role_clarity +
        0.09 * ethical_accountability +
        0.08 * decision_transparency +
        0.08 * voice_access -
        0.07 * ambiguity_pressure -
        0.08 * distrust_pressure -
        0.07 * fragmentation_pressure -
        0.06 * overload_pressure
    ) AS leadership_capacity_score,
    (
        0.10 * (100 - trust_generation) +
        0.09 * (100 - communication_clarity) +
        0.08 * (100 - motivational_support) +
        0.11 * (100 - legitimacy_quality) +
        0.08 * (100 - adaptive_coordination) +
        0.10 * (100 - psychological_safety) +
        0.07 * (100 - role_clarity) +
        0.09 * (100 - ethical_accountability) +
        0.07 * (100 - decision_transparency) +
        0.08 * (100 - voice_access) +
        0.08 * ambiguity_pressure +
        0.10 * distrust_pressure +
        0.09 * fragmentation_pressure +
        0.08 * overload_pressure
    ) AS leadership_system_risk_score,
    performance_risk,
    voice_suppression_risk,
    legitimacy_decay_risk,
    fragmentation_risk
FROM leadership_capacity_observations;

SELECT
    unit_id,
    COUNT(*) AS observations,
    AVG(leadership_capacity_score) AS avg_leadership_capacity,
    AVG(leadership_system_risk_score) AS avg_leadership_system_risk,
    AVG(performance_risk) AS performance_risk_rate,
    AVG(voice_suppression_risk) AS voice_suppression_risk_rate,
    AVG(legitimacy_decay_risk) AS legitimacy_decay_risk_rate,
    AVG(fragmentation_risk) AS fragmentation_risk_rate
FROM leadership_capacity_scores
GROUP BY unit_id
ORDER BY avg_leadership_system_risk DESC;

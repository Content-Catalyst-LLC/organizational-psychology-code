-- Conflict Resolution in Organizational Systems
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, conflict-system review, mediation-process education,
-- procedural fairness analysis, leadership and dispute-system analysis, and
-- reproducible workflows. It is not an employee-screening, employment-selection,
-- hiring, promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, cultural-loyalty scoring, conflict-proneness
-- scoring, collaboration scoring of workers, productivity-ranking, or psychological
-- assessment tool.

DROP TABLE IF EXISTS conflict_resolution_observations;

CREATE TABLE conflict_resolution_observations (
    team_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    trust_level REAL NOT NULL,
    communication_clarity REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    procedural_fairness REAL NOT NULL,
    integrative_skill REAL NOT NULL,
    blame_intensity REAL NOT NULL,
    power_asymmetry REAL NOT NULL,
    resource_strain REAL NOT NULL,
    mediation_access REAL NOT NULL,
    collaborative_resolution INTEGER NOT NULL,
    symbolic_resolution_risk INTEGER NOT NULL,
    PRIMARY KEY (team_id, period)
);

DROP VIEW IF EXISTS conflict_resolution_scores;

CREATE VIEW conflict_resolution_scores AS
SELECT
    team_id,
    period,
    (
        0.16 * trust_level +
        0.15 * communication_clarity +
        0.14 * psychological_safety +
        0.15 * procedural_fairness +
        0.12 * integrative_skill +
        0.10 * mediation_access -
        0.10 * blame_intensity -
        0.09 * power_asymmetry -
        0.07 * resource_strain
    ) AS constructive_conflict_capacity_score,
    (
        0.13 * (100 - trust_level) +
        0.12 * (100 - communication_clarity) +
        0.11 * (100 - psychological_safety) +
        0.13 * (100 - procedural_fairness) +
        0.10 * (100 - integrative_skill) +
        0.10 * (100 - mediation_access) +
        0.14 * blame_intensity +
        0.13 * power_asymmetry +
        0.14 * resource_strain
    ) AS conflict_risk_score,
    (
        0.28 * blame_intensity +
        0.25 * power_asymmetry +
        0.22 * resource_strain +
        0.15 * (100 - communication_clarity) +
        0.10 * (100 - procedural_fairness)
    ) AS escalation_pressure_score,
    collaborative_resolution,
    symbolic_resolution_risk
FROM conflict_resolution_observations;

-- Example query: synthetic team conflict-system review summary.
SELECT
    team_id,
    COUNT(*) AS observations,
    AVG(constructive_conflict_capacity_score) AS avg_constructive_conflict_capacity,
    AVG(conflict_risk_score) AS avg_conflict_risk,
    AVG(escalation_pressure_score) AS avg_escalation_pressure,
    AVG(collaborative_resolution) AS collaborative_resolution_rate,
    AVG(symbolic_resolution_risk) AS symbolic_resolution_risk_rate
FROM conflict_resolution_scores
GROUP BY team_id
ORDER BY avg_conflict_risk DESC;

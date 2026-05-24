-- Team Dynamics in Organizations
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, team-system review, collaboration-system education,
-- communication and coordination analysis, leadership and team-design review,
-- and reproducible workflows. It is not an employee-screening, employment-selection,
-- hiring, promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, cultural-loyalty scoring, team-fit scoring,
-- collaboration scoring of workers, productivity-ranking, or psychological
-- assessment tool.

DROP TABLE IF EXISTS team_dynamics_observations;

CREATE TABLE team_dynamics_observations (
    team_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    communication_quality REAL NOT NULL,
    trust_level REAL NOT NULL,
    role_clarity REAL NOT NULL,
    psychological_safety REAL NOT NULL,
    leadership_support REAL NOT NULL,
    conflict_load REAL NOT NULL,
    task_ambiguity REAL NOT NULL,
    coordination_cost REAL NOT NULL,
    participation_equity REAL NOT NULL,
    learning_routine_quality REAL NOT NULL,
    strong_collective_performance INTEGER NOT NULL,
    symbolic_teamwork_risk INTEGER NOT NULL,
    PRIMARY KEY (team_id, period)
);

DROP VIEW IF EXISTS team_dynamics_scores;

CREATE VIEW team_dynamics_scores AS
SELECT
    team_id,
    period,
    (
        0.14 * communication_quality +
        0.12 * trust_level +
        0.12 * role_clarity +
        0.13 * psychological_safety +
        0.12 * leadership_support +
        0.11 * participation_equity +
        0.11 * learning_routine_quality -
        0.09 * conflict_load -
        0.08 * task_ambiguity -
        0.09 * coordination_cost
    ) AS team_effectiveness_score,
    (
        0.11 * (100 - communication_quality) +
        0.10 * (100 - trust_level) +
        0.11 * (100 - role_clarity) +
        0.12 * (100 - psychological_safety) +
        0.10 * (100 - leadership_support) +
        0.10 * (100 - participation_equity) +
        0.10 * (100 - learning_routine_quality) +
        0.12 * conflict_load +
        0.12 * task_ambiguity +
        0.12 * coordination_cost
    ) AS team_system_risk_score,
    (
        0.30 * coordination_cost +
        0.25 * task_ambiguity +
        0.20 * conflict_load +
        0.15 * (100 - role_clarity) +
        0.10 * (100 - communication_quality)
    ) AS coordination_breakdown_score,
    strong_collective_performance,
    symbolic_teamwork_risk
FROM team_dynamics_observations;

-- Example query: synthetic team-dynamics review summary.
SELECT
    team_id,
    COUNT(*) AS observations,
    AVG(team_effectiveness_score) AS avg_team_effectiveness,
    AVG(team_system_risk_score) AS avg_team_system_risk,
    AVG(coordination_breakdown_score) AS avg_coordination_breakdown,
    AVG(strong_collective_performance) AS strong_collective_performance_rate,
    AVG(symbolic_teamwork_risk) AS symbolic_teamwork_risk_rate
FROM team_dynamics_scores
GROUP BY team_id
ORDER BY avg_team_system_risk DESC;

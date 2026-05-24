-- Psychological Safety in High-Performing Teams
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, team-learning review, psychological safety education,
-- leadership and voice-system analysis, and reproducible workflows. It is not
-- an employee-screening, employment-selection, hiring, promotion, compensation,
-- discipline, termination, workplace surveillance, individual performance-
-- management, cultural-loyalty scoring, courage scoring, voice scoring of
-- workers, productivity-ranking, or psychological assessment tool.

DROP TABLE IF EXISTS psychological_safety_observations;

CREATE TABLE psychological_safety_observations (
    team_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    leadership_openness REAL NOT NULL,
    inclusion_quality REAL NOT NULL,
    learning_review_quality REAL NOT NULL,
    knowledge_sharing REAL NOT NULL,
    blame_intensity REAL NOT NULL,
    status_asymmetry REAL NOT NULL,
    perceived_penalty REAL NOT NULL,
    workload_pressure REAL NOT NULL,
    strong_team_performance INTEGER NOT NULL,
    symbolic_voice_risk INTEGER NOT NULL,
    PRIMARY KEY (team_id, period)
);

DROP VIEW IF EXISTS psychological_safety_scores;

CREATE VIEW psychological_safety_scores AS
SELECT
    team_id,
    period,
    (
        0.18 * leadership_openness +
        0.16 * inclusion_quality +
        0.15 * learning_review_quality +
        0.14 * knowledge_sharing -
        0.13 * blame_intensity -
        0.11 * status_asymmetry -
        0.10 * perceived_penalty -
        0.06 * workload_pressure
    ) AS psychological_safety_score,
    (
        0.15 * (100 - leadership_openness) +
        0.13 * (100 - inclusion_quality) +
        0.12 * (100 - learning_review_quality) +
        0.12 * (100 - knowledge_sharing) +
        0.14 * blame_intensity +
        0.12 * status_asymmetry +
        0.14 * perceived_penalty +
        0.08 * workload_pressure
    ) AS safety_risk_score,
    strong_team_performance,
    symbolic_voice_risk
FROM psychological_safety_observations;

-- Example query: synthetic team safety review summary.
SELECT
    team_id,
    COUNT(*) AS observations,
    AVG(psychological_safety_score) AS avg_psychological_safety,
    AVG(safety_risk_score) AS avg_safety_risk,
    AVG(strong_team_performance) AS strong_team_performance_rate,
    AVG(symbolic_voice_risk) AS symbolic_voice_risk_rate
FROM psychological_safety_scores
GROUP BY team_id
ORDER BY avg_safety_risk DESC;

-- Trust and Cooperation in Workplace Teams
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, trust-and-cooperation review, collaboration-system
-- education, reciprocity analysis, leadership and governance review, and
-- reproducible workflows. It is not an employee-screening, employment-selection,
-- hiring, promotion, compensation, discipline, termination, workplace surveillance,
-- individual performance-management, cultural-loyalty scoring, trustworthiness
-- scoring, cooperation scoring of workers, productivity-ranking, or psychological
-- assessment tool.

DROP TABLE IF EXISTS trust_cooperation_observations;

CREATE TABLE trust_cooperation_observations (
    team_id TEXT NOT NULL,
    period INTEGER NOT NULL,
    competence_trust REAL NOT NULL,
    integrity_trust REAL NOT NULL,
    benevolence_trust REAL NOT NULL,
    reciprocity_norms REAL NOT NULL,
    communication_reliability REAL NOT NULL,
    opportunism_risk REAL NOT NULL,
    power_imbalance REAL NOT NULL,
    uncertainty_load REAL NOT NULL,
    leadership_credibility REAL NOT NULL,
    institutional_trust REAL NOT NULL,
    strong_collaboration INTEGER NOT NULL,
    symbolic_cooperation_risk INTEGER NOT NULL,
    PRIMARY KEY (team_id, period)
);

DROP VIEW IF EXISTS trust_cooperation_scores;

CREATE VIEW trust_cooperation_scores AS
SELECT
    team_id,
    period,
    (
        0.13 * competence_trust +
        0.14 * integrity_trust +
        0.12 * benevolence_trust +
        0.13 * reciprocity_norms +
        0.12 * communication_reliability +
        0.11 * leadership_credibility +
        0.11 * institutional_trust -
        0.10 * opportunism_risk -
        0.08 * power_imbalance -
        0.05 * uncertainty_load
    ) AS cooperative_capacity_score,
    (
        0.10 * (100 - competence_trust) +
        0.14 * (100 - integrity_trust) +
        0.10 * (100 - benevolence_trust) +
        0.12 * (100 - reciprocity_norms) +
        0.10 * (100 - communication_reliability) +
        0.10 * (100 - leadership_credibility) +
        0.12 * (100 - institutional_trust) +
        0.14 * opportunism_risk +
        0.10 * power_imbalance +
        0.08 * uncertainty_load
    ) AS trust_risk_score,
    (
        0.35 * (100 - reciprocity_norms) +
        0.25 * power_imbalance +
        0.20 * opportunism_risk +
        0.20 * (100 - institutional_trust)
    ) AS reciprocity_gap_score,
    strong_collaboration,
    symbolic_cooperation_risk
FROM trust_cooperation_observations;

-- Example query: synthetic team trust-and-cooperation review summary.
SELECT
    team_id,
    COUNT(*) AS observations,
    AVG(cooperative_capacity_score) AS avg_cooperative_capacity,
    AVG(trust_risk_score) AS avg_trust_risk,
    AVG(reciprocity_gap_score) AS avg_reciprocity_gap,
    AVG(strong_collaboration) AS strong_collaboration_rate,
    AVG(symbolic_cooperation_risk) AS symbolic_cooperation_risk_rate
FROM trust_cooperation_scores
GROUP BY team_id
ORDER BY avg_trust_risk DESC;

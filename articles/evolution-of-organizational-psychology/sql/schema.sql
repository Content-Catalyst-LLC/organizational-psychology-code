-- The Evolution of Organizational Psychology
-- Synthetic SQL schema and example queries.
--
-- Responsible-use scope:
-- This schema is for synthetic-data research, methods demonstration,
-- institutional learning, organizational psychology education, history-of-field
-- analysis, research-emphasis mapping, and reproducible workflows. It is not an
-- employee-screening, employment-selection, hiring, promotion, compensation,
-- discipline, termination, workplace surveillance, individual performance-
-- management, productivity-ranking, loyalty-scoring, dissent tracking,
-- psychological assessment, scholar-ranking, department-ranking, or journal-
-- ranking tool.

DROP TABLE IF EXISTS organizational_psychology_evolution;

CREATE TABLE organizational_psychology_evolution (
    period TEXT PRIMARY KEY,
    selection_testing REAL NOT NULL,
    efficiency_work_design REAL NOT NULL,
    motivation_attitudes REAL NOT NULL,
    groups_teams REAL NOT NULL,
    culture_leadership_change REAL NOT NULL,
    wellbeing_stress REAL NOT NULL,
    justice_validity_ethics REAL NOT NULL,
    digital_analytics REAL NOT NULL,
    systems_institutional_accountability REAL NOT NULL
);

DROP VIEW IF EXISTS field_orientation_scores;

CREATE VIEW field_orientation_scores AS
SELECT
    period,
    (
        0.46 * selection_testing +
        0.40 * efficiency_work_design +
        0.14 * motivation_attitudes
    ) AS industrial_orientation,
    (
        0.16 * motivation_attitudes +
        0.16 * groups_teams +
        0.20 * culture_leadership_change +
        0.14 * wellbeing_stress +
        0.14 * justice_validity_ethics +
        0.10 * digital_analytics +
        0.10 * systems_institutional_accountability
    ) AS organizational_orientation,
    (
        0.16 * groups_teams +
        0.20 * culture_leadership_change +
        0.18 * wellbeing_stress +
        0.20 * justice_validity_ethics +
        0.12 * digital_analytics +
        0.14 * systems_institutional_accountability
    ) AS systems_ethics_orientation,
    (
        0.18 * selection_testing +
        0.08 * efficiency_work_design +
        0.12 * motivation_attitudes +
        0.12 * groups_teams +
        0.14 * culture_leadership_change +
        0.15 * wellbeing_stress +
        0.17 * justice_validity_ethics +
        0.08 * digital_analytics +
        0.06 * systems_institutional_accountability
    ) AS responsible_progress_index
FROM organizational_psychology_evolution;

-- Example query: compare field orientation by period.
SELECT
    period,
    industrial_orientation,
    organizational_orientation,
    systems_ethics_orientation,
    responsible_progress_index,
    organizational_orientation - industrial_orientation AS field_expansion_index
FROM field_orientation_scores
ORDER BY period;

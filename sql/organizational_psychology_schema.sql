-- Root schema for organizational psychology, employee survey, communication,
-- decision-system, and resilience data.

CREATE TABLE IF NOT EXISTS employees (
    employee_id TEXT PRIMARY KEY,
    team_id TEXT,
    department_id TEXT,
    role_level TEXT,
    tenure_months REAL,
    work_mode TEXT,
    notes TEXT
);

CREATE TABLE IF NOT EXISTS teams (
    team_id TEXT PRIMARY KEY,
    department_id TEXT,
    team_name TEXT,
    function_label TEXT
);

CREATE TABLE IF NOT EXISTS organizational_observations (
    observation_id INTEGER PRIMARY KEY,
    employee_id TEXT NOT NULL,
    team_id TEXT,
    wave INTEGER NOT NULL,
    motivation REAL,
    role_clarity REAL,
    leadership_trust REAL,
    psychological_safety REAL,
    perceived_fairness REAL,
    workload_pressure REAL,
    burnout_risk REAL,
    commitment REAL,
    job_satisfaction REAL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS communication_edges (
    edge_id INTEGER PRIMARY KEY,
    source_employee_id TEXT NOT NULL,
    target_employee_id TEXT NOT NULL,
    interaction_weight REAL,
    channel TEXT,
    week_index INTEGER
);

CREATE TABLE IF NOT EXISTS decision_records (
    decision_id TEXT PRIMARY KEY,
    team_id TEXT,
    decision_quality REAL,
    information_flow REAL,
    cognitive_diversity REAL,
    bias_control REAL,
    time_pressure REAL,
    siloing REAL,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

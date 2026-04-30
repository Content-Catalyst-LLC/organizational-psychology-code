-- Article-level synthetic organizational psychology schema.

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
    job_satisfaction REAL
);

CREATE TABLE IF NOT EXISTS communication_edges (
    edge_id INTEGER PRIMARY KEY,
    source_employee_id TEXT NOT NULL,
    target_employee_id TEXT NOT NULL,
    interaction_weight REAL,
    channel TEXT,
    week_index INTEGER
);

CREATE INDEX IF NOT EXISTS idx_org_obs_employee
ON organizational_observations(employee_id);

CREATE INDEX IF NOT EXISTS idx_org_obs_team
ON organizational_observations(team_id);

CREATE INDEX IF NOT EXISTS idx_comm_edges_source
ON communication_edges(source_employee_id);

CREATE INDEX IF NOT EXISTS idx_comm_edges_target
ON communication_edges(target_employee_id);

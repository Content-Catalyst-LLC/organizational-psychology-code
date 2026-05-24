# Data Dictionary

## `data/raw/goal_system_synthetic.csv`

This synthetic dataset describes organizational units across repeated goal-system review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `goal_clarity` | Degree to which goals are specific, understandable, and behaviorally actionable | 0–100 |
| `goal_challenge` | Degree to which goals are ambitious enough to stimulate effort while remaining credible | 0–100 |
| `feedback_quality` | Timeliness, specificity, fairness, and developmental usefulness of performance feedback | 0–100 |
| `employee_commitment` | Degree to which employees experience goals as meaningful, legitimate, and worth pursuing | 0–100 |
| `strategic_alignment` | Degree to which goals connect to broader institutional strategy and purpose | 0–100 |
| `overload_pressure` | Degree to which goals create unrealistic workload, burnout risk, or target pressure | 0–100 |
| `metric_distortion` | Degree to which metrics encourage behavior that departs from underlying value | 0–100 |
| `incentive_misalignment` | Degree to which incentives reward behavior that conflicts with broader organizational purpose | 0–100 |
| `review_quality` | Quality of recalibration, learning review, dashboard interpretation, and goal governance | 0–100 |
| `proxy_drift` | Degree to which measurement has diverged from the value it was intended to represent | 0–100 |
| `goal_feasibility` | Degree to which goals are realistically attainable given authority, capacity, resources, and constraints | 0–100 |
| `performance_risk` | Synthetic binary indicator of elevated performance-system risk | 0/1 |
| `metric_gaming_risk` | Synthetic binary indicator of elevated gaming or metric-optimization risk | 0/1 |
| `symbolic_alignment_risk` | Synthetic binary indicator of strategy-alignment language without credible goal-system conditions | 0/1 |

## Interpretation

Variables are unit-level, goal-system-level, and institutional indicators. They should not be interpreted as measures of individual productivity, effort, loyalty, goal compliance, employability, morality, psychological status, or worth.

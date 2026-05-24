# Data Dictionary

## `data/raw/conflict_resolution_synthetic.csv`

This synthetic dataset describes teams across repeated conflict-system review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `team_id` | Synthetic team identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `trust_level` | Degree of relational trust among parties or team members | 0–100 |
| `communication_clarity` | Degree to which parties understand issues, expectations, evidence, and meanings accurately | 0–100 |
| `psychological_safety` | Ability to surface disagreement, concern, and uncertainty without disproportionate penalty | 0–100 |
| `procedural_fairness` | Perceived legitimacy, transparency, consistency, and fairness of conflict processes | 0–100 |
| `integrative_skill` | Capacity to identify underlying interests and generate workable non-zero-sum options | 0–100 |
| `blame_intensity` | Degree to which conflict triggers defensiveness, accusation, shame, punishment, or escalation | 0–100 |
| `power_asymmetry` | Degree to which hierarchy, status, resources, or credibility differences constrain voice | 0–100 |
| `resource_strain` | Resource scarcity, workload pressure, staffing constraint, or structural competition intensifying conflict | 0–100 |
| `mediation_access` | Availability and credibility of neutral facilitation, ombuds support, mediation, or escalation pathways | 0–100 |
| `collaborative_resolution` | Synthetic binary indicator of constructive or collaborative resolution | 0/1 |
| `symbolic_resolution_risk` | Synthetic binary indicator of formal resolution language without credible fairness or repair | 0/1 |

## Interpretation

Variables are team-level, system-level, and institutional indicators. They should not be interpreted as measures of individual conflict-proneness, loyalty, personality, cooperativeness, morality, cultural fit, psychological status, or employability.

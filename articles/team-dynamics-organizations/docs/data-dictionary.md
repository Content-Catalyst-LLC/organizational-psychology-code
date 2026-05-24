# Data Dictionary

## `data/raw/team_dynamics_synthetic.csv`

This synthetic dataset describes teams across repeated team-dynamics review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `team_id` | Synthetic team identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `communication_quality` | Clarity, timeliness, reliability, and usefulness of team communication | 0–100 |
| `trust_level` | Confidence that members act competently, reliably, fairly, and in good faith | 0–100 |
| `role_clarity` | Clarity of responsibilities, ownership, handoffs, and decision rights | 0–100 |
| `psychological_safety` | Ability to ask questions, report errors, dissent, and surface uncertainty without disproportionate penalty | 0–100 |
| `leadership_support` | Degree to which formal or informal leadership supports direction, coordination, voice, and learning | 0–100 |
| `conflict_load` | Intensity of destructive conflict, unresolved disagreement, interpersonal friction, or recurring tension | 0–100 |
| `task_ambiguity` | Ambiguity in task definition, expectations, authority, priorities, or evidence | 0–100 |
| `coordination_cost` | Effort required to align work across dependencies, roles, systems, or boundaries | 0–100 |
| `participation_equity` | Degree to which members participate meaningfully across status, role, identity, and expertise differences | 0–100 |
| `learning_routine_quality` | Quality of retrospectives, postmortems, after-action reviews, feedback loops, and practice revision | 0–100 |
| `strong_collective_performance` | Synthetic binary indicator of strong team-level performance | 0/1 |
| `symbolic_teamwork_risk` | Synthetic binary indicator of teamwork language without credible conditions for collaboration | 0/1 |

## Interpretation

Variables are team-level, system-level, and institutional indicators. They should not be interpreted as measures of individual collaboration, loyalty, team fit, personality, morality, productivity, psychological status, or employability.

# Data Dictionary

## `data/raw/change_resistance_synthetic.csv`

This synthetic dataset describes organizational units across repeated periods during a change initiative. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `perceived_loss` | Expected loss of autonomy, status, expertise, clarity, reward, or security | 0–100 |
| `uncertainty` | Ambiguity about roles, timing, expectations, outcomes, or implementation | 0–100 |
| `identity_threat` | Perceived threat to professional identity, role meaning, or institutional self-understanding | 0–100 |
| `routine_embeddedness` | Depth of existing routines, workflows, technologies, and tacit dependencies | 0–100 |
| `power_displacement` | Perceived redistribution of authority, resources, status, or decision rights | 0–100 |
| `trust_in_leadership` | Credibility of leadership intent, competence, and accountability | 0–100 |
| `participation_quality` | Meaningful voice and influence in change design and implementation | 0–100 |
| `implementation_clarity` | Clarity of rationale, sequencing, roles, supports, and transition expectations | 0–100 |
| `workload_strain` | Additional pressure created by change on top of existing work demands | 0–100 |
| `failed_change_history` | Synthetic indicator of whether the unit has recent experience of failed or harmful change | 0/1 |
| `constructive_adoption` | Synthetic binary indicator of meaningful adoption | 0/1 |
| `symbolic_compliance` | Synthetic binary indicator of apparent compliance without deeper adoption | 0/1 |

## Interpretation

Variables are institutional, team-process, and change-system indicators. They should not be interpreted as measures of individual loyalty, attitude, personality, resistance, adaptability, or performance.

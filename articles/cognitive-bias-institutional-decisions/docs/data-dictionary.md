# Data Dictionary

## `data/raw/bias_pressure_synthetic.csv`

This synthetic dataset describes organizational units across repeated decision-review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `signal_quality` | Relevance, credibility, completeness, and usefulness of available evidence | 0–100 |
| `viewpoint_diversity` | Breadth of perspectives and interpretive variation entering decision review | 0–100 |
| `analytical_discipline` | Use of base rates, reference classes, sensitivity analysis, and explicit assumptions | 0–100 |
| `structured_challenge` | Formal and protected mechanisms for dissent, red-team review, premortems, or independent challenge | 0–100 |
| `hierarchy_suppression` | Degree to which authority, status, or fear suppresses disconfirming evidence | 0–100 |
| `time_pressure` | Degree to which urgency compresses search, interpretation, and deliberation | 0–100 |
| `routine_reinforcement` | Degree to which established routines reinforce prior assumptions | 0–100 |
| `learning_review` | Strength of post-decision review, postmortem learning, assumption tracking, and correction | 0–100 |
| `group_conformity` | Degree to which agreement pressure, coalitional reasoning, or groupthink may suppress challenge | 0–100 |
| `decision_error` | Synthetic binary indicator of decision error associated with bias-pressure conditions | 0/1 |
| `escalation_of_commitment` | Synthetic binary indicator of continued commitment despite weakening evidence | 0/1 |

## Interpretation

Variables are institutional, unit-level, and decision-system indicators. They should not be interpreted as measures of individual intelligence, objectivity, competence, loyalty, performance, personality, or psychological status.

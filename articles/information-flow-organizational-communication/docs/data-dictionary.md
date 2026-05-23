# Data Dictionary

## `data/raw/information_flow_synthetic.csv`

This synthetic dataset describes organizational units across repeated communication-review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `signal_quality` | Relevance, accuracy, completeness, and usefulness of available signals | 0–100 |
| `timeliness` | Speed at which relevant information reaches appropriate actors | 0–100 |
| `interpretive_clarity` | Degree to which information is understandable and meaningfully contextualized | 0–100 |
| `cross_functional_connectivity` | Ability of knowledge to move across units, roles, and professional domains | 0–100 |
| `psychological_safety` | Ability to raise concerns, questions, errors, or uncertainty without retaliation or humiliation | 0–100 |
| `distortion_risk` | Risk that information is filtered, softened, politicized, misrepresented, or misunderstood | 0–100 |
| `overload_pressure` | Degree to which message volume, meetings, dashboards, or notifications overwhelm attention | 0–100 |
| `hierarchy_delay` | Delay or loss caused by hierarchical escalation, filtering, or permission structures | 0–100 |
| `external_signal_turbulence` | Volatility, ambiguity, or instability in signals entering from outside the organization | 0–100 |
| `decision_error` | Synthetic binary indicator of decision error associated with communication conditions | 0/1 |
| `escalation_failure` | Synthetic binary indicator of breakdown in escalation, visibility, or action conversion | 0/1 |

## Interpretation

Variables are institutional, unit-level, and communication-system indicators. They should not be interpreted as measures of individual communication skill, responsiveness, productivity, loyalty, performance, personality, or psychological status.

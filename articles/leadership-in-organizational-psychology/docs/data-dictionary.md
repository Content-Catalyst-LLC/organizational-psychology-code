# Data Dictionary

## `data/raw/leadership_capacity_synthetic.csv`

This synthetic dataset describes organizational units across repeated leadership-system review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `trust_generation` | Degree to which leadership behavior builds credibility, consistency, and confidence | 0–100 |
| `communication_clarity` | Degree to which leadership reduces ambiguity and explains priorities, constraints, and rationale | 0–100 |
| `motivational_support` | Degree to which leadership supports meaning, engagement, recognition, and sustained effort | 0–100 |
| `legitimacy_quality` | Degree to which leadership influence is perceived as fair, competent, and justified | 0–100 |
| `adaptive_coordination` | Degree to which leadership coordinates action under complexity and uncertainty | 0–100 |
| `psychological_safety` | Degree to which leadership supports honest voice, risk reporting, dissent, and learning | 0–100 |
| `role_clarity` | Degree to which roles, responsibilities, goals, and decision rights are understandable | 0–100 |
| `ethical_accountability` | Degree to which leadership behavior is reviewable, fair, restrained, and consistent | 0–100 |
| `decision_transparency` | Degree to which decisions are explained, documented, and connected to evidence and values | 0–100 |
| `voice_access` | Degree to which affected groups can raise questions, concerns, and dissent safely | 0–100 |
| `ambiguity_pressure` | Degree of uncertainty, confusion, or unclear meaning surrounding priorities and decisions | 0–100 |
| `distrust_pressure` | Degree of cynicism, credibility decay, fear, or skepticism surrounding leadership | 0–100 |
| `fragmentation_pressure` | Degree of siloing, identity fragmentation, cross-functional breakdown, or misalignment | 0–100 |
| `overload_pressure` | Degree of strain, work overload, and exhaustion pressure affecting leadership credibility | 0–100 |
| `voice_suppression_risk` | Synthetic binary indicator of elevated risk that employees will withhold concerns or dissent | 0/1 |
| `performance_risk` | Synthetic binary indicator of elevated institutional performance risk | 0/1 |
| `legitimacy_decay_risk` | Synthetic binary indicator of elevated leadership legitimacy decay | 0/1 |
| `fragmentation_risk` | Synthetic binary indicator of elevated fragmentation or coordination breakdown risk | 0/1 |

Variables are unit-level, leadership-system-level, and institutional indicators. They should not be interpreted as measures of individual worker productivity, loyalty, motivation, dissent, employability, morality, psychological status, political influence, or worth.

# Data Dictionary

## `data/raw/leadership_style_synthetic.csv`

This synthetic dataset describes organizational units across repeated leadership-style review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `participative_behavior` | Degree to which leaders invite meaningful input, expertise, and voice | 0–100 |
| `structural_guidance` | Degree to which leaders provide clear roles, expectations, priorities, and decision boundaries | 0–100 |
| `communication_quality` | Clarity, timeliness, responsiveness, and interpretive usefulness of leadership communication | 0–100 |
| `trust_generation` | Degree to which leadership behavior builds credibility, consistency, and confidence | 0–100 |
| `developmental_support` | Degree to which leaders support learning, feedback, coaching, and capacity-building | 0–100 |
| `psychological_safety` | Degree to which leadership supports voice, dissent, error reporting, and speakable uncertainty | 0–100 |
| `decision_fit` | Fit between leadership decision style and task, risk, expertise distribution, and context | 0–100 |
| `cultural_alignment` | Degree to which leadership style aligns with institutional values and healthy cultural norms | 0–100 |
| `control_pressure` | Degree to which leadership relies on coercive pressure, overcontrol, or fear-based compliance | 0–100 |
| `ambiguity_risk` | Degree to which leadership creates unclear roles, priorities, decision rights, or expectations | 0–100 |
| `disengagement_pressure` | Degree to which leadership patterns contribute to cynicism, withdrawal, or low commitment | 0–100 |
| `voice_suppression_risk` | Synthetic binary indicator of elevated risk that employees will withhold concerns or dissent | 0/1 |
| `performance_risk` | Synthetic binary indicator of elevated institutional performance risk | 0/1 |
| `style_misfit_risk` | Synthetic binary indicator that leadership style appears poorly matched to context | 0/1 |
| `authoritarian_overuse_risk` | Synthetic binary indicator of excessive directive control or centralized authority | 0/1 |
| `laissez_faire_absence_risk` | Synthetic binary indicator of leader absence, weak guidance, or accountability gaps | 0/1 |

## Interpretation

Variables are unit-level, leadership-system-level, and institutional indicators. They should not be interpreted as measures of individual worker productivity, loyalty, motivation, dissent, employability, morality, psychological status, or worth.

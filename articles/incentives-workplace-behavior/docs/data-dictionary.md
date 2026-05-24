# Data Dictionary

## `data/raw/incentive_system_synthetic.csv`

This synthetic dataset describes organizational units across repeated incentive-system review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `expectancy_strength` | Degree to which employees believe effort can realistically produce performance and reward | 0–100 |
| `fairness_perception` | Perceived fairness and legitimacy of reward distribution | 0–100 |
| `strategic_alignment` | Degree to which incentives align with institutional strategy, values, and long-term purpose | 0–100 |
| `intrinsic_support` | Degree to which incentives support autonomy, mastery, meaning, and professional identity | 0–100 |
| `feedback_clarity` | Clarity, timeliness, and usefulness of criteria, evaluation, and performance feedback | 0–100 |
| `distortion_risk` | Degree to which incentives may encourage gaming, proxy failure, quality neglect, or metric fixation | 0–100 |
| `overload_pressure` | Degree to which incentives create unsustainable pace, strain, or burnout pressure | 0–100 |
| `ethical_risk` | Degree to which incentives may encourage harmful shortcuts, concealment, or stakeholder harm | 0–100 |
| `cooperation_support` | Degree to which incentives reinforce collaboration, knowledge sharing, and team contribution | 0–100 |
| `recognition_legitimacy` | Degree to which recognition is specific, fair, credible, and tied to real contribution | 0–100 |
| `reward_transparency` | Degree to which reward criteria and processes are clear, explainable, and reviewable | 0–100 |
| `hidden_labor_recognition` | Degree to which coordination, mentoring, repair, care, and support work are recognized | 0–100 |
| `performance_risk` | Synthetic binary indicator of elevated performance-system risk | 0/1 |
| `incentive_gaming_risk` | Synthetic binary indicator of elevated gaming or metric-optimization risk | 0/1 |
| `symbolic_reward_risk` | Synthetic binary indicator of reward rhetoric without credible incentive-system conditions | 0/1 |

## Interpretation

Variables are unit-level, incentive-system-level, and institutional indicators. They should not be interpreted as measures of individual productivity, effort, loyalty, incentive compliance, employability, morality, psychological status, or worth.

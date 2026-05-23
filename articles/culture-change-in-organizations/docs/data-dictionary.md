# Data Dictionary

## `data/raw/culture_change_capacity_synthetic.csv`

This synthetic dataset describes organizational units across repeated culture-change review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `leadership_credibility` | Consistency between leadership language, behavior, resource allocation, and crisis conduct | 0–100 |
| `narrative_coherence` | Clarity and legitimacy of the change story across groups | 0–100 |
| `reinforcement_alignment` | Alignment among incentives, promotion, sanctions, evaluation, governance, and stated values | 0–100 |
| `adaptive_learning` | Ability to reflect, revise assumptions, learn from feedback, and update practice | 0–100 |
| `psychological_safety` | Ability to speak honestly about contradictions, risks, failure, and uncertainty | 0–100 |
| `identity_adaptability` | Ability to reinterpret institutional purpose while preserving meaningful continuity | 0–100 |
| `resistance_intensity` | Degree of mistrust, ambivalence, identity threat, or opposition to change | 0–100 |
| `subcultural_fragmentation` | Degree of uneven translation across professions, functions, regions, hierarchy, or local histories | 0–100 |
| `legacy_lock_in` | Strength of entrenched routines, stories, assumptions, and reinforcement patterns | 0–100 |
| `leadership_turnover` | Synthetic binary indicator of turnover affecting cultural continuity | 0/1 |
| `successful_cultural_adoption` | Synthetic binary indicator of meaningful cultural adoption | 0/1 |
| `symbolic_culture_change` | Synthetic binary indicator of values language without deeper reinforcement or behavior change | 0/1 |

## Interpretation

Variables are institutional, unit-level, and culture-system indicators. They should not be interpreted as measures of individual loyalty, fit, attitude, performance, identity, personality, or psychological status.

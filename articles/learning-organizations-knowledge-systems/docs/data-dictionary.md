# Data Dictionary

## `data/raw/organizational_learning_synthetic.csv`

This synthetic dataset describes organizational units across repeated periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `information_quality` | Relevance, timeliness, and interpretive usefulness of available information | 0–100 |
| `interpretive_openness` | Willingness to challenge assumptions and revise frames | 0–100 |
| `memory_retention` | Ability to preserve lessons across time, turnover, and restructuring | 0–100 |
| `communication_flow` | Cross-boundary movement of knowledge and feedback | 0–100 |
| `psychological_safety` | Ability for concern, dissent, uncertainty, and error to surface | 0–100 |
| `governance_support` | Formal support for review, learning, redesign, and accountability | 0–100 |
| `complexity_load` | Environmental, technical, or task complexity facing the unit | 0–100 |
| `silo_intensity` | Degree to which knowledge is trapped in units, platforms, or professional groups | 0–100 |
| `incentive_distortion` | Degree to which metrics, rewards, or punishments suppress learning | 0–100 |
| `turnover_pressure` | Pressure from staff movement, leadership change, or loss of institutional memory | 0–100 |
| `adaptive_improvement` | Synthetic binary indicator of whether learning translated into adaptive improvement | 0/1 |
| `knowledge_decay_event` | Synthetic binary indicator of significant memory loss or learning erosion | 0/1 |

## Interpretation

Variables are institutional and system-level indicators. They should not be interpreted as measures of individual intelligence, adaptability, attitude, motivation, learning style, resilience, or performance.

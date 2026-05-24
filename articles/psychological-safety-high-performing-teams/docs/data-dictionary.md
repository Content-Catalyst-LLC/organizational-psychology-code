# Data Dictionary

## `data/raw/psychological_safety_synthetic.csv`

This synthetic dataset describes teams across repeated psychological safety review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `team_id` | Synthetic team identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `leadership_openness` | Degree to which leaders invite, hear, and respond constructively to questions, dissent, bad news, and uncertainty | 0–100 |
| `inclusion_quality` | Degree to which members across status, identity, expertise, and role differences are able to participate meaningfully | 0–100 |
| `learning_review_quality` | Quality of retrospectives, postmortems, after-action reviews, and learning routines | 0–100 |
| `knowledge_sharing` | Degree to which relevant knowledge moves across members and roles | 0–100 |
| `blame_intensity` | Degree to which error, uncertainty, or dissent triggers humiliation, defensiveness, or punitive response | 0–100 |
| `status_asymmetry` | Degree to which status, hierarchy, credential power, or social dominance suppresses voice | 0–100 |
| `perceived_penalty` | Perceived interpersonal, reputational, or career penalty for speaking up | 0–100 |
| `workload_pressure` | Workload intensity and time pressure that may reduce voice, reflection, and learning | 0–100 |
| `strong_team_performance` | Synthetic binary indicator of team performance integrity | 0/1 |
| `symbolic_voice_risk` | Synthetic binary indicator of formal speaking-up language without credible protection | 0/1 |

## Interpretation

Variables are team-level, system-level, and institutional indicators. They should not be interpreted as measures of individual courage, loyalty, personality, competence, morality, cultural fit, psychological status, or employability.

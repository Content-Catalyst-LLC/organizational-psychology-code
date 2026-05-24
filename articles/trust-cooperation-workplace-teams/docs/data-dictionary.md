# Data Dictionary

## `data/raw/trust_cooperation_synthetic.csv`

This synthetic dataset describes teams across repeated trust-and-cooperation review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `team_id` | Synthetic team identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `competence_trust` | Confidence that others have the skill, judgment, and reliability required for the work | 0–100 |
| `integrity_trust` | Confidence that commitments, standards, and principles will be honored | 0–100 |
| `benevolence_trust` | Confidence that vulnerability will not be exploited and that others will act with reasonable care | 0–100 |
| `reciprocity_norms` | Strength of mutual support, fair burden-sharing, and repeated contribution norms | 0–100 |
| `communication_reliability` | Clarity, responsiveness, and dependability of communication and handoffs | 0–100 |
| `opportunism_risk` | Perceived risk that actors will exploit ambiguity, shift burdens, conceal information, or act self-protectively | 0–100 |
| `power_imbalance` | Degree to which hierarchy, status, resources, or credibility differences constrain mutuality | 0–100 |
| `uncertainty_load` | Role, environmental, workload, or coordination uncertainty affecting trust and cooperation | 0–100 |
| `leadership_credibility` | Consistency between leadership messages, decisions, fairness, and follow-through | 0–100 |
| `institutional_trust` | Confidence in organizational procedures, governance, standards, and accountability systems | 0–100 |
| `strong_collaboration` | Synthetic binary indicator of strong collaborative performance | 0/1 |
| `symbolic_cooperation_risk` | Synthetic binary indicator of cooperation language without credible reciprocal support | 0/1 |

## Interpretation

Variables are team-level, system-level, and institutional indicators. They should not be interpreted as measures of individual trustworthiness, loyalty, cooperativeness, personality, morality, cultural fit, psychological status, or employability.

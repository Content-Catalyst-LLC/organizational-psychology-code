# Data Dictionary

## `data/raw/authority_governance_synthetic.csv`

This synthetic dataset describes organizational units across repeated authority/governance review periods. It is designed for methods demonstration only.

| Field | Description | Scale |
|---|---|---|
| `unit_id` | Synthetic organizational unit identifier | Categorical |
| `period` | Synthetic observation period | Integer |
| `formal_legitimacy` | Degree to which formal authority is recognized as justified and role-grounded | 0–100 |
| `procedural_fairness` | Degree to which decisions are made through clear, consistent, respectful, and intelligible procedures | 0–100 |
| `informational_access` | Degree to which relevant information reaches decision-makers and affected groups appropriately | 0–100 |
| `practical_influence` | Degree to which authority has workable influence over implementation | 0–100 |
| `ethical_credibility` | Degree to which authority is exercised with restraint, integrity, and consistency | 0–100 |
| `accountability_quality` | Degree to which power and decisions are reviewable, documented, and subject to correction | 0–100 |
| `voice_access` | Degree to which affected groups can provide input, raise concerns, and challenge decisions safely | 0–100 |
| `oversight_strength` | Degree to which governance includes meaningful independent or structured review | 0–100 |
| `arbitrariness_risk` | Degree to which decisions appear discretionary, inconsistent, selective, or unexplained | 0–100 |
| `governance_fragmentation` | Degree to which competing authority centers create unclear responsibility or incoherent decisions | 0–100 |
| `distrust_pressure` | Degree of cynicism, skepticism, fear, or legitimacy decay surrounding authority | 0–100 |
| `informal_power_concentration` | Degree to which influence is concentrated in hidden networks, bottlenecks, or unaccountable gatekeepers | 0–100 |
| `governance_risk` | Synthetic binary indicator of elevated governance risk | 0/1 |
| `shadow_governance_risk` | Synthetic binary indicator of elevated hidden influence or informal decision-making risk | 0/1 |
| `legitimacy_decay_risk` | Synthetic binary indicator of elevated legitimacy erosion risk | 0/1 |

## Interpretation

Variables are unit-level, authority-system-level, and institutional indicators. They should not be interpreted as measures of individual loyalty, productivity, political influence, dissent, morality, psychological status, or worth.

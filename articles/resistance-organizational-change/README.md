# Resistance to Organizational Change

This companion scaffold supports the article **“Resistance to Organizational Change.”** It provides synthetic datasets, reproducible workflows, documentation, validation notes, and multi-language examples for studying resistance to change as an institutional and system-level phenomenon.

The scaffold treats resistance not as a defect of employee attitude, but as a patterned response to perceived disruption in routines, authority, identity, incentives, power, trust, workload, and institutional meaning. It is designed to support serious organizational psychology research, institutional learning, and responsible change-governance analysis.

## Research purpose

This repository is designed for:

- organizational psychology methods demonstration
- synthetic-data modeling
- change-readiness research scaffolding
- organizational change governance
- institutional learning and post-change review
- implementation risk analysis
- responsible and reproducible organizational analytics

It is not designed for employee scoring, workplace surveillance, psychological assessment, or employment decision-making.

## Conceptual frame

The synthetic workflow models resistance to organizational change as a system-level construct shaped by:

- perceived loss
- uncertainty
- identity threat
- routine embeddedness
- power displacement
- trust in leadership
- participation quality
- implementation clarity
- workload strain
- prior failed change history
- resistance intensity
- constructive adoption
- change-friction risk

## Repository structure

```text
articles/resistance-organizational-change/
├── c/
├── cpp/
├── data/
│   ├── raw/
│   └── processed/
├── docs/
├── fortran/
├── go/
├── julia/
├── notebooks/
├── outputs/
│   ├── figures/
│   └── tables/
├── python/
├── r/
├── rust/
├── sql/
├── README.md
├── article-metadata.yml
└── github-embed-wordpress.html
```

## Responsible-use notice

These materials are for synthetic-data research, methods demonstration, institutional learning, organizational change governance, and reproducible workflows.

They are **not** employee-screening tools, employment-selection tools, hiring tools, promotion tools, compensation tools, discipline tools, termination tools, workplace surveillance systems, individual performance-management systems, or psychological assessment tools.

The appropriate unit of analysis is the institution, work system, change process, implementation environment, governance structure, or organizational condition—not the worth, attitude, adaptability, loyalty, employability, or psychological status of an individual worker.

## Suggested workflow

1. Read `docs/ethics-scope-note.md`.
2. Review `docs/research-design.md`.
3. Inspect `docs/data-dictionary.md`.
4. Run the Python workflow in `python/change_resistance_model.py`.
5. Run the R workflow in `r/change_resistance_model.R`.
6. Use `sql/schema.sql` for a reproducible relational representation.
7. Review `docs/validation-plan.md` and `docs/model-card.md`.
8. Use the WordPress GitHub embed block in `github-embed-wordpress.html`.

## Outputs

Generated outputs are written to:

- `outputs/tables/`
- `outputs/figures/`

Outputs are synthetic demonstration artifacts. They are not empirical findings about any real organization.

# Organizational Identity and Institutional Legitimacy
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, organizational identity review, legitimacy analysis,
# governance review, and reproducible workflows. It is not an employee-screening,
# hiring, promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, cultural-loyalty scoring, worker legitimacy
# scoring, productivity-ranking, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "identity_legitimacy_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

identity_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- identity_data %>%
  mutate(
    identity_coherence_score = pmin(
      pmax(
        0.18 * mission_clarity +
          0.17 * value_practice_alignment +
          0.15 * narrative_continuity +
          0.14 * leadership_credibility +
          0.14 * behavioral_consistency -
          0.10 * internal_fragmentation -
          0.07 * identity_contradiction -
          0.05 * legitimacy_pressure,
        0
      ),
      100
    ),
    identity_risk_score = pmin(
      pmax(
        0.14 * (100 - mission_clarity) +
          0.16 * (100 - value_practice_alignment) +
          0.10 * (100 - narrative_continuity) +
          0.12 * (100 - leadership_credibility) +
          0.10 * (100 - behavioral_consistency) +
          0.12 * internal_fragmentation +
          0.16 * identity_contradiction +
          0.10 * legitimacy_pressure,
        0
      ),
      100
    ),
    identity_legitimacy_review_priority = case_when(
      identity_risk_score >= 70 |
        identity_coherence_score < 45 |
        symbolic_identity_risk == 1 ~ "Immediate Review",
      identity_risk_score >= 50 |
        identity_coherence_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_identity_legitimacy_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_identity_coherence = mean(identity_coherence_score),
    avg_identity_risk = mean(identity_risk_score),
    avg_mission_clarity = mean(mission_clarity),
    avg_value_practice_alignment = mean(value_practice_alignment),
    avg_narrative_continuity = mean(narrative_continuity),
    avg_leadership_credibility = mean(leadership_credibility),
    avg_behavioral_consistency = mean(behavioral_consistency),
    avg_internal_fragmentation = mean(internal_fragmentation),
    avg_identity_contradiction = mean(identity_contradiction),
    avg_legitimacy_pressure = mean(legitimacy_pressure),
    stakeholder_legitimacy_rate = mean(stakeholder_legitimacy),
    symbolic_identity_risk_rate = mean(symbolic_identity_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_identity_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_identity_legitimacy_summary.csv"))

legitimacy_model <- glm(
  stakeholder_legitimacy ~ mission_clarity + value_practice_alignment +
    narrative_continuity + leadership_credibility + behavioral_consistency +
    internal_fragmentation + identity_contradiction + legitimacy_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(legitimacy_model),
  file = file.path(table_dir, "r_stakeholder_legitimacy_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_identity_risk), y = avg_identity_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Identity Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average identity risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_identity_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

alignment_plot <- ggplot(
  scored,
  aes(x = value_practice_alignment, y = identity_coherence_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Value-Practice Alignment and Identity Coherence",
    x = "Value-practice alignment",
    y = "Identity coherence score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_value_practice_alignment_identity_coherence.png"),
  plot = alignment_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic identity-legitimacy workflow only.")

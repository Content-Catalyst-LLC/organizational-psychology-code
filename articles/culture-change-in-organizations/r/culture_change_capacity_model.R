# Culture Change in Organizations
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, culture-change review, organizational development
# education, and reproducible workflows. It is not an employee-screening,
# hiring, promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, cultural-loyalty scoring, productivity-ranking,
# or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "culture_change_capacity_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

culture_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- culture_data %>%
  mutate(
    culture_change_capacity_score = pmin(
      pmax(
        0.17 * leadership_credibility +
          0.15 * narrative_coherence +
          0.15 * reinforcement_alignment +
          0.14 * adaptive_learning +
          0.13 * psychological_safety +
          0.11 * identity_adaptability -
          0.12 * resistance_intensity -
          0.10 * subcultural_fragmentation -
          0.11 * legacy_lock_in -
          4.00 * leadership_turnover,
        0
      ),
      100
    ),
    culture_risk_score = pmin(
      pmax(
        0.14 * (100 - leadership_credibility) +
          0.10 * (100 - narrative_coherence) +
          0.14 * (100 - reinforcement_alignment) +
          0.10 * (100 - adaptive_learning) +
          0.10 * (100 - psychological_safety) +
          0.08 * (100 - identity_adaptability) +
          0.14 * resistance_intensity +
          0.10 * subcultural_fragmentation +
          0.08 * legacy_lock_in +
          2.00 * leadership_turnover,
        0
      ),
      100
    ),
    culture_change_review_priority = case_when(
      culture_risk_score >= 70 |
        culture_change_capacity_score < 45 |
        symbolic_culture_change == 1 ~ "Immediate Review",
      culture_risk_score >= 50 |
        culture_change_capacity_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_culture_change_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_culture_change_capacity = mean(culture_change_capacity_score),
    avg_culture_risk = mean(culture_risk_score),
    avg_leadership_credibility = mean(leadership_credibility),
    avg_narrative_coherence = mean(narrative_coherence),
    avg_reinforcement_alignment = mean(reinforcement_alignment),
    avg_psychological_safety = mean(psychological_safety),
    avg_identity_adaptability = mean(identity_adaptability),
    avg_resistance_intensity = mean(resistance_intensity),
    avg_subcultural_fragmentation = mean(subcultural_fragmentation),
    avg_legacy_lock_in = mean(legacy_lock_in),
    cultural_adoption_rate = mean(successful_cultural_adoption),
    symbolic_culture_change_rate = mean(symbolic_culture_change),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_culture_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_culture_change_summary.csv"))

adoption_model <- glm(
  successful_cultural_adoption ~ leadership_credibility + narrative_coherence +
    reinforcement_alignment + adaptive_learning + psychological_safety +
    identity_adaptability + resistance_intensity + subcultural_fragmentation +
    legacy_lock_in + leadership_turnover,
  family = binomial(),
  data = scored
)

capture.output(
  summary(adoption_model),
  file = file.path(table_dir, "r_cultural_adoption_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_culture_risk), y = avg_culture_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Culture Change Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average culture risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_culture_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

alignment_plot <- ggplot(
  scored,
  aes(x = reinforcement_alignment, y = culture_change_capacity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Reinforcement Alignment and Culture Change Capacity",
    x = "Reinforcement alignment",
    y = "Culture change capacity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_reinforcement_alignment_culture_capacity.png"),
  plot = alignment_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic culture-change workflow only.")

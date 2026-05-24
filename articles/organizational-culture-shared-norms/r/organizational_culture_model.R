# Organizational Culture and Shared Norms
# Exceptional synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, culture review, organizational development education,
# legitimacy analysis, and reproducible workflows. It is not an employee-screening,
# hiring, promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, cultural-loyalty scoring, cultural-fit scoring,
# productivity-ranking, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "organizational_culture_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

culture_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- culture_data %>%
  mutate(
    cultural_coherence_score = pmin(
      pmax(
        0.18 * value_alignment +
          0.16 * normative_consistency +
          0.15 * leadership_credibility +
          0.14 * psychological_safety +
          0.14 * shared_meaning -
          0.10 * contradiction -
          0.08 * fragmentation -
          0.10 * incentive_distortion -
          0.05 * external_pressure,
        0
      ),
      100
    ),
    culture_risk_score = pmin(
      pmax(
        0.14 * (100 - value_alignment) +
          0.12 * (100 - normative_consistency) +
          0.12 * (100 - leadership_credibility) +
          0.12 * (100 - psychological_safety) +
          0.12 * (100 - shared_meaning) +
          0.14 * contradiction +
          0.10 * fragmentation +
          0.10 * incentive_distortion +
          0.04 * external_pressure,
        0
      ),
      100
    ),
    culture_review_priority = case_when(
      culture_risk_score >= 70 |
        cultural_coherence_score < 45 |
        symbolic_culture_risk == 1 ~ "Immediate Review",
      culture_risk_score >= 50 |
        cultural_coherence_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_organizational_culture_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_cultural_coherence = mean(cultural_coherence_score),
    avg_culture_risk = mean(culture_risk_score),
    avg_value_alignment = mean(value_alignment),
    avg_normative_consistency = mean(normative_consistency),
    avg_leadership_credibility = mean(leadership_credibility),
    avg_psychological_safety = mean(psychological_safety),
    avg_shared_meaning = mean(shared_meaning),
    avg_contradiction = mean(contradiction),
    avg_fragmentation = mean(fragmentation),
    avg_incentive_distortion = mean(incentive_distortion),
    avg_external_pressure = mean(external_pressure),
    performance_integrity_rate = mean(strong_institutional_performance),
    symbolic_culture_risk_rate = mean(symbolic_culture_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_culture_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_organizational_culture_summary.csv"))

performance_model <- glm(
  strong_institutional_performance ~ value_alignment + normative_consistency +
    leadership_credibility + psychological_safety + shared_meaning +
    contradiction + fragmentation + incentive_distortion + external_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(performance_model),
  file = file.path(table_dir, "r_performance_integrity_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_culture_risk), y = avg_culture_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Organizational Culture Risk by Unit",
    x = "Synthetic unit",
    y = "Average culture risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_organizational_culture_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

alignment_plot <- ggplot(
  scored,
  aes(x = value_alignment, y = cultural_coherence_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Value Alignment and Cultural Coherence",
    x = "Value alignment",
    y = "Cultural coherence score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_value_alignment_cultural_coherence.png"),
  plot = alignment_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic organizational culture workflow only.")

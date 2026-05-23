# Adaptive Organizations: Institutional Change and Strategic Transformation
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, organizational change governance, and reproducible
# workflows. It is not an employee-screening, hiring, promotion, compensation,
# discipline, termination, workplace surveillance, individual performance-
# management, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "adaptive_change_capacity_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

change_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- change_data %>%
  mutate(
    adaptive_change_capacity_score = pmin(
      pmax(
        0.17 * sensing_quality +
          0.16 * interpretive_coherence +
          0.15 * governance_alignment +
          0.16 * learning_capability +
          0.12 * resource_flexibility +
          0.12 * institutional_legitimacy -
          0.13 * organizational_inertia -
          0.11 * fragmentation -
          0.10 * resistance_friction -
          0.05 * environmental_pressure,
        0
      ),
      100
    ),
    adaptation_risk_score = pmin(
      pmax(
        0.16 * (100 - sensing_quality) +
          0.14 * (100 - interpretive_coherence) +
          0.14 * (100 - governance_alignment) +
          0.14 * (100 - learning_capability) +
          0.10 * (100 - resource_flexibility) +
          0.10 * (100 - institutional_legitimacy) +
          0.10 * organizational_inertia +
          0.06 * fragmentation +
          0.04 * resistance_friction +
          0.02 * environmental_pressure,
        0
      ),
      100
    ),
    change_governance_review_priority = case_when(
      adaptation_risk_score >= 70 |
        adaptive_change_capacity_score < 45 |
        symbolic_change == 1 ~ "Immediate Review",
      adaptation_risk_score >= 50 |
        adaptive_change_capacity_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_adaptive_change_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_adaptive_change_capacity = mean(adaptive_change_capacity_score),
    avg_adaptation_risk = mean(adaptation_risk_score),
    avg_sensing_quality = mean(sensing_quality),
    avg_governance_alignment = mean(governance_alignment),
    avg_learning_capability = mean(learning_capability),
    avg_institutional_legitimacy = mean(institutional_legitimacy),
    avg_organizational_inertia = mean(organizational_inertia),
    avg_fragmentation = mean(fragmentation),
    transformation_rate = mean(successful_transformation),
    symbolic_change_rate = mean(symbolic_change),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_adaptation_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_adaptive_change_summary.csv"))

transformation_model <- glm(
  successful_transformation ~ sensing_quality + interpretive_coherence +
    governance_alignment + learning_capability + resource_flexibility +
    institutional_legitimacy + organizational_inertia + fragmentation +
    resistance_friction + environmental_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(transformation_model),
  file = file.path(table_dir, "r_successful_transformation_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_adaptation_risk), y = avg_adaptation_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Adaptation Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average adaptation risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_adaptation_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

learning_plot <- ggplot(
  scored,
  aes(x = learning_capability, y = adaptive_change_capacity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Learning Capability and Adaptive Change Capacity",
    x = "Learning capability",
    y = "Adaptive change capacity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_learning_adaptive_change_relationship.png"),
  plot = learning_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic institutional learning workflow only.")

# R Workflow: Describing Complex Behavioral System Conditions Across Units
# Synthetic organizational psychology demonstration.
#
# Responsible-use scope:
# This workflow is for synthetic-data research, methods demonstration,
# institutional learning, and organizational psychology education.
# It is not an employee-screening, hiring, promotion, compensation, discipline,
# termination, workplace surveillance, individual performance-management,
# productivity-ranking, loyalty-scoring, dissent-tracking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "complex_behavioral_systems_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

system_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- system_data %>%
  mutate(
    modeled_behavior_quality = pmin(
      pmax(
        0.13 * capability +
          0.12 * motivation +
          0.12 * role_clarity +
          0.11 * psychological_safety +
          0.11 * leadership_trust +
          0.09 * cultural_coherence +
          0.09 * incentive_alignment +
          0.08 * information_flow +
          0.07 * learning_capacity +
          0.05 * redundancy_slack -
          0.08 * workload_pressure -
          0.06 * silence_risk -
          0.06 * fragmentation_pressure -
          0.05 * environmental_uncertainty,
        0
      ),
      100
    ),
    modeled_complex_system_risk = pmin(
      pmax(
        0.11 * (100 - psychological_safety) +
          0.11 * (100 - leadership_trust) +
          0.09 * (100 - cultural_coherence) +
          0.09 * (100 - incentive_alignment) +
          0.09 * (100 - information_flow) +
          0.10 * (100 - learning_capacity) +
          0.08 * (100 - redundancy_slack) +
          0.09 * workload_pressure +
          0.08 * silence_risk +
          0.10 * fragmentation_pressure +
          0.08 * environmental_uncertainty,
        0
      ),
      100
    ),
    resilience_capacity_index = pmin(
      pmax(
        0.18 * psychological_safety +
          0.17 * leadership_trust +
          0.16 * information_flow +
          0.18 * learning_capacity +
          0.14 * redundancy_slack +
          0.09 * cultural_coherence +
          0.08 * incentive_alignment,
        0
      ),
      100
    ),
    review_priority = case_when(
      modeled_complex_system_risk >= 70 |
        modeled_behavior_quality < 45 ~ "Immediate Review",
      modeled_complex_system_risk >= 50 |
        modeled_behavior_quality < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_complex_behavioral_system_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    people = n(),
    avg_modeled_behavior_quality = mean(modeled_behavior_quality),
    avg_modeled_complex_system_risk = mean(modeled_complex_system_risk),
    avg_resilience_capacity = mean(resilience_capacity_index),
    avg_capability = mean(capability),
    avg_motivation = mean(motivation),
    avg_role_clarity = mean(role_clarity),
    avg_psychological_safety = mean(psychological_safety),
    avg_leadership_trust = mean(leadership_trust),
    avg_cultural_coherence = mean(cultural_coherence),
    avg_incentive_alignment = mean(incentive_alignment),
    avg_information_flow = mean(information_flow),
    avg_learning_capacity = mean(learning_capacity),
    avg_redundancy_slack = mean(redundancy_slack),
    avg_workload_pressure = mean(workload_pressure),
    avg_silence_risk = mean(silence_risk),
    avg_fragmentation_pressure = mean(fragmentation_pressure),
    avg_environmental_uncertainty = mean(environmental_uncertainty),
    .groups = "drop"
  ) %>%
  mutate(
    review_priority = case_when(
      avg_modeled_complex_system_risk >= 70 |
        avg_modeled_behavior_quality < 45 ~ "Immediate Review",
      avg_modeled_complex_system_risk >= 50 |
        avg_modeled_behavior_quality < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  ) %>%
  arrange(desc(avg_modeled_complex_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_complex_behavioral_system_summary.csv"))

behavior_model <- lm(
  modeled_behavior_quality ~ capability + motivation + role_clarity +
    psychological_safety + leadership_trust + cultural_coherence +
    incentive_alignment + information_flow + learning_capacity +
    redundancy_slack + workload_pressure + silence_risk +
    fragmentation_pressure + environmental_uncertainty,
  data = scored
)

capture.output(
  summary(behavior_model),
  file = file.path(table_dir, "r_behavior_quality_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_modeled_complex_system_risk), y = avg_modeled_complex_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Complex Behavioral System Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average complex system risk"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_complex_system_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

safety_plot <- ggplot(
  scored,
  aes(x = psychological_safety, y = modeled_behavior_quality)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Psychological Safety and Modeled Behavior Quality",
    x = "Psychological safety",
    y = "Modeled behavior quality"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_psychological_safety_behavior_quality.png"),
  plot = safety_plot,
  width = 8,
  height = 5,
  dpi = 160
)

fragmentation_plot <- ggplot(
  scored,
  aes(x = fragmentation_pressure, y = modeled_behavior_quality)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Fragmentation Pressure and Modeled Behavior Quality",
    x = "Fragmentation pressure",
    y = "Modeled behavior quality"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_fragmentation_behavior_quality.png"),
  plot = fragmentation_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic complex behavioral systems workflow only.")

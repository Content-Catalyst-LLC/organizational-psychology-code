# R Workflow: Describing Human Behavior Patterns Across Organizational Units
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
raw_path <- file.path(root, "data", "raw", "human_behavior_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

behavior_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- behavior_data %>%
  mutate(
    modeled_behavior_quality = pmin(
      pmax(
        0.16 * capability +
          0.15 * motivation +
          0.14 * role_clarity +
          0.12 * psychological_safety +
          0.12 * leadership_trust +
          0.10 * cultural_norm_strength +
          0.09 * incentive_alignment -
          0.08 * workload_pressure -
          0.08 * burnout_pressure -
          0.06 * hierarchical_pressure,
        0
      ),
      100
    ),
    modeled_behavior_system_risk = pmin(
      pmax(
        0.12 * (100 - role_clarity) +
          0.15 * (100 - psychological_safety) +
          0.15 * (100 - leadership_trust) +
          0.10 * (100 - cultural_norm_strength) +
          0.10 * (100 - incentive_alignment) +
          0.13 * workload_pressure +
          0.13 * burnout_pressure +
          0.07 * hierarchical_pressure +
          0.05 * fear_of_retaliation,
        0
      ),
      100
    ),
    modeled_voice_probability = plogis(
      -2.0 +
        0.030 * psychological_safety +
        0.024 * leadership_trust +
        0.022 * perceived_voice_efficacy -
        0.026 * fear_of_retaliation -
        0.020 * hierarchical_pressure
    ),
    review_priority = case_when(
      modeled_behavior_system_risk >= 70 |
        modeled_behavior_quality < 45 ~ "Immediate Review",
      modeled_behavior_system_risk >= 50 |
        modeled_behavior_quality < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_human_behavior_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    people = n(),
    avg_modeled_behavior_quality = mean(modeled_behavior_quality),
    avg_modeled_behavior_system_risk = mean(modeled_behavior_system_risk),
    avg_voice_probability = mean(modeled_voice_probability),
    voice_rate = mean(voice_behavior),
    avg_capability = mean(capability),
    avg_motivation = mean(motivation),
    avg_role_clarity = mean(role_clarity),
    avg_psychological_safety = mean(psychological_safety),
    avg_leadership_trust = mean(leadership_trust),
    avg_cultural_norm_strength = mean(cultural_norm_strength),
    avg_incentive_alignment = mean(incentive_alignment),
    avg_workload_pressure = mean(workload_pressure),
    avg_burnout_pressure = mean(burnout_pressure),
    avg_hierarchical_pressure = mean(hierarchical_pressure),
    avg_perceived_voice_efficacy = mean(perceived_voice_efficacy),
    avg_fear_of_retaliation = mean(fear_of_retaliation),
    .groups = "drop"
  ) %>%
  mutate(
    review_priority = case_when(
      avg_modeled_behavior_system_risk >= 70 |
        avg_modeled_behavior_quality < 45 ~ "Immediate Review",
      avg_modeled_behavior_system_risk >= 50 |
        avg_modeled_behavior_quality < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  ) %>%
  arrange(desc(avg_modeled_behavior_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_human_behavior_summary.csv"))

behavior_model <- lm(
  modeled_behavior_quality ~ capability + motivation + role_clarity +
    psychological_safety + leadership_trust + cultural_norm_strength +
    incentive_alignment + workload_pressure + burnout_pressure +
    hierarchical_pressure,
  data = scored
)

capture.output(
  summary(behavior_model),
  file = file.path(table_dir, "r_behavior_quality_model_summary.txt")
)

voice_model <- glm(
  voice_behavior ~ psychological_safety + leadership_trust +
    perceived_voice_efficacy + fear_of_retaliation + hierarchical_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(voice_model),
  file = file.path(table_dir, "r_voice_behavior_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_modeled_behavior_system_risk), y = avg_modeled_behavior_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Human Behavior System Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average behavior-system risk"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_behavior_system_risk_by_unit.png"),
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

voice_plot <- ggplot(
  scored,
  aes(x = leadership_trust, y = modeled_voice_probability)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Leadership Trust and Modeled Voice Probability",
    x = "Leadership trust",
    y = "Modeled voice probability"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_leadership_trust_voice_probability.png"),
  plot = voice_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic human behavior workflow only.")

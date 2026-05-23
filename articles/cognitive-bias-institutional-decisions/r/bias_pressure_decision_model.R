# Cognitive Bias in Institutional Decisions
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, decision-governance review, bias-risk analysis,
# and reproducible workflows. It is not an employee-screening, hiring,
# promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, executive-ranking, productivity-ranking,
# or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "bias_pressure_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

bias_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- bias_data %>%
  mutate(
    bias_pressure_score = pmin(
      pmax(
        0.16 * hierarchy_suppression +
          0.15 * time_pressure +
          0.14 * routine_reinforcement +
          0.13 * group_conformity -
          0.16 * viewpoint_diversity -
          0.13 * analytical_discipline -
          0.14 * structured_challenge -
          0.12 * learning_review -
          0.10 * signal_quality,
        0
      ),
      100
    ),
    bias_risk_score = pmin(
      pmax(
        0.10 * (100 - signal_quality) +
          0.13 * (100 - viewpoint_diversity) +
          0.12 * (100 - analytical_discipline) +
          0.12 * (100 - structured_challenge) +
          0.15 * hierarchy_suppression +
          0.12 * time_pressure +
          0.10 * routine_reinforcement +
          0.08 * (100 - learning_review) +
          0.08 * group_conformity,
        0
      ),
      100
    ),
    bias_governance_review_priority = case_when(
      bias_risk_score >= 70 |
        bias_pressure_score >= 70 |
        escalation_of_commitment == 1 ~ "Immediate Review",
      bias_risk_score >= 50 |
        bias_pressure_score >= 55 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_bias_pressure_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_bias_pressure = mean(bias_pressure_score),
    avg_bias_risk = mean(bias_risk_score),
    avg_signal_quality = mean(signal_quality),
    avg_viewpoint_diversity = mean(viewpoint_diversity),
    avg_analytical_discipline = mean(analytical_discipline),
    avg_structured_challenge = mean(structured_challenge),
    avg_hierarchy_suppression = mean(hierarchy_suppression),
    avg_time_pressure = mean(time_pressure),
    avg_learning_review = mean(learning_review),
    decision_error_rate = mean(decision_error),
    escalation_rate = mean(escalation_of_commitment),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_bias_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_bias_pressure_summary.csv"))

decision_error_model <- glm(
  decision_error ~ signal_quality + viewpoint_diversity +
    analytical_discipline + structured_challenge + hierarchy_suppression +
    time_pressure + routine_reinforcement + learning_review + group_conformity,
  family = binomial(),
  data = scored
)

capture.output(
  summary(decision_error_model),
  file = file.path(table_dir, "r_decision_error_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_bias_risk), y = avg_bias_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Bias Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average bias risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_bias_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

challenge_plot <- ggplot(
  scored,
  aes(x = structured_challenge, y = bias_pressure_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Structured Challenge and Bias Pressure",
    x = "Structured challenge",
    y = "Bias pressure score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_structured_challenge_bias_pressure.png"),
  plot = challenge_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic institutional decision-governance workflow only.")

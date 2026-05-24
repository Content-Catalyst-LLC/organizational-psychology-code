# Goal Setting and Performance Systems
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, goal-system review, performance-system education,
# feedback-quality analysis, metric-governance review, strategic-alignment
# analysis, and reproducible workflows. It is not an employee-screening, hiring,
# promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, productivity-ranking, goal-compliance
# scoring, cultural-loyalty scoring, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "goal_system_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

goal_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- goal_data %>%
  mutate(
    goal_system_effectiveness_score = pmin(
      pmax(
        0.13 * goal_clarity +
          0.10 * goal_challenge +
          0.13 * feedback_quality +
          0.11 * employee_commitment +
          0.13 * strategic_alignment +
          0.11 * review_quality +
          0.11 * goal_feasibility -
          0.07 * overload_pressure -
          0.06 * metric_distortion -
          0.05 * incentive_misalignment -
          0.04 * proxy_drift,
        0
      ),
      100
    ),
    goal_system_risk_score = pmin(
      pmax(
        0.12 * (100 - goal_clarity) +
          0.08 * (100 - goal_challenge) +
          0.13 * (100 - feedback_quality) +
          0.10 * (100 - employee_commitment) +
          0.13 * (100 - strategic_alignment) +
          0.10 * (100 - review_quality) +
          0.10 * (100 - goal_feasibility) +
          0.11 * overload_pressure +
          0.09 * metric_distortion +
          0.08 * incentive_misalignment +
          0.06 * proxy_drift,
        0
      ),
      100
    ),
    metric_governance_risk_score = pmin(
      pmax(
        0.28 * metric_distortion +
          0.26 * proxy_drift +
          0.20 * incentive_misalignment +
          0.14 * (100 - review_quality) +
          0.12 * metric_gaming_risk * 100,
        0
      ),
      100
    ),
    goal_review_priority = case_when(
      goal_system_risk_score >= 70 |
        goal_system_effectiveness_score < 45 |
        performance_risk == 1 |
        symbolic_alignment_risk == 1 ~ "Immediate Review",
      goal_system_risk_score >= 50 |
        goal_system_effectiveness_score < 60 |
        metric_governance_risk_score >= 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_goal_system_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_goal_system_effectiveness = mean(goal_system_effectiveness_score),
    avg_goal_system_risk = mean(goal_system_risk_score),
    avg_metric_governance_risk = mean(metric_governance_risk_score),
    avg_goal_clarity = mean(goal_clarity),
    avg_goal_challenge = mean(goal_challenge),
    avg_feedback_quality = mean(feedback_quality),
    avg_employee_commitment = mean(employee_commitment),
    avg_strategic_alignment = mean(strategic_alignment),
    avg_overload_pressure = mean(overload_pressure),
    avg_metric_distortion = mean(metric_distortion),
    avg_incentive_misalignment = mean(incentive_misalignment),
    avg_review_quality = mean(review_quality),
    avg_proxy_drift = mean(proxy_drift),
    avg_goal_feasibility = mean(goal_feasibility),
    performance_risk_rate = mean(performance_risk),
    metric_gaming_risk_rate = mean(metric_gaming_risk),
    symbolic_alignment_risk_rate = mean(symbolic_alignment_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_goal_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_goal_system_summary.csv"))

performance_risk_model <- glm(
  performance_risk ~ goal_clarity + goal_challenge + feedback_quality +
    employee_commitment + strategic_alignment + overload_pressure +
    metric_distortion + incentive_misalignment + review_quality + proxy_drift +
    goal_feasibility,
  family = binomial(),
  data = scored
)

capture.output(
  summary(performance_risk_model),
  file = file.path(table_dir, "r_performance_risk_model_summary.txt")
)

effectiveness_model <- lm(
  goal_system_effectiveness_score ~ goal_clarity + goal_challenge +
    feedback_quality + employee_commitment + strategic_alignment +
    review_quality + goal_feasibility + overload_pressure +
    metric_distortion + incentive_misalignment + proxy_drift,
  data = scored
)

capture.output(
  summary(effectiveness_model),
  file = file.path(table_dir, "r_goal_system_effectiveness_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_goal_system_risk), y = avg_goal_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Goal-System Risk by Unit",
    x = "Synthetic unit",
    y = "Average goal-system risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_goal_system_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

feedback_plot <- ggplot(
  scored,
  aes(x = feedback_quality, y = goal_system_effectiveness_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Feedback Quality and Goal-System Effectiveness",
    x = "Feedback quality",
    y = "Goal-system effectiveness score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_feedback_goal_system_effectiveness.png"),
  plot = feedback_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic goal-system workflow only.")

# Employee Motivation in Organizations
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, motivational-systems review, work-design education,
# autonomy/fairness/trust/workload analysis, leadership and culture review, and
# reproducible workflows. It is not an employee-screening, hiring, promotion,
# compensation, discipline, termination, workplace surveillance, individual
# performance-management, productivity-ranking, motivation scoring, loyalty
# scoring, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "motivation_system_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

motivation_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- motivation_data %>%
  mutate(
    motivation_quality_score = pmin(
      pmax(
        0.12 * autonomy_support +
          0.11 * competence_development +
          0.10 * recognition_quality +
          0.12 * institutional_trust +
          0.10 * goal_clarity +
          0.11 * fairness_perception +
          0.10 * relatedness +
          0.11 * meaningful_work +
          0.10 * psychological_safety +
          0.10 * leadership_credibility -
          0.08 * workload_strain -
          0.07 * control_pressure,
        0
      ),
      100
    ),
    adaptive_motivation_capacity_score = pmin(
      pmax(
        0.18 * motivation_quality_score +
          0.12 * autonomy_support +
          0.12 * competence_development +
          0.13 * institutional_trust +
          0.11 * goal_clarity +
          0.12 * psychological_safety +
          0.10 * leadership_credibility +
          0.08 * meaningful_work +
          0.04 * relatedness,
        0
      ),
      100
    ),
    motivation_system_risk_score = pmin(
      pmax(
        0.10 * (100 - autonomy_support) +
          0.09 * (100 - competence_development) +
          0.08 * (100 - recognition_quality) +
          0.12 * (100 - institutional_trust) +
          0.08 * (100 - goal_clarity) +
          0.11 * (100 - fairness_perception) +
          0.08 * (100 - relatedness) +
          0.09 * (100 - meaningful_work) +
          0.10 * (100 - psychological_safety) +
          0.09 * (100 - leadership_credibility) +
          0.11 * workload_strain +
          0.10 * control_pressure,
        0
      ),
      100
    ),
    burnout_control_risk_score = pmin(
      pmax(
        0.30 * workload_strain +
          0.25 * control_pressure +
          0.15 * (100 - autonomy_support) +
          0.12 * (100 - psychological_safety) +
          0.10 * burnout_risk * 100 +
          0.08 * controlled_motivation_risk * 100,
        0
      ),
      100
    ),
    motivation_review_priority = case_when(
      motivation_system_risk_score >= 70 |
        motivation_quality_score < 45 |
        performance_risk == 1 |
        burnout_risk == 1 |
        controlled_motivation_risk == 1 ~ "Immediate Review",
      motivation_system_risk_score >= 50 |
        motivation_quality_score < 60 |
        burnout_control_risk_score >= 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_motivation_system_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_motivation_quality = mean(motivation_quality_score),
    avg_adaptive_motivation_capacity = mean(adaptive_motivation_capacity_score),
    avg_motivation_system_risk = mean(motivation_system_risk_score),
    avg_burnout_control_risk = mean(burnout_control_risk_score),
    avg_autonomy_support = mean(autonomy_support),
    avg_competence_development = mean(competence_development),
    avg_recognition_quality = mean(recognition_quality),
    avg_institutional_trust = mean(institutional_trust),
    avg_goal_clarity = mean(goal_clarity),
    avg_fairness_perception = mean(fairness_perception),
    avg_workload_strain = mean(workload_strain),
    avg_control_pressure = mean(control_pressure),
    avg_relatedness = mean(relatedness),
    avg_meaningful_work = mean(meaningful_work),
    avg_psychological_safety = mean(psychological_safety),
    avg_leadership_credibility = mean(leadership_credibility),
    performance_risk_rate = mean(performance_risk),
    burnout_risk_rate = mean(burnout_risk),
    controlled_motivation_risk_rate = mean(controlled_motivation_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_motivation_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_motivation_system_summary.csv"))

performance_risk_model <- glm(
  performance_risk ~ autonomy_support + competence_development +
    recognition_quality + institutional_trust + goal_clarity +
    fairness_perception + workload_strain + control_pressure +
    relatedness + meaningful_work + psychological_safety + leadership_credibility,
  family = binomial(),
  data = scored
)

capture.output(
  summary(performance_risk_model),
  file = file.path(table_dir, "r_performance_risk_model_summary.txt")
)

motivation_model <- lm(
  motivation_quality_score ~ autonomy_support + competence_development +
    recognition_quality + institutional_trust + goal_clarity +
    fairness_perception + relatedness + meaningful_work +
    psychological_safety + leadership_credibility + workload_strain +
    control_pressure,
  data = scored
)

capture.output(
  summary(motivation_model),
  file = file.path(table_dir, "r_motivation_quality_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_motivation_system_risk), y = avg_motivation_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Motivational-System Risk by Unit",
    x = "Synthetic unit",
    y = "Average motivational-system risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_motivation_system_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

autonomy_plot <- ggplot(
  scored,
  aes(x = autonomy_support, y = motivation_quality_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Autonomy Support and Motivation Quality",
    x = "Autonomy support",
    y = "Motivation quality score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_autonomy_motivation_quality.png"),
  plot = autonomy_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic motivational-system workflow only.")

# Job Satisfaction and Organizational Commitment
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, work-attitude review, retention-system education,
# fairness and workload analysis, leadership and culture review, and reproducible
# workflows. It is not an employee-screening, hiring, promotion, compensation,
# discipline, termination, workplace surveillance, individual performance-
# management, cultural-loyalty scoring, commitment scoring of workers, retention-
# risk scoring of individual workers, productivity-ranking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "satisfaction_commitment_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

attitude_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- attitude_data %>%
  mutate(
    job_satisfaction_score = pmin(
      pmax(
        0.16 * leadership_support +
          0.15 * reward_fairness +
          0.13 * developmental_opportunity +
          0.14 * workload_balance +
          0.13 * institutional_trust +
          0.10 * cultural_alignment -
          0.09 * role_insecurity -
          0.10 * exhaustion_pressure,
        0
      ),
      100
    ),
    organizational_commitment_score = pmin(
      pmax(
        0.18 * affective_commitment +
          0.12 * normative_commitment +
          0.13 * institutional_trust +
          0.11 * cultural_alignment +
          0.10 * leadership_support +
          0.08 * developmental_opportunity -
          0.08 * role_insecurity -
          0.08 * exhaustion_pressure -
          0.04 * continuance_commitment,
        0
      ),
      100
    ),
    healthy_attachment_score = pmin(
      pmax(
        0.25 * job_satisfaction_score +
          0.30 * organizational_commitment_score +
          0.18 * institutional_trust +
          0.12 * workload_balance +
          0.15 * developmental_opportunity,
        0
      ),
      100
    ),
    retention_system_risk_score = pmin(
      pmax(
        0.13 * (100 - job_satisfaction_score) +
          0.14 * (100 - organizational_commitment_score) +
          0.11 * (100 - institutional_trust) +
          0.10 * (100 - reward_fairness) +
          0.10 * (100 - workload_balance) +
          0.12 * role_insecurity +
          0.14 * exhaustion_pressure +
          0.08 * continuance_commitment +
          0.08 * symbolic_commitment_risk * 100,
        0
      ),
      100
    ),
    work_attitude_review_priority = case_when(
      retention_system_risk_score >= 70 |
        healthy_attachment_score < 45 |
        high_retention_risk == 1 |
        symbolic_commitment_risk == 1 ~ "Immediate Review",
      retention_system_risk_score >= 50 |
        healthy_attachment_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_satisfaction_commitment_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_job_satisfaction = mean(job_satisfaction_score),
    avg_organizational_commitment = mean(organizational_commitment_score),
    avg_healthy_attachment = mean(healthy_attachment_score),
    avg_retention_system_risk = mean(retention_system_risk_score),
    avg_leadership_support = mean(leadership_support),
    avg_reward_fairness = mean(reward_fairness),
    avg_developmental_opportunity = mean(developmental_opportunity),
    avg_workload_balance = mean(workload_balance),
    avg_institutional_trust = mean(institutional_trust),
    avg_cultural_alignment = mean(cultural_alignment),
    avg_role_insecurity = mean(role_insecurity),
    avg_exhaustion_pressure = mean(exhaustion_pressure),
    avg_affective_commitment = mean(affective_commitment),
    avg_continuance_commitment = mean(continuance_commitment),
    avg_normative_commitment = mean(normative_commitment),
    high_retention_risk_rate = mean(high_retention_risk),
    symbolic_commitment_risk_rate = mean(symbolic_commitment_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_retention_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_satisfaction_commitment_summary.csv"))

retention_model <- glm(
  high_retention_risk ~ leadership_support + reward_fairness +
    developmental_opportunity + workload_balance + institutional_trust +
    cultural_alignment + role_insecurity + exhaustion_pressure +
    affective_commitment + continuance_commitment + normative_commitment,
  family = binomial(),
  data = scored
)

capture.output(
  summary(retention_model),
  file = file.path(table_dir, "r_high_retention_risk_model_summary.txt")
)

commitment_model <- lm(
  organizational_commitment_score ~ job_satisfaction_score +
    institutional_trust + cultural_alignment + leadership_support +
    role_insecurity + exhaustion_pressure,
  data = scored
)

capture.output(
  summary(commitment_model),
  file = file.path(table_dir, "r_commitment_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_retention_system_risk), y = avg_retention_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Satisfaction and Commitment Risk by Unit",
    x = "Synthetic unit",
    y = "Average retention-system risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_satisfaction_commitment_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

commitment_plot <- ggplot(
  scored,
  aes(x = job_satisfaction_score, y = organizational_commitment_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Job Satisfaction and Organizational Commitment",
    x = "Job satisfaction score",
    y = "Organizational commitment score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_job_satisfaction_organizational_commitment.png"),
  plot = commitment_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic satisfaction and commitment workflow only.")

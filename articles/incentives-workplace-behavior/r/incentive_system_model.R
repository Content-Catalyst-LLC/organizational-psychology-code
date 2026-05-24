# Incentives and Workplace Behavior
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, incentive-system review, reward-governance education,
# fairness and metric-distortion analysis, ethical-risk review, cooperation and
# culture review, and reproducible workflows. It is not an employee-screening,
# hiring, promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, productivity-ranking, incentive-compliance
# scoring, cultural-loyalty scoring, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "incentive_system_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

incentive_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- incentive_data %>%
  mutate(
    incentive_effectiveness_score = pmin(
      pmax(
        0.12 * expectancy_strength +
          0.13 * fairness_perception +
          0.12 * strategic_alignment +
          0.10 * intrinsic_support +
          0.11 * feedback_clarity +
          0.10 * cooperation_support +
          0.10 * recognition_legitimacy +
          0.09 * reward_transparency +
          0.08 * hidden_labor_recognition -
          0.08 * distortion_risk -
          0.07 * overload_pressure -
          0.08 * ethical_risk,
        0
      ),
      100
    ),
    incentive_system_risk_score = pmin(
      pmax(
        0.10 * (100 - expectancy_strength) +
          0.13 * (100 - fairness_perception) +
          0.11 * (100 - strategic_alignment) +
          0.09 * (100 - intrinsic_support) +
          0.10 * (100 - feedback_clarity) +
          0.09 * (100 - cooperation_support) +
          0.08 * (100 - recognition_legitimacy) +
          0.08 * (100 - reward_transparency) +
          0.07 * (100 - hidden_labor_recognition) +
          0.10 * distortion_risk +
          0.08 * overload_pressure +
          0.07 * ethical_risk,
        0
      ),
      100
    ),
    reward_governance_risk_score = pmin(
      pmax(
        0.25 * distortion_risk +
          0.22 * ethical_risk +
          0.18 * overload_pressure +
          0.14 * (100 - reward_transparency) +
          0.12 * (100 - fairness_perception) +
          0.09 * incentive_gaming_risk * 100,
        0
      ),
      100
    ),
    incentive_review_priority = case_when(
      incentive_system_risk_score >= 70 |
        incentive_effectiveness_score < 45 |
        performance_risk == 1 |
        symbolic_reward_risk == 1 ~ "Immediate Review",
      incentive_system_risk_score >= 50 |
        incentive_effectiveness_score < 60 |
        reward_governance_risk_score >= 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_incentive_system_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_incentive_effectiveness = mean(incentive_effectiveness_score),
    avg_incentive_system_risk = mean(incentive_system_risk_score),
    avg_reward_governance_risk = mean(reward_governance_risk_score),
    avg_expectancy_strength = mean(expectancy_strength),
    avg_fairness_perception = mean(fairness_perception),
    avg_strategic_alignment = mean(strategic_alignment),
    avg_intrinsic_support = mean(intrinsic_support),
    avg_feedback_clarity = mean(feedback_clarity),
    avg_distortion_risk = mean(distortion_risk),
    avg_overload_pressure = mean(overload_pressure),
    avg_ethical_risk = mean(ethical_risk),
    avg_cooperation_support = mean(cooperation_support),
    avg_recognition_legitimacy = mean(recognition_legitimacy),
    avg_reward_transparency = mean(reward_transparency),
    avg_hidden_labor_recognition = mean(hidden_labor_recognition),
    performance_risk_rate = mean(performance_risk),
    incentive_gaming_risk_rate = mean(incentive_gaming_risk),
    symbolic_reward_risk_rate = mean(symbolic_reward_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_incentive_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_incentive_system_summary.csv"))

performance_risk_model <- glm(
  performance_risk ~ expectancy_strength + fairness_perception +
    strategic_alignment + intrinsic_support + feedback_clarity +
    distortion_risk + overload_pressure + ethical_risk +
    cooperation_support + recognition_legitimacy + reward_transparency +
    hidden_labor_recognition,
  family = binomial(),
  data = scored
)

capture.output(
  summary(performance_risk_model),
  file = file.path(table_dir, "r_performance_risk_model_summary.txt")
)

effectiveness_model <- lm(
  incentive_effectiveness_score ~ expectancy_strength + fairness_perception +
    strategic_alignment + intrinsic_support + feedback_clarity +
    cooperation_support + recognition_legitimacy + reward_transparency +
    hidden_labor_recognition + distortion_risk + overload_pressure + ethical_risk,
  data = scored
)

capture.output(
  summary(effectiveness_model),
  file = file.path(table_dir, "r_incentive_effectiveness_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_incentive_system_risk), y = avg_incentive_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Incentive-System Risk by Unit",
    x = "Synthetic unit",
    y = "Average incentive-system risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_incentive_system_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

fairness_plot <- ggplot(
  scored,
  aes(x = fairness_perception, y = incentive_effectiveness_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Fairness Perception and Incentive Effectiveness",
    x = "Fairness perception",
    y = "Incentive effectiveness score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_fairness_incentive_effectiveness.png"),
  plot = fairness_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic incentive-system workflow only.")

# Information Flow and Organizational Communication
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, organizational communication review, knowledge-flow
# governance, and reproducible workflows. It is not an employee-screening,
# hiring, promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, communication-surveillance, productivity-
# ranking, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "information_flow_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

info_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- info_data %>%
  mutate(
    information_flow_quality_score = pmin(
      pmax(
        0.18 * signal_quality +
          0.15 * timeliness +
          0.15 * interpretive_clarity +
          0.14 * cross_functional_connectivity +
          0.13 * psychological_safety -
          0.10 * distortion_risk -
          0.08 * overload_pressure -
          0.10 * hierarchy_delay -
          0.05 * external_signal_turbulence,
        0
      ),
      100
    ),
    communication_risk_score = pmin(
      pmax(
        0.16 * (100 - signal_quality) +
          0.13 * (100 - timeliness) +
          0.12 * (100 - interpretive_clarity) +
          0.11 * (100 - cross_functional_connectivity) +
          0.12 * (100 - psychological_safety) +
          0.13 * distortion_risk +
          0.10 * overload_pressure +
          0.09 * hierarchy_delay +
          0.04 * external_signal_turbulence,
        0
      ),
      100
    ),
    communication_review_priority = case_when(
      communication_risk_score >= 70 |
        information_flow_quality_score < 45 |
        escalation_failure == 1 ~ "Immediate Review",
      communication_risk_score >= 50 |
        information_flow_quality_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_information_flow_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_information_flow_quality = mean(information_flow_quality_score),
    avg_communication_risk = mean(communication_risk_score),
    avg_signal_quality = mean(signal_quality),
    avg_timeliness = mean(timeliness),
    avg_interpretive_clarity = mean(interpretive_clarity),
    avg_cross_functional_connectivity = mean(cross_functional_connectivity),
    avg_psychological_safety = mean(psychological_safety),
    avg_distortion_risk = mean(distortion_risk),
    avg_overload_pressure = mean(overload_pressure),
    avg_hierarchy_delay = mean(hierarchy_delay),
    decision_error_rate = mean(decision_error),
    escalation_failure_rate = mean(escalation_failure),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_communication_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_information_flow_summary.csv"))

decision_error_model <- glm(
  decision_error ~ signal_quality + timeliness + interpretive_clarity +
    cross_functional_connectivity + psychological_safety + distortion_risk +
    overload_pressure + hierarchy_delay + external_signal_turbulence,
  family = binomial(),
  data = scored
)

capture.output(
  summary(decision_error_model),
  file = file.path(table_dir, "r_decision_error_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_communication_risk), y = avg_communication_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Communication Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average communication risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_communication_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

connectivity_plot <- ggplot(
  scored,
  aes(x = cross_functional_connectivity, y = information_flow_quality_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Cross-Functional Connectivity and Information Flow Quality",
    x = "Cross-functional connectivity",
    y = "Information flow quality score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_connectivity_information_flow_quality.png"),
  plot = connectivity_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic organizational communication workflow only.")

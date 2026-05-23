# Learning Organizations and Knowledge Systems
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, organizational knowledge governance, and reproducible
# workflows. It is not an employee-screening, hiring, promotion, compensation,
# discipline, termination, workplace surveillance, individual performance-
# management, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "organizational_learning_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

learning_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- learning_data %>%
  mutate(
    learning_capacity_score = pmin(
      pmax(
        0.17 * information_quality +
          0.18 * interpretive_openness +
          0.15 * memory_retention +
          0.15 * communication_flow +
          0.13 * psychological_safety +
          0.10 * governance_support -
          0.07 * complexity_load -
          0.10 * silo_intensity -
          0.10 * incentive_distortion -
          0.05 * turnover_pressure,
        0
      ),
      100
    ),
    knowledge_decay_risk_score = pmin(
      pmax(
        0.28 * (100 - memory_retention) +
          0.18 * turnover_pressure +
          0.16 * silo_intensity +
          0.12 * (100 - communication_flow) +
          0.10 * (100 - governance_support) +
          0.10 * incentive_distortion +
          0.06 * complexity_load,
        0
      ),
      100
    ),
    learning_review_priority = case_when(
      knowledge_decay_risk_score >= 65 |
        learning_capacity_score < 45 |
        knowledge_decay_event == 1 ~ "Immediate Review",
      knowledge_decay_risk_score >= 45 |
        learning_capacity_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_learning_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_learning_capacity = mean(learning_capacity_score),
    avg_knowledge_decay_risk = mean(knowledge_decay_risk_score),
    avg_interpretive_openness = mean(interpretive_openness),
    avg_memory_retention = mean(memory_retention),
    avg_communication_flow = mean(communication_flow),
    avg_psychological_safety = mean(psychological_safety),
    avg_silo_intensity = mean(silo_intensity),
    avg_incentive_distortion = mean(incentive_distortion),
    adaptive_improvement_rate = mean(adaptive_improvement),
    knowledge_decay_event_rate = mean(knowledge_decay_event),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_knowledge_decay_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_learning_summary.csv"))

adaptation_model <- glm(
  adaptive_improvement ~ information_quality + interpretive_openness +
    memory_retention + communication_flow + psychological_safety +
    governance_support + complexity_load + silo_intensity +
    incentive_distortion + turnover_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(adaptation_model),
  file = file.path(table_dir, "r_adaptive_improvement_model_summary.txt")
)

priority_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_knowledge_decay_risk), y = avg_knowledge_decay_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Knowledge Decay Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average knowledge decay risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_knowledge_decay_risk_by_unit.png"),
  plot = priority_plot,
  width = 8,
  height = 5,
  dpi = 160
)

learning_plot <- ggplot(
  scored,
  aes(x = interpretive_openness, y = learning_capacity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Interpretive Openness and Learning Capacity",
    x = "Interpretive openness",
    y = "Learning capacity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_interpretive_openness_learning_capacity.png"),
  plot = learning_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic institutional learning workflow only.")

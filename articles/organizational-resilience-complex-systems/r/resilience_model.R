# Organizational Resilience in Complex Systems
# Synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, and reproducible workflows. It is not an
# employee-screening, hiring, promotion, compensation, discipline,
# termination, workplace surveillance, individual performance-management,
# or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "organizational_resilience_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

resilience_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- resilience_data %>%
  mutate(
    resilience_capacity_score = pmin(
      pmax(
        0.18 * robustness +
          0.12 * redundancy +
          0.16 * adaptive_learning +
          0.14 * coordination_integrity +
          0.12 * governance_responsiveness +
          0.13 * psychological_safety -
          0.08 * external_exposure -
          0.07 * complexity_load -
          0.10 * accumulated_fragility,
        0
      ),
      100
    ),
    institutional_risk_score = pmin(
      pmax(
        0.20 * (100 - robustness) +
          0.12 * (100 - redundancy) +
          0.16 * (100 - adaptive_learning) +
          0.12 * (100 - coordination_integrity) +
          0.10 * (100 - governance_responsiveness) +
          0.10 * (100 - psychological_safety) +
          0.08 * external_exposure +
          0.06 * complexity_load +
          0.06 * accumulated_fragility,
        0
      ),
      100
    ),
    review_priority = case_when(
      institutional_risk_score >= 65 | major_functional_degradation == 1 ~ "Immediate Review",
      institutional_risk_score >= 45 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_resilience_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_resilience_capacity = mean(resilience_capacity_score),
    avg_institutional_risk = mean(institutional_risk_score),
    avg_psychological_safety = mean(psychological_safety),
    avg_adaptive_learning = mean(adaptive_learning),
    avg_accumulated_fragility = mean(accumulated_fragility),
    recovery_rate = mean(successful_recovery),
    degradation_rate = mean(major_functional_degradation),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_institutional_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_resilience_summary.csv"))

recovery_model <- glm(
  successful_recovery ~ robustness + redundancy + adaptive_learning +
    coordination_integrity + governance_responsiveness + psychological_safety +
    external_exposure + complexity_load + accumulated_fragility + shock_intensity,
  family = binomial(),
  data = scored
)

capture.output(
  summary(recovery_model),
  file = file.path(table_dir, "r_recovery_model_summary.txt")
)

priority_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_institutional_risk), y = avg_institutional_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Organizational Resilience Review Priority",
    x = "Synthetic unit",
    y = "Average institutional risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_resilience_review_priority.png"),
  plot = priority_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic institutional learning workflow only.")

# Strategic Decision-Making in Complex Organizations
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, strategic governance, decision-process review,
# and reproducible workflows. It is not an employee-screening, hiring,
# promotion, compensation, discipline, termination, workplace surveillance,
# individual performance-management, executive-ranking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "strategic_decision_quality_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

strategy_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- strategy_data %>%
  mutate(
    strategic_decision_quality_score = pmin(
      pmax(
        0.17 * sensing_quality +
          0.16 * interpretive_coherence +
          0.16 * knowledge_integration +
          0.12 * option_diversity +
          0.13 * governance_quality +
          0.14 * adaptive_learning -
          0.12 * bias_pressure -
          0.10 * political_distortion -
          0.09 * complexity_load -
          0.08 * environmental_turbulence,
        0
      ),
      100
    ),
    strategic_risk_score = pmin(
      pmax(
        0.15 * (100 - sensing_quality) +
          0.13 * (100 - interpretive_coherence) +
          0.14 * (100 - knowledge_integration) +
          0.08 * (100 - option_diversity) +
          0.12 * (100 - governance_quality) +
          0.12 * (100 - adaptive_learning) +
          0.10 * bias_pressure +
          0.08 * political_distortion +
          0.04 * complexity_load +
          0.04 * environmental_turbulence,
        0
      ),
      100
    ),
    strategic_review_priority = case_when(
      strategic_risk_score >= 70 |
        strategic_decision_quality_score < 45 |
        symbolic_strategy == 1 ~ "Immediate Review",
      strategic_risk_score >= 50 |
        strategic_decision_quality_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_strategic_decision_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_strategic_decision_quality = mean(strategic_decision_quality_score),
    avg_strategic_risk = mean(strategic_risk_score),
    avg_sensing_quality = mean(sensing_quality),
    avg_knowledge_integration = mean(knowledge_integration),
    avg_governance_quality = mean(governance_quality),
    avg_adaptive_learning = mean(adaptive_learning),
    avg_bias_pressure = mean(bias_pressure),
    avg_political_distortion = mean(political_distortion),
    strategic_success_rate = mean(strategic_success),
    symbolic_strategy_rate = mean(symbolic_strategy),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_strategic_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_strategic_decision_summary.csv"))

success_model <- glm(
  strategic_success ~ sensing_quality + interpretive_coherence +
    knowledge_integration + option_diversity + governance_quality +
    adaptive_learning + bias_pressure + political_distortion +
    complexity_load + environmental_turbulence,
  family = binomial(),
  data = scored
)

capture.output(
  summary(success_model),
  file = file.path(table_dir, "r_successful_strategy_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_strategic_risk), y = avg_strategic_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Strategic Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average strategic risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_strategic_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

integration_plot <- ggplot(
  scored,
  aes(x = knowledge_integration, y = strategic_decision_quality_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Knowledge Integration and Strategic Decision Quality",
    x = "Knowledge integration",
    y = "Strategic decision quality score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_knowledge_integration_strategic_quality.png"),
  plot = integration_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic strategic governance workflow only.")

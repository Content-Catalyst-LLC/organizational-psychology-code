# Institutional Values and Behavioral Expectations
# Exceptional synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, values-governance review, organizational ethics
# education, legitimacy analysis, and reproducible workflows. It is not an
# employee-screening, hiring, promotion, compensation, discipline, termination,
# workplace surveillance, individual performance-management, cultural-loyalty
# scoring, morality scoring, values-alignment scoring of workers, productivity-
# ranking, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "institutional_values_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

values_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- values_data %>%
  mutate(
    value_practice_alignment_score = pmin(
      pmax(
        0.17 * value_clarity +
          0.16 * leadership_consistency +
          0.16 * reinforcement_alignment +
          0.14 * psychological_safety +
          0.14 * accountability_strength -
          0.10 * decoupling_risk -
          0.09 * incentive_contradiction -
          0.09 * hierarchy_exemption -
          0.05 * legitimacy_pressure,
        0
      ),
      100
    ),
    institutional_values_risk_score = pmin(
      pmax(
        0.12 * (100 - value_clarity) +
          0.14 * (100 - leadership_consistency) +
          0.14 * (100 - reinforcement_alignment) +
          0.10 * (100 - psychological_safety) +
          0.14 * (100 - accountability_strength) +
          0.14 * decoupling_risk +
          0.10 * incentive_contradiction +
          0.08 * hierarchy_exemption +
          0.04 * legitimacy_pressure,
        0
      ),
      100
    ),
    values_governance_review_priority = case_when(
      institutional_values_risk_score >= 70 |
        value_practice_alignment_score < 45 |
        symbolic_values_risk == 1 ~ "Immediate Review",
      institutional_values_risk_score >= 50 |
        value_practice_alignment_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_institutional_values_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_value_practice_alignment = mean(value_practice_alignment_score),
    avg_institutional_values_risk = mean(institutional_values_risk_score),
    avg_value_clarity = mean(value_clarity),
    avg_leadership_consistency = mean(leadership_consistency),
    avg_reinforcement_alignment = mean(reinforcement_alignment),
    avg_psychological_safety = mean(psychological_safety),
    avg_accountability_strength = mean(accountability_strength),
    avg_decoupling_risk = mean(decoupling_risk),
    avg_incentive_contradiction = mean(incentive_contradiction),
    avg_hierarchy_exemption = mean(hierarchy_exemption),
    avg_legitimacy_pressure = mean(legitimacy_pressure),
    values_credibility_rate = mean(values_credible),
    symbolic_values_risk_rate = mean(symbolic_values_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_institutional_values_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_institutional_values_summary.csv"))

credibility_model <- glm(
  values_credible ~ value_clarity + leadership_consistency +
    reinforcement_alignment + psychological_safety + accountability_strength +
    decoupling_risk + incentive_contradiction + hierarchy_exemption +
    legitimacy_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(credibility_model),
  file = file.path(table_dir, "r_values_credibility_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_institutional_values_risk), y = avg_institutional_values_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Institutional Values Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average institutional values risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_institutional_values_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

alignment_plot <- ggplot(
  scored,
  aes(x = reinforcement_alignment, y = value_practice_alignment_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Reinforcement Alignment and Value-Practice Alignment",
    x = "Reinforcement alignment",
    y = "Value-practice alignment score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_reinforcement_alignment_value_practice_alignment.png"),
  plot = alignment_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic institutional values workflow only.")

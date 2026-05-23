# Resistance to Organizational Change
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, organizational change governance, and reproducible
# workflows. It is not an employee-screening, hiring, promotion, compensation,
# discipline, termination, workplace surveillance, individual performance-
# management, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "change_resistance_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

change_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- change_data %>%
  mutate(
    resistance_intensity_score = pmin(
      pmax(
        0.17 * perceived_loss +
          0.16 * uncertainty +
          0.13 * identity_threat +
          0.13 * routine_embeddedness +
          0.10 * power_displacement +
          0.10 * workload_strain +
          6.0 * failed_change_history -
          0.12 * trust_in_leadership -
          0.08 * participation_quality -
          0.09 * implementation_clarity,
        0
      ),
      100
    ),
    change_friction_risk_score = pmin(
      pmax(
        0.18 * perceived_loss +
          0.16 * uncertainty +
          0.12 * identity_threat +
          0.13 * routine_embeddedness +
          0.09 * power_displacement +
          0.10 * workload_strain +
          0.10 * (100 - trust_in_leadership) +
          0.06 * (100 - participation_quality) +
          0.06 * (100 - implementation_clarity) +
          4.0 * failed_change_history,
        0
      ),
      100
    ),
    change_review_priority = case_when(
      change_friction_risk_score >= 70 |
        resistance_intensity_score >= 70 |
        symbolic_compliance == 1 ~ "Immediate Review",
      change_friction_risk_score >= 50 |
        resistance_intensity_score >= 55 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_change_resistance_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_resistance_intensity = mean(resistance_intensity_score),
    avg_change_friction_risk = mean(change_friction_risk_score),
    avg_trust = mean(trust_in_leadership),
    avg_participation = mean(participation_quality),
    avg_implementation_clarity = mean(implementation_clarity),
    avg_workload_strain = mean(workload_strain),
    avg_routine_embeddedness = mean(routine_embeddedness),
    constructive_adoption_rate = mean(constructive_adoption),
    symbolic_compliance_rate = mean(symbolic_compliance),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_change_friction_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_change_resistance_summary.csv"))

adoption_model <- glm(
  constructive_adoption ~ perceived_loss + uncertainty + identity_threat +
    routine_embeddedness + power_displacement + trust_in_leadership +
    participation_quality + implementation_clarity + workload_strain +
    failed_change_history,
  family = binomial(),
  data = scored
)

capture.output(
  summary(adoption_model),
  file = file.path(table_dir, "r_constructive_adoption_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_change_friction_risk), y = avg_change_friction_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Change-Friction Risk by Organizational Unit",
    x = "Synthetic unit",
    y = "Average change-friction risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_change_friction_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

trust_plot <- ggplot(
  scored,
  aes(x = trust_in_leadership, y = resistance_intensity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Trust in Leadership and Resistance Intensity",
    x = "Trust in leadership",
    y = "Resistance intensity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_trust_resistance_relationship.png"),
  plot = trust_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic institutional learning workflow only.")

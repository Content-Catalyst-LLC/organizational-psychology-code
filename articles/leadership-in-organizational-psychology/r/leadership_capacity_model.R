# Leadership in Organizational Psychology
# Advanced synthetic R workflow.
# Responsible-use scope: synthetic-data research, methods demonstration,
# institutional learning, and leadership-system review only. Not for employment
# decisions, surveillance, productivity ranking, loyalty scoring, dissent
# tracking, political-influence scoring, or psychological assessment.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "leadership_capacity_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

leadership_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- leadership_data %>%
  mutate(
    leadership_capacity_score = pmin(pmax(
      0.11 * trust_generation +
        0.11 * communication_clarity +
        0.10 * motivational_support +
        0.11 * legitimacy_quality +
        0.10 * adaptive_coordination +
        0.10 * psychological_safety +
        0.08 * role_clarity +
        0.09 * ethical_accountability +
        0.08 * decision_transparency +
        0.08 * voice_access -
        0.07 * ambiguity_pressure -
        0.08 * distrust_pressure -
        0.07 * fragmentation_pressure -
        0.06 * overload_pressure,
      0), 100),
    institutional_stability_score = pmin(pmax(
      0.22 * leadership_capacity_score +
        0.13 * legitimacy_quality +
        0.12 * trust_generation +
        0.11 * communication_clarity +
        0.10 * role_clarity +
        0.10 * adaptive_coordination +
        0.10 * ethical_accountability +
        0.07 * voice_access +
        0.05 * psychological_safety,
      0), 100),
    leadership_system_risk_score = pmin(pmax(
      0.10 * (100 - trust_generation) +
        0.09 * (100 - communication_clarity) +
        0.08 * (100 - motivational_support) +
        0.11 * (100 - legitimacy_quality) +
        0.08 * (100 - adaptive_coordination) +
        0.10 * (100 - psychological_safety) +
        0.07 * (100 - role_clarity) +
        0.09 * (100 - ethical_accountability) +
        0.07 * (100 - decision_transparency) +
        0.08 * (100 - voice_access) +
        0.08 * ambiguity_pressure +
        0.10 * distrust_pressure +
        0.09 * fragmentation_pressure +
        0.08 * overload_pressure,
      0), 100),
    leadership_review_priority = case_when(
      leadership_system_risk_score >= 70 |
        leadership_capacity_score < 45 |
        performance_risk == 1 |
        voice_suppression_risk == 1 |
        legitimacy_decay_risk == 1 |
        fragmentation_risk == 1 ~ "Immediate Review",
      leadership_system_risk_score >= 50 |
        leadership_capacity_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_leadership_capacity_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_leadership_capacity = mean(leadership_capacity_score),
    avg_institutional_stability = mean(institutional_stability_score),
    avg_leadership_system_risk = mean(leadership_system_risk_score),
    avg_trust_generation = mean(trust_generation),
    avg_communication_clarity = mean(communication_clarity),
    avg_legitimacy_quality = mean(legitimacy_quality),
    avg_psychological_safety = mean(psychological_safety),
    avg_fragmentation_pressure = mean(fragmentation_pressure),
    avg_overload_pressure = mean(overload_pressure),
    performance_risk_rate = mean(performance_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_leadership_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_leadership_capacity_summary.csv"))

performance_risk_model <- glm(
  performance_risk ~ trust_generation + communication_clarity +
    motivational_support + legitimacy_quality + adaptive_coordination +
    psychological_safety + role_clarity + ethical_accountability +
    decision_transparency + voice_access + ambiguity_pressure +
    distrust_pressure + fragmentation_pressure + overload_pressure,
  family = binomial(),
  data = scored
)

capture.output(summary(performance_risk_model), file = file.path(table_dir, "r_performance_risk_model_summary.txt"))

risk_plot <- ggplot(unit_summary, aes(x = reorder(unit_id, avg_leadership_system_risk), y = avg_leadership_system_risk)) +
  geom_col() +
  coord_flip() +
  labs(title = "Synthetic Leadership-System Risk by Unit", x = "Synthetic unit", y = "Average leadership-system risk score") +
  theme_minimal()

ggsave(file.path(figure_dir, "r_leadership_system_risk_by_unit.png"), risk_plot, width = 8, height = 5, dpi = 160)

trust_plot <- ggplot(scored, aes(x = trust_generation, y = leadership_capacity_score)) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(title = "Trust Generation and Leadership Capacity", x = "Trust generation", y = "Leadership capacity score") +
  theme_minimal()

ggsave(file.path(figure_dir, "r_trust_leadership_capacity.png"), trust_plot, width = 8, height = 5, dpi = 160)

print(unit_summary)
message("Responsible-use reminder: synthetic leadership-capacity workflow only.")

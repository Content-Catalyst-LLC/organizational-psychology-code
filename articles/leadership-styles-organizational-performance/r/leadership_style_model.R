# Leadership Styles and Organizational Performance
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, leadership-system review, communication/trust/style-fit
# analysis, psychological-safety and work-design education, and reproducible
# workflows. It is not an employee-screening, hiring, promotion, compensation,
# discipline, termination, workplace surveillance, individual performance-
# management, productivity-ranking, leadership-loyalty scoring, dissent tracking,
# or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "leadership_style_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

leadership_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- leadership_data %>%
  mutate(
    leadership_effectiveness_score = pmin(
      pmax(
        0.11 * participative_behavior +
          0.12 * structural_guidance +
          0.13 * communication_quality +
          0.13 * trust_generation +
          0.11 * developmental_support +
          0.12 * psychological_safety +
          0.11 * decision_fit +
          0.10 * cultural_alignment -
          0.08 * control_pressure -
          0.07 * ambiguity_risk -
          0.07 * disengagement_pressure,
        0
      ),
      100
    ),
    institutional_performance_capacity_score = pmin(
      pmax(
        0.20 * leadership_effectiveness_score +
          0.13 * communication_quality +
          0.13 * trust_generation +
          0.12 * structural_guidance +
          0.12 * decision_fit +
          0.11 * psychological_safety +
          0.09 * developmental_support +
          0.05 * participative_behavior +
          0.05 * cultural_alignment,
        0
      ),
      100
    ),
    leadership_system_risk_score = pmin(
      pmax(
        0.09 * (100 - participative_behavior) +
          0.10 * (100 - structural_guidance) +
          0.12 * (100 - communication_quality) +
          0.13 * (100 - trust_generation) +
          0.09 * (100 - developmental_support) +
          0.12 * (100 - psychological_safety) +
          0.10 * (100 - decision_fit) +
          0.08 * (100 - cultural_alignment) +
          0.11 * control_pressure +
          0.10 * ambiguity_risk +
          0.10 * disengagement_pressure,
        0
      ),
      100
    ),
    voice_and_style_misfit_risk_score = pmin(
      pmax(
        0.20 * control_pressure +
          0.18 * ambiguity_risk +
          0.18 * disengagement_pressure +
          0.14 * (100 - psychological_safety) +
          0.12 * (100 - decision_fit) +
          0.08 * voice_suppression_risk * 100 +
          0.05 * authoritarian_overuse_risk * 100 +
          0.05 * laissez_faire_absence_risk * 100,
        0
      ),
      100
    ),
    leadership_review_priority = case_when(
      leadership_system_risk_score >= 70 |
        leadership_effectiveness_score < 45 |
        performance_risk == 1 |
        voice_suppression_risk == 1 |
        style_misfit_risk == 1 ~ "Immediate Review",
      leadership_system_risk_score >= 50 |
        leadership_effectiveness_score < 60 |
        voice_and_style_misfit_risk_score >= 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_leadership_style_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_leadership_effectiveness = mean(leadership_effectiveness_score),
    avg_institutional_performance_capacity = mean(institutional_performance_capacity_score),
    avg_leadership_system_risk = mean(leadership_system_risk_score),
    avg_voice_and_style_misfit_risk = mean(voice_and_style_misfit_risk_score),
    avg_participative_behavior = mean(participative_behavior),
    avg_structural_guidance = mean(structural_guidance),
    avg_communication_quality = mean(communication_quality),
    avg_trust_generation = mean(trust_generation),
    avg_developmental_support = mean(developmental_support),
    avg_psychological_safety = mean(psychological_safety),
    avg_decision_fit = mean(decision_fit),
    avg_cultural_alignment = mean(cultural_alignment),
    avg_control_pressure = mean(control_pressure),
    avg_ambiguity_risk = mean(ambiguity_risk),
    avg_disengagement_pressure = mean(disengagement_pressure),
    performance_risk_rate = mean(performance_risk),
    voice_suppression_risk_rate = mean(voice_suppression_risk),
    style_misfit_risk_rate = mean(style_misfit_risk),
    authoritarian_overuse_risk_rate = mean(authoritarian_overuse_risk),
    laissez_faire_absence_risk_rate = mean(laissez_faire_absence_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_leadership_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_leadership_style_summary.csv"))

performance_risk_model <- glm(
  performance_risk ~ participative_behavior + structural_guidance +
    communication_quality + trust_generation + developmental_support +
    psychological_safety + decision_fit + cultural_alignment +
    control_pressure + ambiguity_risk + disengagement_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(performance_risk_model),
  file = file.path(table_dir, "r_performance_risk_model_summary.txt")
)

leadership_model <- lm(
  leadership_effectiveness_score ~ participative_behavior + structural_guidance +
    communication_quality + trust_generation + developmental_support +
    psychological_safety + decision_fit + cultural_alignment +
    control_pressure + ambiguity_risk + disengagement_pressure,
  data = scored
)

capture.output(
  summary(leadership_model),
  file = file.path(table_dir, "r_leadership_effectiveness_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_leadership_system_risk), y = avg_leadership_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Leadership-System Risk by Unit",
    x = "Synthetic unit",
    y = "Average leadership-system risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_leadership_system_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

trust_plot <- ggplot(
  scored,
  aes(x = trust_generation, y = leadership_effectiveness_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Trust Generation and Leadership Effectiveness",
    x = "Trust generation",
    y = "Leadership effectiveness score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_trust_leadership_effectiveness.png"),
  plot = trust_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic leadership-style workflow only.")

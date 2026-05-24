# Transformational Leadership and Organizational Change
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, transformational-leadership review, change-system
# analysis, vision/trust/support/fatigue diagnostics, psychological-safety and
# organizational-learning education, and reproducible workflows. It is not an
# employee-screening, hiring, promotion, compensation, discipline, termination,
# workplace surveillance, individual performance-management, productivity-ranking,
# leadership-loyalty scoring, dissent tracking, or psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "transformational_leadership_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

transform_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- transform_data %>%
  mutate(
    transformational_capacity_score = pmin(
      pmax(
        0.12 * vision_credibility +
          0.11 * motivational_alignment +
          0.11 * intellectual_stimulation +
          0.10 * developmental_support +
          0.12 * institutional_trust +
          0.11 * psychological_safety +
          0.10 * change_communication +
          0.09 * implementation_support +
          0.10 * meaning_making_quality -
          0.08 * resistance_intensity -
          0.07 * ambiguity_pressure -
          0.08 * change_fatigue,
        0
      ),
      100
    ),
    adaptive_change_capacity_score = pmin(
      pmax(
        0.20 * transformational_capacity_score +
          0.13 * vision_credibility +
          0.12 * intellectual_stimulation +
          0.12 * institutional_trust +
          0.12 * psychological_safety +
          0.10 * implementation_support +
          0.09 * developmental_support +
          0.07 * motivational_alignment +
          0.05 * meaning_making_quality,
        0
      ),
      100
    ),
    transformational_system_risk_score = pmin(
      pmax(
        0.11 * (100 - vision_credibility) +
          0.10 * (100 - motivational_alignment) +
          0.09 * (100 - intellectual_stimulation) +
          0.09 * (100 - developmental_support) +
          0.12 * (100 - institutional_trust) +
          0.11 * (100 - psychological_safety) +
          0.09 * (100 - change_communication) +
          0.09 * (100 - implementation_support) +
          0.09 * (100 - meaning_making_quality) +
          0.10 * resistance_intensity +
          0.10 * ambiguity_pressure +
          0.12 * change_fatigue,
        0
      ),
      100
    ),
    fatigue_voice_purpose_risk_score = pmin(
      pmax(
        0.22 * change_fatigue +
          0.18 * ambiguity_pressure +
          0.16 * resistance_intensity +
          0.14 * (100 - institutional_trust) +
          0.12 * (100 - psychological_safety) +
          0.08 * voice_suppression_risk * 100 +
          0.05 * purpose_exploitation_risk * 100 +
          0.05 * style_misfit_risk * 100,
        0
      ),
      100
    ),
    transformational_review_priority = case_when(
      transformational_system_risk_score >= 70 |
        transformational_capacity_score < 45 |
        adaptive_performance_risk == 1 |
        voice_suppression_risk == 1 |
        purpose_exploitation_risk == 1 ~ "Immediate Review",
      transformational_system_risk_score >= 50 |
        transformational_capacity_score < 60 |
        fatigue_voice_purpose_risk_score >= 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_transformational_leadership_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_transformational_capacity = mean(transformational_capacity_score),
    avg_adaptive_change_capacity = mean(adaptive_change_capacity_score),
    avg_transformational_system_risk = mean(transformational_system_risk_score),
    avg_fatigue_voice_purpose_risk = mean(fatigue_voice_purpose_risk_score),
    avg_vision_credibility = mean(vision_credibility),
    avg_motivational_alignment = mean(motivational_alignment),
    avg_intellectual_stimulation = mean(intellectual_stimulation),
    avg_developmental_support = mean(developmental_support),
    avg_institutional_trust = mean(institutional_trust),
    avg_psychological_safety = mean(psychological_safety),
    avg_change_communication = mean(change_communication),
    avg_implementation_support = mean(implementation_support),
    avg_meaning_making_quality = mean(meaning_making_quality),
    avg_resistance_intensity = mean(resistance_intensity),
    avg_ambiguity_pressure = mean(ambiguity_pressure),
    avg_change_fatigue = mean(change_fatigue),
    voice_suppression_risk_rate = mean(voice_suppression_risk),
    adaptive_performance_risk_rate = mean(adaptive_performance_risk),
    style_misfit_risk_rate = mean(style_misfit_risk),
    purpose_exploitation_risk_rate = mean(purpose_exploitation_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_transformational_system_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_transformational_leadership_summary.csv"))

adaptive_risk_model <- glm(
  adaptive_performance_risk ~ vision_credibility + motivational_alignment +
    intellectual_stimulation + developmental_support + institutional_trust +
    psychological_safety + change_communication + implementation_support +
    meaning_making_quality + resistance_intensity + ambiguity_pressure +
    change_fatigue,
  family = binomial(),
  data = scored
)

capture.output(
  summary(adaptive_risk_model),
  file = file.path(table_dir, "r_adaptive_performance_risk_model_summary.txt")
)

capacity_model <- lm(
  transformational_capacity_score ~ vision_credibility + motivational_alignment +
    intellectual_stimulation + developmental_support + institutional_trust +
    psychological_safety + change_communication + implementation_support +
    meaning_making_quality + resistance_intensity + ambiguity_pressure +
    change_fatigue,
  data = scored
)

capture.output(
  summary(capacity_model),
  file = file.path(table_dir, "r_transformational_capacity_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_transformational_system_risk), y = avg_transformational_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Transformational Leadership-System Risk by Unit",
    x = "Synthetic unit",
    y = "Average transformational system risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_transformational_system_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

vision_plot <- ggplot(
  scored,
  aes(x = vision_credibility, y = transformational_capacity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Vision Credibility and Transformational Capacity",
    x = "Vision credibility",
    y = "Transformational capacity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_vision_transformational_capacity.png"),
  plot = vision_plot,
  width = 8,
  height = 5,
  dpi = 160
)

fatigue_plot <- ggplot(
  scored,
  aes(x = change_fatigue, y = transformational_capacity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Change Fatigue and Transformational Capacity",
    x = "Change fatigue",
    y = "Transformational capacity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_change_fatigue_transformational_capacity.png"),
  plot = fatigue_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic transformational-leadership workflow only.")

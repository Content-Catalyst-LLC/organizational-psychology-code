# Organizational decision-making scaffold
# Synthetic data only. Not for employee screening, hiring, promotion,
# discipline, surveillance, or individual performance management.

suppressPackageStartupMessages({
  library(tidyverse)
  library(lme4)
  library(lmerTest)
  library(broom.mixed)
})

base_dir <- dirname(dirname(normalizePath(sys.frame(1)$ofile)))
raw_dir <- file.path(base_dir, "data", "raw")
out_dir <- file.path(base_dir, "outputs", "tables")
dir.create(out_dir, recursive = TRUE, showWarnings = FALSE)

df <- read_csv(file.path(raw_dir, "organizational_decision_panel.csv"), show_col_types = FALSE)

scored <- df |>
  mutate(
    team_id = as.factor(team_id),
    decision_domain = as.factor(decision_domain),
    information_quality_c = as.numeric(scale(information_quality, center = TRUE, scale = FALSE)),
    psychological_safety_c = as.numeric(scale(psychological_safety, center = TRUE, scale = FALSE)),
    incentive_alignment_c = as.numeric(scale(incentive_alignment, center = TRUE, scale = FALSE)),
    interpretive_diversity_c = as.numeric(scale(interpretive_diversity, center = TRUE, scale = FALSE)),
    coordination_load_c = as.numeric(scale(coordination_load, center = TRUE, scale = FALSE)),
    time_pressure_c = as.numeric(scale(time_pressure, center = TRUE, scale = FALSE)),
    bias_pressure_c = as.numeric(scale(bias_pressure, center = TRUE, scale = FALSE)),
    leadership_fragmentation_c = as.numeric(scale(leadership_fragmentation, center = TRUE, scale = FALSE)),
    metric_distortion_c = as.numeric(scale(metric_distortion, center = TRUE, scale = FALSE)),
    institutional_decision_risk =
      (100 - information_quality) * 0.20 +
      (100 - psychological_safety) * 0.18 +
      (100 - incentive_alignment) * 0.14 +
      coordination_load * 0.12 +
      time_pressure * 0.10 +
      bias_pressure * 0.12 +
      leadership_fragmentation * 0.07 +
      metric_distortion * 0.07 +
      implementation_error_rate * 100 * 0.10
  )

quality_model <- lmer(
  decision_quality_score ~
    information_quality_c +
    psychological_safety_c +
    incentive_alignment_c +
    interpretive_diversity_c +
    coordination_load_c +
    time_pressure_c +
    bias_pressure_c +
    leadership_fragmentation_c +
    metric_distortion_c +
    cross_functional_scope +
    decision_domain +
    (1 | team_id),
  data = scored,
  REML = FALSE
)

error_model <- glm(
  major_error_event ~
    decision_quality_score +
    psychological_safety +
    coordination_load +
    time_pressure +
    bias_pressure +
    metric_distortion,
  family = binomial(),
  data = scored
)

team_summary <- scored |>
  group_by(team_id) |>
  summarise(
    avg_decision_quality = mean(decision_quality_score),
    avg_psychological_safety = mean(psychological_safety),
    avg_bias_pressure = mean(bias_pressure),
    major_error_rate = mean(major_error_event),
    avg_institutional_decision_risk = mean(institutional_decision_risk),
    .groups = "drop"
  ) |>
  arrange(desc(avg_institutional_decision_risk))

write_csv(scored, file.path(out_dir, "r_scored_organizational_decisions.csv"))
write_csv(tidy(quality_model, effects = "fixed", conf.int = TRUE), file.path(out_dir, "r_decision_quality_fixed_effects.csv"))
write_csv(broom::tidy(error_model, conf.int = TRUE, exponentiate = TRUE), file.path(out_dir, "r_major_error_event_odds_ratios.csv"))
write_csv(team_summary, file.path(out_dir, "r_team_decision_risk_summary.csv"))

message("R organizational decision-making workflow complete.")

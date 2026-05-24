# Authority and Power in Institutional Leadership
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, authority/governance-system review, legitimacy and
# procedural-fairness analysis, informal-power and information-flow review,
# ethical-leadership education, and reproducible workflows. It is not an
# employee-screening, hiring, promotion, compensation, discipline, termination,
# workplace surveillance, individual performance-management, productivity-ranking,
# loyalty scoring, political-influence scoring, dissent tracking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "authority_governance_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

authority_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- authority_data %>%
  mutate(
    authority_effectiveness_score = pmin(
      pmax(
        0.12 * formal_legitimacy +
          0.12 * procedural_fairness +
          0.10 * informational_access +
          0.10 * practical_influence +
          0.12 * ethical_credibility +
          0.11 * accountability_quality +
          0.10 * voice_access +
          0.09 * oversight_strength -
          0.08 * arbitrariness_risk -
          0.07 * governance_fragmentation -
          0.07 * distrust_pressure -
          0.05 * informal_power_concentration,
        0
      ),
      100
    ),
    governance_risk_score = pmin(
      pmax(
        0.11 * (100 - formal_legitimacy) +
          0.12 * (100 - procedural_fairness) +
          0.08 * (100 - informational_access) +
          0.08 * (100 - practical_influence) +
          0.12 * (100 - ethical_credibility) +
          0.11 * (100 - accountability_quality) +
          0.09 * (100 - voice_access) +
          0.08 * (100 - oversight_strength) +
          0.10 * arbitrariness_risk +
          0.09 * governance_fragmentation +
          0.09 * distrust_pressure +
          0.08 * informal_power_concentration,
        0
      ),
      100
    ),
    shadow_governance_risk_score = pmin(
      pmax(
        0.26 * informal_power_concentration +
          0.22 * governance_fragmentation +
          0.18 * arbitrariness_risk +
          0.14 * (100 - accountability_quality) +
          0.10 * (100 - oversight_strength) +
          0.10 * shadow_governance_risk * 100,
        0
      ),
      100
    ),
    legitimacy_decay_score = pmin(
      pmax(
        0.24 * distrust_pressure +
          0.19 * arbitrariness_risk +
          0.17 * (100 - procedural_fairness) +
          0.15 * (100 - ethical_credibility) +
          0.13 * (100 - voice_access) +
          0.12 * legitimacy_decay_risk * 100,
        0
      ),
      100
    ),
    authority_review_priority = case_when(
      governance_risk_score >= 70 |
        authority_effectiveness_score < 45 |
        governance_risk == 1 |
        shadow_governance_risk == 1 |
        legitimacy_decay_risk == 1 ~ "Immediate Review",
      governance_risk_score >= 50 |
        authority_effectiveness_score < 60 |
        shadow_governance_risk_score >= 60 |
        legitimacy_decay_score >= 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_authority_governance_observations.csv"))

unit_summary <- scored %>%
  group_by(unit_id) %>%
  summarise(
    observations = n(),
    avg_authority_effectiveness = mean(authority_effectiveness_score),
    avg_governance_risk = mean(governance_risk_score),
    avg_shadow_governance_risk = mean(shadow_governance_risk_score),
    avg_legitimacy_decay = mean(legitimacy_decay_score),
    avg_formal_legitimacy = mean(formal_legitimacy),
    avg_procedural_fairness = mean(procedural_fairness),
    avg_informational_access = mean(informational_access),
    avg_practical_influence = mean(practical_influence),
    avg_ethical_credibility = mean(ethical_credibility),
    avg_accountability_quality = mean(accountability_quality),
    avg_voice_access = mean(voice_access),
    avg_oversight_strength = mean(oversight_strength),
    avg_arbitrariness_risk = mean(arbitrariness_risk),
    avg_governance_fragmentation = mean(governance_fragmentation),
    avg_distrust_pressure = mean(distrust_pressure),
    avg_informal_power_concentration = mean(informal_power_concentration),
    governance_risk_rate = mean(governance_risk),
    shadow_governance_risk_rate = mean(shadow_governance_risk),
    legitimacy_decay_risk_rate = mean(legitimacy_decay_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_governance_risk))

write_csv(unit_summary, file.path(table_dir, "r_unit_authority_governance_summary.csv"))

governance_risk_model <- glm(
  governance_risk ~ formal_legitimacy + procedural_fairness +
    informational_access + practical_influence + ethical_credibility +
    accountability_quality + voice_access + oversight_strength +
    arbitrariness_risk + governance_fragmentation + distrust_pressure +
    informal_power_concentration,
  family = binomial(),
  data = scored
)

capture.output(
  summary(governance_risk_model),
  file = file.path(table_dir, "r_governance_risk_model_summary.txt")
)

authority_model <- lm(
  authority_effectiveness_score ~ formal_legitimacy + procedural_fairness +
    informational_access + practical_influence + ethical_credibility +
    accountability_quality + voice_access + oversight_strength +
    arbitrariness_risk + governance_fragmentation + distrust_pressure +
    informal_power_concentration,
  data = scored
)

capture.output(
  summary(authority_model),
  file = file.path(table_dir, "r_authority_effectiveness_model_summary.txt")
)

risk_plot <- ggplot(
  unit_summary,
  aes(x = reorder(unit_id, avg_governance_risk), y = avg_governance_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Authority/Governance Risk by Unit",
    x = "Synthetic unit",
    y = "Average governance risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_authority_governance_risk_by_unit.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

fairness_plot <- ggplot(
  scored,
  aes(x = procedural_fairness, y = authority_effectiveness_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Procedural Fairness and Authority Effectiveness",
    x = "Procedural fairness",
    y = "Authority effectiveness score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_procedural_fairness_authority_effectiveness.png"),
  plot = fairness_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(unit_summary)
message("Responsible-use reminder: synthetic authority/governance workflow only.")

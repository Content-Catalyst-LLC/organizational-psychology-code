# Trust and Cooperation in Workplace Teams
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, trust-and-cooperation review, collaboration-system
# education, reciprocity analysis, leadership and governance review, and
# reproducible workflows. It is not an employee-screening, hiring, promotion,
# compensation, discipline, termination, workplace surveillance, individual
# performance-management, cultural-loyalty scoring, trustworthiness scoring,
# cooperation scoring of workers, productivity-ranking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "trust_cooperation_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

trust_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- trust_data %>%
  mutate(
    cooperative_capacity_score = pmin(
      pmax(
        0.13 * competence_trust +
          0.14 * integrity_trust +
          0.12 * benevolence_trust +
          0.13 * reciprocity_norms +
          0.12 * communication_reliability +
          0.11 * leadership_credibility +
          0.11 * institutional_trust -
          0.10 * opportunism_risk -
          0.08 * power_imbalance -
          0.05 * uncertainty_load,
        0
      ),
      100
    ),
    trust_risk_score = pmin(
      pmax(
        0.10 * (100 - competence_trust) +
          0.14 * (100 - integrity_trust) +
          0.10 * (100 - benevolence_trust) +
          0.12 * (100 - reciprocity_norms) +
          0.10 * (100 - communication_reliability) +
          0.10 * (100 - leadership_credibility) +
          0.12 * (100 - institutional_trust) +
          0.14 * opportunism_risk +
          0.10 * power_imbalance +
          0.08 * uncertainty_load,
        0
      ),
      100
    ),
    reciprocity_gap_score = pmin(
      pmax(
        0.35 * (100 - reciprocity_norms) +
          0.25 * power_imbalance +
          0.20 * opportunism_risk +
          0.20 * (100 - institutional_trust),
        0
      ),
      100
    ),
    trust_review_priority = case_when(
      trust_risk_score >= 70 |
        cooperative_capacity_score < 45 |
        symbolic_cooperation_risk == 1 ~ "Immediate Review",
      trust_risk_score >= 50 |
        cooperative_capacity_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_trust_cooperation_observations.csv"))

team_summary <- scored %>%
  group_by(team_id) %>%
  summarise(
    observations = n(),
    avg_cooperative_capacity = mean(cooperative_capacity_score),
    avg_trust_risk = mean(trust_risk_score),
    avg_reciprocity_gap = mean(reciprocity_gap_score),
    avg_competence_trust = mean(competence_trust),
    avg_integrity_trust = mean(integrity_trust),
    avg_benevolence_trust = mean(benevolence_trust),
    avg_reciprocity_norms = mean(reciprocity_norms),
    avg_communication_reliability = mean(communication_reliability),
    avg_opportunism_risk = mean(opportunism_risk),
    avg_power_imbalance = mean(power_imbalance),
    avg_uncertainty_load = mean(uncertainty_load),
    avg_leadership_credibility = mean(leadership_credibility),
    avg_institutional_trust = mean(institutional_trust),
    strong_collaboration_rate = mean(strong_collaboration),
    symbolic_cooperation_risk_rate = mean(symbolic_cooperation_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_trust_risk))

write_csv(team_summary, file.path(table_dir, "r_team_trust_cooperation_summary.csv"))

collaboration_model <- glm(
  strong_collaboration ~ competence_trust + integrity_trust +
    benevolence_trust + reciprocity_norms + communication_reliability +
    opportunism_risk + power_imbalance + uncertainty_load +
    leadership_credibility + institutional_trust,
  family = binomial(),
  data = scored
)

capture.output(
  summary(collaboration_model),
  file = file.path(table_dir, "r_strong_collaboration_model_summary.txt")
)

risk_plot <- ggplot(
  team_summary,
  aes(x = reorder(team_id, avg_trust_risk), y = avg_trust_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Trust and Cooperation Risk by Team",
    x = "Synthetic team",
    y = "Average trust risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_trust_cooperation_risk_by_team.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

integrity_plot <- ggplot(
  scored,
  aes(x = integrity_trust, y = cooperative_capacity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Integrity Trust and Cooperative Capacity",
    x = "Integrity trust",
    y = "Cooperative capacity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_integrity_trust_cooperative_capacity.png"),
  plot = integrity_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(team_summary)
message("Responsible-use reminder: synthetic trust and cooperation workflow only.")

# Conflict Resolution in Organizational Systems
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, conflict-system review, mediation-process education,
# procedural fairness analysis, leadership and dispute-system analysis, and
# reproducible workflows. It is not an employee-screening, hiring, promotion,
# compensation, discipline, termination, workplace surveillance, individual
# performance-management, cultural-loyalty scoring, conflict-proneness scoring,
# collaboration scoring of workers, productivity-ranking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "conflict_resolution_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

conflict_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- conflict_data %>%
  mutate(
    constructive_conflict_capacity_score = pmin(
      pmax(
        0.16 * trust_level +
          0.15 * communication_clarity +
          0.14 * psychological_safety +
          0.15 * procedural_fairness +
          0.12 * integrative_skill +
          0.10 * mediation_access -
          0.10 * blame_intensity -
          0.09 * power_asymmetry -
          0.07 * resource_strain,
        0
      ),
      100
    ),
    conflict_risk_score = pmin(
      pmax(
        0.13 * (100 - trust_level) +
          0.12 * (100 - communication_clarity) +
          0.11 * (100 - psychological_safety) +
          0.13 * (100 - procedural_fairness) +
          0.10 * (100 - integrative_skill) +
          0.10 * (100 - mediation_access) +
          0.14 * blame_intensity +
          0.13 * power_asymmetry +
          0.14 * resource_strain,
        0
      ),
      100
    ),
    escalation_pressure_score = pmin(
      pmax(
        0.28 * blame_intensity +
          0.25 * power_asymmetry +
          0.22 * resource_strain +
          0.15 * (100 - communication_clarity) +
          0.10 * (100 - procedural_fairness),
        0
      ),
      100
    ),
    conflict_review_priority = case_when(
      conflict_risk_score >= 70 |
        constructive_conflict_capacity_score < 45 |
        symbolic_resolution_risk == 1 ~ "Immediate Review",
      conflict_risk_score >= 50 |
        constructive_conflict_capacity_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_conflict_resolution_observations.csv"))

team_summary <- scored %>%
  group_by(team_id) %>%
  summarise(
    observations = n(),
    avg_constructive_conflict_capacity = mean(constructive_conflict_capacity_score),
    avg_conflict_risk = mean(conflict_risk_score),
    avg_escalation_pressure = mean(escalation_pressure_score),
    avg_trust = mean(trust_level),
    avg_communication_clarity = mean(communication_clarity),
    avg_psychological_safety = mean(psychological_safety),
    avg_procedural_fairness = mean(procedural_fairness),
    avg_integrative_skill = mean(integrative_skill),
    avg_blame_intensity = mean(blame_intensity),
    avg_power_asymmetry = mean(power_asymmetry),
    avg_resource_strain = mean(resource_strain),
    avg_mediation_access = mean(mediation_access),
    collaborative_resolution_rate = mean(collaborative_resolution),
    symbolic_resolution_risk_rate = mean(symbolic_resolution_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_conflict_risk))

write_csv(team_summary, file.path(table_dir, "r_team_conflict_resolution_summary.csv"))

resolution_model <- glm(
  collaborative_resolution ~ trust_level + communication_clarity +
    psychological_safety + procedural_fairness + integrative_skill +
    blame_intensity + power_asymmetry + resource_strain + mediation_access,
  family = binomial(),
  data = scored
)

capture.output(
  summary(resolution_model),
  file = file.path(table_dir, "r_collaborative_resolution_model_summary.txt")
)

risk_plot <- ggplot(
  team_summary,
  aes(x = reorder(team_id, avg_conflict_risk), y = avg_conflict_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Conflict Resolution Risk by Team",
    x = "Synthetic team",
    y = "Average conflict risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_conflict_resolution_risk_by_team.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

fairness_plot <- ggplot(
  scored,
  aes(x = procedural_fairness, y = constructive_conflict_capacity_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Procedural Fairness and Constructive Conflict Capacity",
    x = "Procedural fairness",
    y = "Constructive conflict capacity score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_procedural_fairness_constructive_conflict_capacity.png"),
  plot = fairness_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(team_summary)
message("Responsible-use reminder: synthetic conflict resolution workflow only.")

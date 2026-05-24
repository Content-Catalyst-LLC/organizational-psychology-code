# R Workflow: Describing Work-System Conditions and Organizational Outcomes
# Synthetic organizational psychology demonstration.
#
# Responsible-use scope:
# This workflow is for synthetic-data research, methods demonstration,
# institutional learning, and reproducible organizational psychology education.
# It is not an employee-screening, hiring, promotion, compensation, discipline,
# termination, workplace surveillance, individual performance-management,
# productivity-ranking, loyalty-scoring, dissent-tracking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "organizational_psychology_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

org_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- org_data %>%
  mutate(
    modeled_outcome_quality = pmin(
      pmax(
        0.11 * capability +
          0.10 * motivation +
          0.10 * role_clarity +
          0.07 * autonomy +
          0.08 * fairness +
          0.09 * team_coordination +
          0.10 * leadership_trust +
          0.10 * psychological_safety +
          0.08 * communication_quality +
          0.06 * culture_strength +
          0.08 * institutional_support +
          0.06 * voice_access -
          0.07 * workload_pressure -
          0.08 * burnout_pressure,
        0
      ),
      100
    ),
    modeled_work_system_risk = pmin(
      pmax(
        0.08 * (100 - role_clarity) +
          0.08 * (100 - autonomy) +
          0.09 * (100 - fairness) +
          0.09 * (100 - team_coordination) +
          0.10 * (100 - leadership_trust) +
          0.10 * (100 - psychological_safety) +
          0.08 * (100 - communication_quality) +
          0.07 * (100 - culture_strength) +
          0.08 * (100 - institutional_support) +
          0.08 * (100 - voice_access) +
          0.12 * workload_pressure +
          0.13 * burnout_pressure,
        0
      ),
      100
    ),
    review_priority = case_when(
      modeled_work_system_risk >= 70 |
        modeled_outcome_quality < 45 ~ "Immediate Review",
      modeled_work_system_risk >= 50 |
        modeled_outcome_quality < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_organizational_psychology_observations.csv"))

team_summary <- scored %>%
  group_by(team_id) %>%
  summarise(
    people = n(),
    avg_modeled_outcome_quality = mean(modeled_outcome_quality),
    avg_modeled_work_system_risk = mean(modeled_work_system_risk),
    avg_capability = mean(capability),
    avg_motivation = mean(motivation),
    avg_role_clarity = mean(role_clarity),
    avg_autonomy = mean(autonomy),
    avg_fairness = mean(fairness),
    avg_team_coordination = mean(team_coordination),
    avg_leadership_trust = mean(leadership_trust),
    avg_psychological_safety = mean(psychological_safety),
    avg_communication_quality = mean(communication_quality),
    avg_culture_strength = mean(culture_strength),
    avg_workload_pressure = mean(workload_pressure),
    avg_burnout_pressure = mean(burnout_pressure),
    avg_institutional_support = mean(institutional_support),
    avg_voice_access = mean(voice_access),
    .groups = "drop"
  ) %>%
  mutate(
    review_priority = case_when(
      avg_modeled_work_system_risk >= 70 |
        avg_modeled_outcome_quality < 45 ~ "Immediate Review",
      avg_modeled_work_system_risk >= 50 |
        avg_modeled_outcome_quality < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  ) %>%
  arrange(desc(avg_modeled_work_system_risk))

write_csv(team_summary, file.path(table_dir, "r_team_work_system_summary.csv"))

outcome_model <- lm(
  modeled_outcome_quality ~ capability + motivation + role_clarity +
    autonomy + fairness + team_coordination + leadership_trust +
    psychological_safety + communication_quality + culture_strength +
    workload_pressure + burnout_pressure + institutional_support +
    voice_access,
  data = scored
)

capture.output(
  summary(outcome_model),
  file = file.path(table_dir, "r_outcome_quality_model_summary.txt")
)

risk_plot <- ggplot(
  team_summary,
  aes(x = reorder(team_id, avg_modeled_work_system_risk), y = avg_modeled_work_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Work-System Risk by Team",
    x = "Synthetic team",
    y = "Average work-system risk"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_work_system_risk_by_team.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

safety_plot <- ggplot(
  scored,
  aes(x = psychological_safety, y = modeled_outcome_quality)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Psychological Safety and Modeled Outcome Quality",
    x = "Psychological safety",
    y = "Modeled outcome quality"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_psychological_safety_outcome_quality.png"),
  plot = safety_plot,
  width = 8,
  height = 5,
  dpi = 160
)

trust_plot <- ggplot(
  scored,
  aes(x = leadership_trust, y = modeled_outcome_quality)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Leadership Trust and Modeled Outcome Quality",
    x = "Leadership trust",
    y = "Modeled outcome quality"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_leadership_trust_outcome_quality.png"),
  plot = trust_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(team_summary)
message("Responsible-use reminder: synthetic organizational psychology workflow only.")

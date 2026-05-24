# Team Dynamics in Organizations
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, team-system review, collaboration-system education,
# communication and coordination analysis, leadership and team-design review,
# and reproducible workflows. It is not an employee-screening, hiring, promotion,
# compensation, discipline, termination, workplace surveillance, individual
# performance-management, cultural-loyalty scoring, team-fit scoring,
# collaboration scoring of workers, productivity-ranking, or psychological
# assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "team_dynamics_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

team_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- team_data %>%
  mutate(
    team_effectiveness_score = pmin(
      pmax(
        0.14 * communication_quality +
          0.12 * trust_level +
          0.12 * role_clarity +
          0.13 * psychological_safety +
          0.12 * leadership_support +
          0.11 * participation_equity +
          0.11 * learning_routine_quality -
          0.09 * conflict_load -
          0.08 * task_ambiguity -
          0.09 * coordination_cost,
        0
      ),
      100
    ),
    team_system_risk_score = pmin(
      pmax(
        0.11 * (100 - communication_quality) +
          0.10 * (100 - trust_level) +
          0.11 * (100 - role_clarity) +
          0.12 * (100 - psychological_safety) +
          0.10 * (100 - leadership_support) +
          0.10 * (100 - participation_equity) +
          0.10 * (100 - learning_routine_quality) +
          0.12 * conflict_load +
          0.12 * task_ambiguity +
          0.12 * coordination_cost,
        0
      ),
      100
    ),
    coordination_breakdown_score = pmin(
      pmax(
        0.30 * coordination_cost +
          0.25 * task_ambiguity +
          0.20 * conflict_load +
          0.15 * (100 - role_clarity) +
          0.10 * (100 - communication_quality),
        0
      ),
      100
    ),
    team_review_priority = case_when(
      team_system_risk_score >= 70 |
        team_effectiveness_score < 45 |
        symbolic_teamwork_risk == 1 ~ "Immediate Review",
      team_system_risk_score >= 50 |
        team_effectiveness_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_team_dynamics_observations.csv"))

team_summary <- scored %>%
  group_by(team_id) %>%
  summarise(
    observations = n(),
    avg_team_effectiveness = mean(team_effectiveness_score),
    avg_team_system_risk = mean(team_system_risk_score),
    avg_coordination_breakdown = mean(coordination_breakdown_score),
    avg_communication_quality = mean(communication_quality),
    avg_trust_level = mean(trust_level),
    avg_role_clarity = mean(role_clarity),
    avg_psychological_safety = mean(psychological_safety),
    avg_leadership_support = mean(leadership_support),
    avg_conflict_load = mean(conflict_load),
    avg_task_ambiguity = mean(task_ambiguity),
    avg_coordination_cost = mean(coordination_cost),
    avg_participation_equity = mean(participation_equity),
    avg_learning_routine_quality = mean(learning_routine_quality),
    strong_collective_performance_rate = mean(strong_collective_performance),
    symbolic_teamwork_risk_rate = mean(symbolic_teamwork_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_team_system_risk))

write_csv(team_summary, file.path(table_dir, "r_team_dynamics_summary.csv"))

performance_model <- glm(
  strong_collective_performance ~ communication_quality + trust_level +
    role_clarity + psychological_safety + leadership_support + conflict_load +
    task_ambiguity + coordination_cost + participation_equity +
    learning_routine_quality,
  family = binomial(),
  data = scored
)

capture.output(
  summary(performance_model),
  file = file.path(table_dir, "r_strong_collective_performance_model_summary.txt")
)

risk_plot <- ggplot(
  team_summary,
  aes(x = reorder(team_id, avg_team_system_risk), y = avg_team_system_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Team Dynamics Risk by Team",
    x = "Synthetic team",
    y = "Average team-system risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_team_dynamics_risk_by_team.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

safety_plot <- ggplot(
  scored,
  aes(x = psychological_safety, y = team_effectiveness_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Psychological Safety and Team Effectiveness",
    x = "Psychological safety",
    y = "Team effectiveness score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_psychological_safety_team_effectiveness.png"),
  plot = safety_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(team_summary)
message("Responsible-use reminder: synthetic team dynamics workflow only.")

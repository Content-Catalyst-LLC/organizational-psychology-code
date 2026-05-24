# Psychological Safety in High-Performing Teams
# Advanced synthetic R workflow
#
# Responsible-use scope:
# This script is for synthetic-data research, methods demonstration,
# institutional learning, team-learning review, psychological safety education,
# leadership and voice-system analysis, and reproducible workflows. It is not an
# employee-screening, hiring, promotion, compensation, discipline, termination,
# workplace surveillance, individual performance-management, cultural-loyalty
# scoring, courage scoring, voice scoring of workers, productivity-ranking, or
# psychological assessment tool.

suppressPackageStartupMessages({
  library(dplyr)
  library(readr)
  library(ggplot2)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "psychological_safety_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

safety_data <- read_csv(raw_path, show_col_types = FALSE)

scored <- safety_data %>%
  mutate(
    psychological_safety_score = pmin(
      pmax(
        0.18 * leadership_openness +
          0.16 * inclusion_quality +
          0.15 * learning_review_quality +
          0.14 * knowledge_sharing -
          0.13 * blame_intensity -
          0.11 * status_asymmetry -
          0.10 * perceived_penalty -
          0.06 * workload_pressure,
        0
      ),
      100
    ),
    safety_risk_score = pmin(
      pmax(
        0.15 * (100 - leadership_openness) +
          0.13 * (100 - inclusion_quality) +
          0.12 * (100 - learning_review_quality) +
          0.12 * (100 - knowledge_sharing) +
          0.14 * blame_intensity +
          0.12 * status_asymmetry +
          0.14 * perceived_penalty +
          0.08 * workload_pressure,
        0
      ),
      100
    ),
    safety_review_priority = case_when(
      safety_risk_score >= 70 |
        psychological_safety_score < 45 |
        symbolic_voice_risk == 1 ~ "Immediate Review",
      safety_risk_score >= 50 |
        psychological_safety_score < 60 ~ "Structured Review",
      TRUE ~ "Routine Monitoring"
    )
  )

write_csv(scored, file.path(table_dir, "r_scored_psychological_safety_observations.csv"))

team_summary <- scored %>%
  group_by(team_id) %>%
  summarise(
    observations = n(),
    avg_psychological_safety = mean(psychological_safety_score),
    avg_safety_risk = mean(safety_risk_score),
    avg_leadership_openness = mean(leadership_openness),
    avg_inclusion_quality = mean(inclusion_quality),
    avg_learning_review_quality = mean(learning_review_quality),
    avg_knowledge_sharing = mean(knowledge_sharing),
    avg_blame_intensity = mean(blame_intensity),
    avg_status_asymmetry = mean(status_asymmetry),
    avg_perceived_penalty = mean(perceived_penalty),
    avg_workload_pressure = mean(workload_pressure),
    strong_team_performance_rate = mean(strong_team_performance),
    symbolic_voice_risk_rate = mean(symbolic_voice_risk),
    .groups = "drop"
  ) %>%
  arrange(desc(avg_safety_risk))

write_csv(team_summary, file.path(table_dir, "r_team_psychological_safety_summary.csv"))

performance_model <- glm(
  strong_team_performance ~ leadership_openness + inclusion_quality +
    learning_review_quality + knowledge_sharing + blame_intensity +
    status_asymmetry + perceived_penalty + workload_pressure,
  family = binomial(),
  data = scored
)

capture.output(
  summary(performance_model),
  file = file.path(table_dir, "r_team_performance_model_summary.txt")
)

risk_plot <- ggplot(
  team_summary,
  aes(x = reorder(team_id, avg_safety_risk), y = avg_safety_risk)
) +
  geom_col() +
  coord_flip() +
  labs(
    title = "Synthetic Psychological Safety Risk by Team",
    x = "Synthetic team",
    y = "Average safety risk score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_psychological_safety_risk_by_team.png"),
  plot = risk_plot,
  width = 8,
  height = 5,
  dpi = 160
)

openness_plot <- ggplot(
  scored,
  aes(x = leadership_openness, y = psychological_safety_score)
) +
  geom_point(alpha = 0.55) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Leadership Openness and Psychological Safety",
    x = "Leadership openness",
    y = "Psychological safety score"
  ) +
  theme_minimal()

ggsave(
  filename = file.path(figure_dir, "r_leadership_openness_psychological_safety.png"),
  plot = openness_plot,
  width = 8,
  height = 5,
  dpi = 160
)

print(team_summary)
message("Responsible-use reminder: synthetic psychological safety workflow only.")

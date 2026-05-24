# R Workflow: Mapping Historical Phases of Organizational Psychology
# Synthetic history-of-the-field demonstration.
#
# Responsible-use scope:
# This workflow is for synthetic-data research, methods demonstration,
# institutional learning, organizational psychology education, and history-of-field
# analysis. It is not a tool for ranking scholars, departments, journals, workers,
# employees, or institutions.

suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(readr)
  library(ggplot2)
  library(scales)
})

root <- normalizePath(file.path(dirname(sys.frame(1)$ofile), ".."), mustWork = FALSE)
raw_path <- file.path(root, "data", "raw", "organizational_psychology_evolution_synthetic.csv")
table_dir <- file.path(root, "outputs", "tables")
figure_dir <- file.path(root, "outputs", "figures")

dir.create(table_dir, recursive = TRUE, showWarnings = FALSE)
dir.create(figure_dir, recursive = TRUE, showWarnings = FALSE)

history_data <- read_csv(raw_path, show_col_types = FALSE)

weighted_history <- history_data %>%
  mutate(
    industrial_orientation =
      0.46 * selection_testing +
      0.40 * efficiency_work_design +
      0.14 * motivation_attitudes,
    organizational_orientation =
      0.16 * motivation_attitudes +
      0.16 * groups_teams +
      0.20 * culture_leadership_change +
      0.14 * wellbeing_stress +
      0.14 * justice_validity_ethics +
      0.10 * digital_analytics +
      0.10 * systems_institutional_accountability,
    systems_ethics_orientation =
      0.16 * groups_teams +
      0.20 * culture_leadership_change +
      0.18 * wellbeing_stress +
      0.20 * justice_validity_ethics +
      0.12 * digital_analytics +
      0.14 * systems_institutional_accountability,
    field_expansion_index = organizational_orientation - industrial_orientation,
    responsible_progress_index =
      0.18 * selection_testing +
      0.08 * efficiency_work_design +
      0.12 * motivation_attitudes +
      0.12 * groups_teams +
      0.14 * culture_leadership_change +
      0.15 * wellbeing_stress +
      0.17 * justice_validity_ethics +
      0.08 * digital_analytics +
      0.06 * systems_institutional_accountability
  )

write_csv(weighted_history, file.path(table_dir, "r_field_evolution_indices.csv"))

long_history <- history_data %>%
  pivot_longer(
    cols = -period,
    names_to = "research_emphasis",
    values_to = "synthetic_emphasis_score"
  )

write_csv(long_history, file.path(table_dir, "r_field_evolution_long_format.csv"))

orientation_long <- weighted_history %>%
  select(period, industrial_orientation, organizational_orientation, systems_ethics_orientation) %>%
  pivot_longer(
    cols = -period,
    names_to = "orientation",
    values_to = "score"
  )

write_csv(orientation_long, file.path(table_dir, "r_orientation_long_format.csv"))

emphasis_plot <- ggplot(
  long_history,
  aes(x = period, y = synthetic_emphasis_score, group = research_emphasis)
) +
  geom_line() +
  geom_point() +
  facet_wrap(~ research_emphasis, ncol = 2) +
  labs(
    title = "Synthetic Evolution of Organizational Psychology Research Emphases",
    x = "Historical period",
    y = "Synthetic emphasis score"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  filename = file.path(figure_dir, "r_research_emphases_over_time.png"),
  plot = emphasis_plot,
  width = 10,
  height = 8,
  dpi = 160
)

orientation_plot <- ggplot(
  orientation_long,
  aes(x = period, y = score, group = orientation, linetype = orientation)
) +
  geom_line(linewidth = 1) +
  geom_point() +
  labs(
    title = "Synthetic Shift in Organizational Psychology Field Orientation",
    x = "Historical period",
    y = "Orientation score"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  filename = file.path(figure_dir, "r_field_orientation_shift.png"),
  plot = orientation_plot,
  width = 9,
  height = 5,
  dpi = 160
)

progress_plot <- ggplot(
  weighted_history,
  aes(x = period, y = responsible_progress_index, group = 1)
) +
  geom_line(linewidth = 1) +
  geom_point() +
  labs(
    title = "Synthetic Responsible Progress Index",
    subtitle = "Validity, well-being, justice, learning, digital governance, and institutional accountability",
    x = "Historical period",
    y = "Responsible progress index"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave(
  filename = file.path(figure_dir, "r_responsible_progress_index.png"),
  plot = progress_plot,
  width = 9,
  height = 5,
  dpi = 160
)

message("Responsible-use reminder: synthetic history-of-field workflow only.")
print(weighted_history)

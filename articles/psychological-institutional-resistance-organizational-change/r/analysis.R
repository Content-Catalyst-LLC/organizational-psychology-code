# Synthetic organizational psychology analysis.
# Run after the Python script creates data/processed/synthetic_organizational_observations.csv.

data_path <- file.path("data", "processed", "synthetic_organizational_observations.csv")

if (!file.exists(data_path)) {
  stop("Run: python3 python/organizational_simulation.py")
}

dat <- read.csv(data_path)

summary_table <- aggregate(
  cbind(motivation, role_clarity, leadership_trust, psychological_safety,
        perceived_fairness, workload_pressure, burnout_risk, commitment,
        job_satisfaction) ~ wave,
  data = dat,
  FUN = mean
)

dir.create("outputs", showWarnings = FALSE, recursive = TRUE)
write.csv(summary_table, file.path("outputs", "organizational_wave_summary.csv"), row.names = FALSE)

model <- lm(
  commitment ~ motivation + role_clarity + leadership_trust +
    psychological_safety + perceived_fairness - workload_pressure - burnout_risk,
  data = dat
)

print(summary(model))
print(summary_table)

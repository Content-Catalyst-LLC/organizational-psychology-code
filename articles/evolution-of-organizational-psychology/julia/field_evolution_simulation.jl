# The Evolution of Organizational Psychology
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational psychology education, and history-of-field analysis only.
# Not for ranking scholars, departments, journals, workers, employees, or
# institutions.

using Printf

struct FieldEmphasis
    selection_testing::Float64
    efficiency_work_design::Float64
    motivation_attitudes::Float64
    groups_teams::Float64
    culture_leadership_change::Float64
    wellbeing_stress::Float64
    justice_validity_ethics::Float64
    digital_analytics::Float64
    systems_institutional_accountability::Float64
end

function industrial_orientation(f::FieldEmphasis)
    return 0.46 * f.selection_testing +
           0.40 * f.efficiency_work_design +
           0.14 * f.motivation_attitudes
end

function organizational_orientation(f::FieldEmphasis)
    return 0.16 * f.motivation_attitudes +
           0.16 * f.groups_teams +
           0.20 * f.culture_leadership_change +
           0.14 * f.wellbeing_stress +
           0.14 * f.justice_validity_ethics +
           0.10 * f.digital_analytics +
           0.10 * f.systems_institutional_accountability
end

function responsible_progress(f::FieldEmphasis)
    return 0.18 * f.selection_testing +
           0.08 * f.efficiency_work_design +
           0.12 * f.motivation_attitudes +
           0.12 * f.groups_teams +
           0.14 * f.culture_leadership_change +
           0.15 * f.wellbeing_stress +
           0.17 * f.justice_validity_ethics +
           0.08 * f.digital_analytics +
           0.06 * f.systems_institutional_accountability
end

profiles = [
    ("Narrow administrative use", FieldEmphasis(86, 84, 28, 24, 18, 18, 26, 10, 16)),
    ("Broad responsible organizational psychology", FieldEmphasis(72, 66, 84, 86, 88, 86, 92, 84, 90))
]

for (label, profile) in profiles
    @printf("%s | Industrial: %.2f | Organizational: %.2f | Responsible progress: %.2f\n",
            label,
            industrial_orientation(profile),
            organizational_orientation(profile),
            responsible_progress(profile))
end

println("Responsible-use reminder: synthetic field-evolution simulation only.")

# Cognitive Bias in Institutional Decisions
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# decision-governance review, bias-risk analysis, and reproducible workflows only.
# Not for employee screening, employment selection, executive ranking,
# productivity ranking, individual performance management, or psychological assessment.

using Random
using Printf

Random.seed!(404)

struct BiasPressureProfile
    signal_quality::Float64
    viewpoint_diversity::Float64
    analytical_discipline::Float64
    structured_challenge::Float64
    hierarchy_suppression::Float64
    time_pressure::Float64
    routine_reinforcement::Float64
    learning_review::Float64
    group_conformity::Float64
end

function bias_pressure(p::BiasPressureProfile)
    return (
        0.16 * p.hierarchy_suppression +
        0.15 * p.time_pressure +
        0.14 * p.routine_reinforcement +
        0.13 * p.group_conformity -
        0.16 * p.viewpoint_diversity -
        0.13 * p.analytical_discipline -
        0.14 * p.structured_challenge -
        0.12 * p.learning_review -
        0.10 * p.signal_quality
    )
end

function bias_risk(p::BiasPressureProfile)
    return (
        0.10 * (100 - p.signal_quality) +
        0.13 * (100 - p.viewpoint_diversity) +
        0.12 * (100 - p.analytical_discipline) +
        0.12 * (100 - p.structured_challenge) +
        0.15 * p.hierarchy_suppression +
        0.12 * p.time_pressure +
        0.10 * p.routine_reinforcement +
        0.08 * (100 - p.learning_review) +
        0.08 * p.group_conformity
    )
end

profiles = [
    BiasPressureProfile(84, 80, 82, 81, 14, 38, 36, 79, 28),
    BiasPressureProfile(48, 36, 41, 24, 72, 74, 69, 31, 70),
    BiasPressureProfile(70, 65, 67, 63, 35, 55, 51, 62, 43)
]

for (i, profile) in enumerate(profiles)
    pressure = bias_pressure(profile)
    risk = bias_risk(profile)
    @printf("Profile %d | Bias pressure: %.2f | Bias risk: %.2f\n", i, pressure, risk)
end

println("Responsible-use reminder: synthetic institutional decision-governance simulation only.")

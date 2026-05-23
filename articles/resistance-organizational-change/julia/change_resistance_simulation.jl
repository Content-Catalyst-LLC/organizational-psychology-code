# Resistance to Organizational Change
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational change governance, and reproducible workflows only.
# Not for employee screening, employment selection, surveillance, individual
# performance management, or psychological assessment.

using Random
using Statistics
using Printf

Random.seed!(777)

struct ChangeProfile
    perceived_loss::Float64
    uncertainty::Float64
    identity_threat::Float64
    routine_embeddedness::Float64
    power_displacement::Float64
    trust_in_leadership::Float64
    participation_quality::Float64
    implementation_clarity::Float64
    workload_strain::Float64
    failed_change_history::Float64
end

function resistance_intensity(p::ChangeProfile)
    return (
        0.17 * p.perceived_loss +
        0.16 * p.uncertainty +
        0.13 * p.identity_threat +
        0.13 * p.routine_embeddedness +
        0.10 * p.power_displacement +
        0.10 * p.workload_strain +
        6.0 * p.failed_change_history -
        0.12 * p.trust_in_leadership -
        0.08 * p.participation_quality -
        0.09 * p.implementation_clarity
    )
end

function change_friction_risk(p::ChangeProfile)
    return (
        0.18 * p.perceived_loss +
        0.16 * p.uncertainty +
        0.12 * p.identity_threat +
        0.13 * p.routine_embeddedness +
        0.09 * p.power_displacement +
        0.10 * p.workload_strain +
        0.10 * (100 - p.trust_in_leadership) +
        0.06 * (100 - p.participation_quality) +
        0.06 * (100 - p.implementation_clarity) +
        4.0 * p.failed_change_history
    )
end

profiles = [
    ChangeProfile(26, 32, 24, 52, 20, 84, 81, 86, 41, 0),
    ChangeProfile(78, 82, 74, 86, 68, 29, 24, 31, 80, 1),
    ChangeProfile(49, 55, 46, 65, 42, 64, 59, 62, 61, 0)
]

for (i, profile) in enumerate(profiles)
    resistance = resistance_intensity(profile)
    friction = change_friction_risk(profile)
    @printf("Profile %d | Resistance intensity: %.2f | Change-friction risk: %.2f\n",
            i, resistance, friction)
end

println("Responsible-use reminder: synthetic institutional change-governance simulation only.")

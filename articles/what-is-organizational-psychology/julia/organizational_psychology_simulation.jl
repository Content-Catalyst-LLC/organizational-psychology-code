# What Is Organizational Psychology?
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational psychology education, and reproducible workflows only.
# Not for employee screening, employment selection, productivity ranking,
# loyalty scoring, dissent tracking, workplace surveillance, or psychological
# assessment.

using Random
using Printf

Random.seed!(424)

struct WorkSystemProfile
    capability::Float64
    motivation::Float64
    role_clarity::Float64
    autonomy::Float64
    fairness::Float64
    team_coordination::Float64
    leadership_trust::Float64
    psychological_safety::Float64
    communication_quality::Float64
    culture_strength::Float64
    workload_pressure::Float64
    burnout_pressure::Float64
    institutional_support::Float64
    voice_access::Float64
end

function outcome_quality(p::WorkSystemProfile)
    return (
        0.11 * p.capability +
        0.10 * p.motivation +
        0.10 * p.role_clarity +
        0.07 * p.autonomy +
        0.08 * p.fairness +
        0.09 * p.team_coordination +
        0.10 * p.leadership_trust +
        0.10 * p.psychological_safety +
        0.08 * p.communication_quality +
        0.06 * p.culture_strength +
        0.08 * p.institutional_support +
        0.06 * p.voice_access -
        0.07 * p.workload_pressure -
        0.08 * p.burnout_pressure
    )
end

profiles = [
    WorkSystemProfile(72, 76, 82, 78, 80, 80, 84, 81, 82, 79, 28, 25, 82, 80),
    WorkSystemProfile(72, 52, 38, 36, 34, 41, 34, 33, 37, 35, 78, 75, 36, 34)
]

for (i, profile) in enumerate(profiles)
    score = outcome_quality(profile)
    @printf("Profile %d | Synthetic modeled outcome quality: %.2f\n", i, score)
end

println("Responsible-use reminder: synthetic organizational psychology simulation only.")

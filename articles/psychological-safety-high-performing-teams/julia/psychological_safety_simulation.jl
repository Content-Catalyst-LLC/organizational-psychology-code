# Psychological Safety in High-Performing Teams
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# team-learning review, psychological safety education, and reproducible
# workflows only. Not for employee screening, employment selection, courage
# scoring, voice scoring of workers, productivity ranking, individual
# performance management, or psychological assessment.

using Random
using Printf

Random.seed!(707)

struct PsychologicalSafetyProfile
    leadership_openness::Float64
    inclusion_quality::Float64
    learning_review_quality::Float64
    knowledge_sharing::Float64
    blame_intensity::Float64
    status_asymmetry::Float64
    perceived_penalty::Float64
    workload_pressure::Float64
end

function psychological_safety_score(p::PsychologicalSafetyProfile)
    return (
        0.18 * p.leadership_openness +
        0.16 * p.inclusion_quality +
        0.15 * p.learning_review_quality +
        0.14 * p.knowledge_sharing -
        0.13 * p.blame_intensity -
        0.11 * p.status_asymmetry -
        0.10 * p.perceived_penalty -
        0.06 * p.workload_pressure
    )
end

function safety_risk_score(p::PsychologicalSafetyProfile)
    return (
        0.15 * (100 - p.leadership_openness) +
        0.13 * (100 - p.inclusion_quality) +
        0.12 * (100 - p.learning_review_quality) +
        0.12 * (100 - p.knowledge_sharing) +
        0.14 * p.blame_intensity +
        0.12 * p.status_asymmetry +
        0.14 * p.perceived_penalty +
        0.08 * p.workload_pressure
    )
end

profiles = [
    PsychologicalSafetyProfile(84, 82, 80, 81, 16, 20, 18, 52),
    PsychologicalSafetyProfile(34, 38, 36, 39, 72, 69, 74, 52),
    PsychologicalSafetyProfile(71, 69, 66, 68, 35, 39, 37, 60)
]

for (i, profile) in enumerate(profiles)
    safety = psychological_safety_score(profile)
    risk = safety_risk_score(profile)
    @printf("Profile %d | Psychological safety: %.2f | Safety risk: %.2f\n",
            i, safety, risk)
end

println("Responsible-use reminder: synthetic psychological safety simulation only.")

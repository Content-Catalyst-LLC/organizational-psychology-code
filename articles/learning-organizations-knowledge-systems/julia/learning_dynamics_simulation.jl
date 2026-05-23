# Learning Organizations and Knowledge Systems
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational knowledge governance, and reproducible workflows only.
# Not for employee screening, employment selection, surveillance, individual
# performance management, or psychological assessment.

using Random
using Statistics
using Printf

Random.seed!(321)

struct LearningProfile
    information_quality::Float64
    interpretive_openness::Float64
    memory_retention::Float64
    communication_flow::Float64
    psychological_safety::Float64
    governance_support::Float64
    complexity_load::Float64
    silo_intensity::Float64
    incentive_distortion::Float64
    turnover_pressure::Float64
end

function learning_capacity(p::LearningProfile)
    return (
        0.17 * p.information_quality +
        0.18 * p.interpretive_openness +
        0.15 * p.memory_retention +
        0.15 * p.communication_flow +
        0.13 * p.psychological_safety +
        0.10 * p.governance_support -
        0.07 * p.complexity_load -
        0.10 * p.silo_intensity -
        0.10 * p.incentive_distortion -
        0.05 * p.turnover_pressure
    )
end

function knowledge_decay_risk(p::LearningProfile)
    return (
        0.28 * (100 - p.memory_retention) +
        0.18 * p.turnover_pressure +
        0.16 * p.silo_intensity +
        0.12 * (100 - p.communication_flow) +
        0.10 * (100 - p.governance_support) +
        0.10 * p.incentive_distortion +
        0.06 * p.complexity_load
    )
end

profiles = [
    LearningProfile(84, 82, 83, 86, 84, 78, 48, 20, 17, 19),
    LearningProfile(57, 38, 42, 45, 36, 39, 75, 78, 67, 59),
    LearningProfile(72, 66, 70, 69, 67, 63, 58, 40, 35, 32)
]

for (i, profile) in enumerate(profiles)
    learning = learning_capacity(profile)
    decay = knowledge_decay_risk(profile)
    @printf("Profile %d | Learning capacity: %.2f | Knowledge decay risk: %.2f\n",
            i, learning, decay)
end

println("Responsible-use reminder: synthetic institutional learning simulation only.")

# Organizational Resilience in Complex Systems
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# and reproducible workflows only. Not for employee screening, employment
# selection, surveillance, individual performance management, or psychological
# assessment.

using Random
using Statistics
using Printf

Random.seed!(123)

struct ResilienceProfile
    robustness::Float64
    redundancy::Float64
    adaptive_learning::Float64
    coordination_integrity::Float64
    governance_responsiveness::Float64
    psychological_safety::Float64
    external_exposure::Float64
    complexity_load::Float64
    accumulated_fragility::Float64
end

function resilience_capacity(p::ResilienceProfile)
    return (
        0.18 * p.robustness +
        0.12 * p.redundancy +
        0.16 * p.adaptive_learning +
        0.14 * p.coordination_integrity +
        0.12 * p.governance_responsiveness +
        0.13 * p.psychological_safety -
        0.08 * p.external_exposure -
        0.07 * p.complexity_load -
        0.10 * p.accumulated_fragility
    )
end

function simulate_recovery(p::ResilienceProfile, shock_intensity::Float64)
    capacity = resilience_capacity(p)
    recovery = capacity - 0.45 * shock_intensity + 0.10 * p.adaptive_learning - 0.12 * p.accumulated_fragility
    return max(0.0, min(100.0, recovery))
end

profiles = [
    ResilienceProfile(82, 78, 84, 80, 77, 85, 42, 50, 20),
    ResilienceProfile(55, 42, 50, 48, 45, 44, 70, 76, 68),
    ResilienceProfile(68, 61, 70, 67, 63, 69, 56, 62, 41)
]

for (i, profile) in enumerate(profiles)
    shocks = rand(30:90, 10)
    recoveries = [simulate_recovery(profile, shock) for shock in shocks]
    @printf("Profile %d | Mean recovery score: %.2f | Minimum: %.2f | Maximum: %.2f\n",
            i, mean(recoveries), minimum(recoveries), maximum(recoveries))
end

println("Responsible-use reminder: synthetic institutional learning simulation only.")

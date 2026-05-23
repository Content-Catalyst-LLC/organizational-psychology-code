# Adaptive Organizations: Institutional Change and Strategic Transformation
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational change governance, and reproducible workflows only.
# Not for employee screening, employment selection, surveillance, individual
# performance management, or psychological assessment.

using Random
using Printf

Random.seed!(909)

struct AdaptiveChangeProfile
    sensing_quality::Float64
    interpretive_coherence::Float64
    governance_alignment::Float64
    learning_capability::Float64
    resource_flexibility::Float64
    institutional_legitimacy::Float64
    organizational_inertia::Float64
    fragmentation::Float64
    resistance_friction::Float64
    environmental_pressure::Float64
end

function adaptive_change_capacity(p::AdaptiveChangeProfile)
    return (
        0.17 * p.sensing_quality +
        0.16 * p.interpretive_coherence +
        0.15 * p.governance_alignment +
        0.16 * p.learning_capability +
        0.12 * p.resource_flexibility +
        0.12 * p.institutional_legitimacy -
        0.13 * p.organizational_inertia -
        0.11 * p.fragmentation -
        0.10 * p.resistance_friction -
        0.05 * p.environmental_pressure
    )
end

function adaptation_risk(p::AdaptiveChangeProfile)
    return (
        0.16 * (100 - p.sensing_quality) +
        0.14 * (100 - p.interpretive_coherence) +
        0.14 * (100 - p.governance_alignment) +
        0.14 * (100 - p.learning_capability) +
        0.10 * (100 - p.resource_flexibility) +
        0.10 * (100 - p.institutional_legitimacy) +
        0.10 * p.organizational_inertia +
        0.06 * p.fragmentation +
        0.04 * p.resistance_friction +
        0.02 * p.environmental_pressure
    )
end

profiles = [
    AdaptiveChangeProfile(84, 81, 79, 83, 74, 80, 20, 18, 24, 62),
    AdaptiveChangeProfile(52, 44, 39, 46, 41, 43, 73, 66, 68, 62),
    AdaptiveChangeProfile(70, 65, 63, 67, 60, 66, 42, 38, 40, 60)
]

for (i, profile) in enumerate(profiles)
    capacity = adaptive_change_capacity(profile)
    risk = adaptation_risk(profile)
    @printf("Profile %d | Adaptive change capacity: %.2f | Adaptation risk: %.2f\n",
            i, capacity, risk)
end

println("Responsible-use reminder: synthetic institutional change-governance simulation only.")

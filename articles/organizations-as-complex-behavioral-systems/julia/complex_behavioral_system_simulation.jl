# Organizations as Complex Behavioral Systems
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational psychology education, complex behavioral systems analysis, and
# reproducible workflows only. Not for employee screening, employment selection,
# productivity ranking, loyalty scoring, dissent tracking, workplace
# surveillance, or psychological assessment.

using Printf

struct ComplexSystemProfile
    capability::Float64
    motivation::Float64
    role_clarity::Float64
    psychological_safety::Float64
    leadership_trust::Float64
    cultural_coherence::Float64
    incentive_alignment::Float64
    information_flow::Float64
    learning_capacity::Float64
    redundancy_slack::Float64
    workload_pressure::Float64
    silence_risk::Float64
    fragmentation_pressure::Float64
    environmental_uncertainty::Float64
end

function behavior_quality(p::ComplexSystemProfile)
    return (
        0.13 * p.capability +
        0.12 * p.motivation +
        0.12 * p.role_clarity +
        0.11 * p.psychological_safety +
        0.11 * p.leadership_trust +
        0.09 * p.cultural_coherence +
        0.09 * p.incentive_alignment +
        0.08 * p.information_flow +
        0.07 * p.learning_capacity +
        0.05 * p.redundancy_slack -
        0.08 * p.workload_pressure -
        0.06 * p.silence_risk -
        0.06 * p.fragmentation_pressure -
        0.05 * p.environmental_uncertainty
    )
end

function complex_system_risk(p::ComplexSystemProfile)
    return (
        0.11 * (100 - p.psychological_safety) +
        0.11 * (100 - p.leadership_trust) +
        0.09 * (100 - p.cultural_coherence) +
        0.09 * (100 - p.incentive_alignment) +
        0.09 * (100 - p.information_flow) +
        0.10 * (100 - p.learning_capacity) +
        0.08 * (100 - p.redundancy_slack) +
        0.09 * p.workload_pressure +
        0.08 * p.silence_risk +
        0.10 * p.fragmentation_pressure +
        0.08 * p.environmental_uncertainty
    )
end

profiles = [
    ("High-trust learning-oriented complex system",
     ComplexSystemProfile(72, 78, 82, 84, 85, 82, 80, 83, 82, 68, 30, 18, 22, 42)),
    ("Fragmented overloaded silence-prone system",
     ComplexSystemProfile(72, 48, 38, 30, 32, 36, 34, 35, 28, 18, 82, 76, 78, 72))
]

for (label, profile) in profiles
    @printf("%s | Behavior quality: %.2f | Complex system risk: %.2f\n",
            label, behavior_quality(profile), complex_system_risk(profile))
end

println("Responsible-use reminder: synthetic complex behavioral systems simulation only.")

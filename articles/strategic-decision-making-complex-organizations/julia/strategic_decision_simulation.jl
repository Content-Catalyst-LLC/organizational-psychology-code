# Strategic Decision-Making in Complex Organizations
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# strategic governance, decision-process review, and reproducible workflows only.
# Not for employee screening, employment selection, executive ranking,
# surveillance, individual performance management, or psychological assessment.

using Random
using Printf

Random.seed!(616)

struct StrategicDecisionProfile
    sensing_quality::Float64
    interpretive_coherence::Float64
    knowledge_integration::Float64
    option_diversity::Float64
    governance_quality::Float64
    adaptive_learning::Float64
    bias_pressure::Float64
    political_distortion::Float64
    complexity_load::Float64
    environmental_turbulence::Float64
end

function strategic_decision_quality(p::StrategicDecisionProfile)
    return (
        0.17 * p.sensing_quality +
        0.16 * p.interpretive_coherence +
        0.16 * p.knowledge_integration +
        0.12 * p.option_diversity +
        0.13 * p.governance_quality +
        0.14 * p.adaptive_learning -
        0.12 * p.bias_pressure -
        0.10 * p.political_distortion -
        0.09 * p.complexity_load -
        0.08 * p.environmental_turbulence
    )
end

function strategic_risk(p::StrategicDecisionProfile)
    return (
        0.15 * (100 - p.sensing_quality) +
        0.13 * (100 - p.interpretive_coherence) +
        0.14 * (100 - p.knowledge_integration) +
        0.08 * (100 - p.option_diversity) +
        0.12 * (100 - p.governance_quality) +
        0.12 * (100 - p.adaptive_learning) +
        0.10 * p.bias_pressure +
        0.08 * p.political_distortion +
        0.04 * p.complexity_load +
        0.04 * p.environmental_turbulence
    )
end

profiles = [
    StrategicDecisionProfile(84, 79, 82, 74, 77, 81, 18, 14, 58, 62),
    StrategicDecisionProfile(49, 42, 45, 38, 39, 43, 71, 66, 58, 62),
    StrategicDecisionProfile(70, 65, 68, 61, 64, 67, 38, 35, 62, 60)
]

for (i, profile) in enumerate(profiles)
    quality = strategic_decision_quality(profile)
    risk = strategic_risk(profile)
    @printf("Profile %d | Strategic decision quality: %.2f | Strategic risk: %.2f\n",
            i, quality, risk)
end

println("Responsible-use reminder: synthetic strategic governance simulation only.")

# Leadership Styles and Organizational Performance
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# leadership-system review, communication/trust/style-fit analysis, and
# reproducible workflows only. Not for employee screening, employment selection,
# productivity ranking, leadership-loyalty scoring, dissent tracking, individual
# performance management, workplace surveillance, or psychological assessment.

using Random
using Printf

Random.seed!(818)

struct LeadershipStyleProfile
    participative_behavior::Float64
    structural_guidance::Float64
    communication_quality::Float64
    trust_generation::Float64
    developmental_support::Float64
    psychological_safety::Float64
    decision_fit::Float64
    cultural_alignment::Float64
    control_pressure::Float64
    ambiguity_risk::Float64
    disengagement_pressure::Float64
end

function leadership_effectiveness(p::LeadershipStyleProfile)
    return (
        0.11 * p.participative_behavior +
        0.12 * p.structural_guidance +
        0.13 * p.communication_quality +
        0.13 * p.trust_generation +
        0.11 * p.developmental_support +
        0.12 * p.psychological_safety +
        0.11 * p.decision_fit +
        0.10 * p.cultural_alignment -
        0.08 * p.control_pressure -
        0.07 * p.ambiguity_risk -
        0.07 * p.disengagement_pressure
    )
end

function leadership_system_risk(p::LeadershipStyleProfile)
    return (
        0.09 * (100 - p.participative_behavior) +
        0.10 * (100 - p.structural_guidance) +
        0.12 * (100 - p.communication_quality) +
        0.13 * (100 - p.trust_generation) +
        0.09 * (100 - p.developmental_support) +
        0.12 * (100 - p.psychological_safety) +
        0.10 * (100 - p.decision_fit) +
        0.08 * (100 - p.cultural_alignment) +
        0.11 * p.control_pressure +
        0.10 * p.ambiguity_risk +
        0.10 * p.disengagement_pressure
    )
end

profiles = [
    LeadershipStyleProfile(82, 80, 83, 81, 79, 80, 82, 81, 18, 22, 20),
    LeadershipStyleProfile(34, 39, 36, 31, 35, 34, 38, 33, 72, 69, 71),
    LeadershipStyleProfile(73, 72, 71, 69, 67, 69, 72, 70, 35, 39, 37)
]

for (i, profile) in enumerate(profiles)
    effectiveness = leadership_effectiveness(profile)
    risk = leadership_system_risk(profile)
    @printf("Profile %d | Leadership effectiveness: %.2f | Leadership-system risk: %.2f\n",
            i, effectiveness, risk)
end

println("Responsible-use reminder: synthetic leadership-style simulation only.")

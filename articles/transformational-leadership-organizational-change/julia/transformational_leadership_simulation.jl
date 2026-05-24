# Transformational Leadership and Organizational Change
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# transformational-leadership review, change-system analysis, psychological-
# safety and organizational-learning education, and reproducible workflows only.
# Not for employee screening, employment selection, productivity ranking,
# leadership-loyalty scoring, dissent tracking, individual performance
# management, workplace surveillance, or psychological assessment.

using Random
using Printf

Random.seed!(929)

struct TransformationalLeadershipProfile
    vision_credibility::Float64
    motivational_alignment::Float64
    intellectual_stimulation::Float64
    developmental_support::Float64
    institutional_trust::Float64
    psychological_safety::Float64
    change_communication::Float64
    implementation_support::Float64
    meaning_making_quality::Float64
    resistance_intensity::Float64
    ambiguity_pressure::Float64
    change_fatigue::Float64
end

function transformational_capacity(p::TransformationalLeadershipProfile)
    return (
        0.12 * p.vision_credibility +
        0.11 * p.motivational_alignment +
        0.11 * p.intellectual_stimulation +
        0.10 * p.developmental_support +
        0.12 * p.institutional_trust +
        0.11 * p.psychological_safety +
        0.10 * p.change_communication +
        0.09 * p.implementation_support +
        0.10 * p.meaning_making_quality -
        0.08 * p.resistance_intensity -
        0.07 * p.ambiguity_pressure -
        0.08 * p.change_fatigue
    )
end

function transformational_system_risk(p::TransformationalLeadershipProfile)
    return (
        0.11 * (100 - p.vision_credibility) +
        0.10 * (100 - p.motivational_alignment) +
        0.09 * (100 - p.intellectual_stimulation) +
        0.09 * (100 - p.developmental_support) +
        0.12 * (100 - p.institutional_trust) +
        0.11 * (100 - p.psychological_safety) +
        0.09 * (100 - p.change_communication) +
        0.09 * (100 - p.implementation_support) +
        0.09 * (100 - p.meaning_making_quality) +
        0.10 * p.resistance_intensity +
        0.10 * p.ambiguity_pressure +
        0.12 * p.change_fatigue
    )
end

profiles = [
    TransformationalLeadershipProfile(84, 81, 80, 79, 82, 80, 83, 78, 82, 20, 22, 24),
    TransformationalLeadershipProfile(36, 39, 35, 34, 31, 34, 37, 32, 36, 72, 70, 74),
    TransformationalLeadershipProfile(73, 70, 69, 67, 69, 68, 72, 66, 71, 35, 39, 41)
]

for (i, profile) in enumerate(profiles)
    capacity = transformational_capacity(profile)
    risk = transformational_system_risk(profile)
    @printf("Profile %d | Transformational capacity: %.2f | Transformational-system risk: %.2f\n",
            i, capacity, risk)
end

println("Responsible-use reminder: synthetic transformational-leadership simulation only.")

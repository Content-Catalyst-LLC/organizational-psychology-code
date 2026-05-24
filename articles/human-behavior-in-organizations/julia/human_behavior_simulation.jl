# Human Behavior in Organizations
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational psychology education, human-behavior systems analysis, and
# reproducible workflows only. Not for employee screening, employment selection,
# productivity ranking, loyalty scoring, dissent tracking, workplace
# surveillance, or psychological assessment.

using Printf

struct HumanBehaviorProfile
    capability::Float64
    motivation::Float64
    role_clarity::Float64
    psychological_safety::Float64
    leadership_trust::Float64
    cultural_norm_strength::Float64
    incentive_alignment::Float64
    workload_pressure::Float64
    burnout_pressure::Float64
    hierarchical_pressure::Float64
    perceived_voice_efficacy::Float64
    fear_of_retaliation::Float64
end

function behavior_quality(p::HumanBehaviorProfile)
    return (
        0.16 * p.capability +
        0.15 * p.motivation +
        0.14 * p.role_clarity +
        0.12 * p.psychological_safety +
        0.12 * p.leadership_trust +
        0.10 * p.cultural_norm_strength +
        0.09 * p.incentive_alignment -
        0.08 * p.workload_pressure -
        0.08 * p.burnout_pressure -
        0.06 * p.hierarchical_pressure
    )
end

function voice_probability(p::HumanBehaviorProfile)
    z = -2.0 +
        0.030 * p.psychological_safety +
        0.024 * p.leadership_trust +
        0.022 * p.perceived_voice_efficacy -
        0.026 * p.fear_of_retaliation -
        0.020 * p.hierarchical_pressure
    return 1.0 / (1.0 + exp(-z))
end

profiles = [
    ("High-trust learning-oriented organization",
     HumanBehaviorProfile(72, 78, 82, 84, 85, 82, 80, 30, 24, 22, 80, 12)),
    ("Low-trust overloaded fear-based organization",
     HumanBehaviorProfile(72, 48, 38, 30, 32, 36, 34, 82, 78, 76, 26, 72))
]

for (label, profile) in profiles
    @printf("%s | Behavior quality: %.2f | Voice probability: %.3f\n",
            label, behavior_quality(profile), voice_probability(profile))
end

println("Responsible-use reminder: synthetic human-behavior simulation only.")

# Incentives and Workplace Behavior
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# incentive-system review, reward-governance education, and reproducible workflows
# only. Not for employee screening, employment selection, productivity ranking,
# incentive-compliance scoring, individual performance management, workplace
# surveillance, or psychological assessment.

using Random
using Printf

Random.seed!(535)

struct IncentiveSystemProfile
    expectancy_strength::Float64
    fairness_perception::Float64
    strategic_alignment::Float64
    intrinsic_support::Float64
    feedback_clarity::Float64
    distortion_risk::Float64
    overload_pressure::Float64
    ethical_risk::Float64
    cooperation_support::Float64
    recognition_legitimacy::Float64
    reward_transparency::Float64
    hidden_labor_recognition::Float64
end

function incentive_effectiveness(p::IncentiveSystemProfile)
    return (
        0.12 * p.expectancy_strength +
        0.13 * p.fairness_perception +
        0.12 * p.strategic_alignment +
        0.10 * p.intrinsic_support +
        0.11 * p.feedback_clarity +
        0.10 * p.cooperation_support +
        0.10 * p.recognition_legitimacy +
        0.09 * p.reward_transparency +
        0.08 * p.hidden_labor_recognition -
        0.08 * p.distortion_risk -
        0.07 * p.overload_pressure -
        0.08 * p.ethical_risk
    )
end

function incentive_system_risk(p::IncentiveSystemProfile)
    return (
        0.10 * (100 - p.expectancy_strength) +
        0.13 * (100 - p.fairness_perception) +
        0.11 * (100 - p.strategic_alignment) +
        0.09 * (100 - p.intrinsic_support) +
        0.10 * (100 - p.feedback_clarity) +
        0.09 * (100 - p.cooperation_support) +
        0.08 * (100 - p.recognition_legitimacy) +
        0.08 * (100 - p.reward_transparency) +
        0.07 * (100 - p.hidden_labor_recognition) +
        0.10 * p.distortion_risk +
        0.08 * p.overload_pressure +
        0.07 * p.ethical_risk
    )
end

profiles = [
    IncentiveSystemProfile(83, 81, 82, 79, 80, 18, 24, 16, 82, 80, 81, 78),
    IncentiveSystemProfile(39, 34, 41, 36, 38, 72, 70, 71, 35, 33, 34, 31),
    IncentiveSystemProfile(73, 69, 72, 67, 70, 35, 39, 33, 71, 69, 70, 67)
]

for (i, profile) in enumerate(profiles)
    effectiveness = incentive_effectiveness(profile)
    risk = incentive_system_risk(profile)
    @printf("Profile %d | Incentive effectiveness: %.2f | Incentive-system risk: %.2f\n",
            i, effectiveness, risk)
end

println("Responsible-use reminder: synthetic incentive-system simulation only.")

# Employee Motivation in Organizations
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# motivational-systems review, work-design education, and reproducible workflows
# only. Not for employee screening, employment selection, productivity ranking,
# motivation scoring, loyalty scoring, individual performance management,
# workplace surveillance, or psychological assessment.

using Random
using Printf

Random.seed!(242)

struct MotivationSystemProfile
    autonomy_support::Float64
    competence_development::Float64
    recognition_quality::Float64
    institutional_trust::Float64
    goal_clarity::Float64
    fairness_perception::Float64
    workload_strain::Float64
    control_pressure::Float64
    relatedness::Float64
    meaningful_work::Float64
    psychological_safety::Float64
    leadership_credibility::Float64
end

function motivation_quality(p::MotivationSystemProfile)
    return (
        0.12 * p.autonomy_support +
        0.11 * p.competence_development +
        0.10 * p.recognition_quality +
        0.12 * p.institutional_trust +
        0.10 * p.goal_clarity +
        0.11 * p.fairness_perception +
        0.10 * p.relatedness +
        0.11 * p.meaningful_work +
        0.10 * p.psychological_safety +
        0.10 * p.leadership_credibility -
        0.08 * p.workload_strain -
        0.07 * p.control_pressure
    )
end

function motivation_system_risk(p::MotivationSystemProfile)
    return (
        0.10 * (100 - p.autonomy_support) +
        0.09 * (100 - p.competence_development) +
        0.08 * (100 - p.recognition_quality) +
        0.12 * (100 - p.institutional_trust) +
        0.08 * (100 - p.goal_clarity) +
        0.11 * (100 - p.fairness_perception) +
        0.08 * (100 - p.relatedness) +
        0.09 * (100 - p.meaningful_work) +
        0.10 * (100 - p.psychological_safety) +
        0.09 * (100 - p.leadership_credibility) +
        0.11 * p.workload_strain +
        0.10 * p.control_pressure
    )
end

profiles = [
    MotivationSystemProfile(84, 80, 79, 82, 83, 81, 22, 18, 82, 84, 80, 82),
    MotivationSystemProfile(34, 39, 36, 31, 40, 35, 73, 71, 37, 38, 34, 33),
    MotivationSystemProfile(73, 69, 67, 69, 72, 70, 39, 35, 71, 73, 69, 70)
]

for (i, profile) in enumerate(profiles)
    quality = motivation_quality(profile)
    risk = motivation_system_risk(profile)
    @printf("Profile %d | Motivation quality: %.2f | Motivational-system risk: %.2f\n",
            i, quality, risk)
end

println("Responsible-use reminder: synthetic motivational-system simulation only.")

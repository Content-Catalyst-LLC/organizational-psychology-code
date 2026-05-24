# Goal Setting and Performance Systems
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# goal-system review, performance-system education, and reproducible workflows
# only. Not for employee screening, employment selection, productivity ranking,
# goal-compliance scoring, individual performance management, workplace
# surveillance, or psychological assessment.

using Random
using Printf

Random.seed!(323)

struct GoalSystemProfile
    goal_clarity::Float64
    goal_challenge::Float64
    feedback_quality::Float64
    employee_commitment::Float64
    strategic_alignment::Float64
    overload_pressure::Float64
    metric_distortion::Float64
    incentive_misalignment::Float64
    review_quality::Float64
    proxy_drift::Float64
    goal_feasibility::Float64
end

function goal_system_effectiveness(p::GoalSystemProfile)
    return (
        0.13 * p.goal_clarity +
        0.10 * p.goal_challenge +
        0.13 * p.feedback_quality +
        0.11 * p.employee_commitment +
        0.13 * p.strategic_alignment +
        0.11 * p.review_quality +
        0.11 * p.goal_feasibility -
        0.07 * p.overload_pressure -
        0.06 * p.metric_distortion -
        0.05 * p.incentive_misalignment -
        0.04 * p.proxy_drift
    )
end

function goal_system_risk(p::GoalSystemProfile)
    return (
        0.12 * (100 - p.goal_clarity) +
        0.08 * (100 - p.goal_challenge) +
        0.13 * (100 - p.feedback_quality) +
        0.10 * (100 - p.employee_commitment) +
        0.13 * (100 - p.strategic_alignment) +
        0.10 * (100 - p.review_quality) +
        0.10 * (100 - p.goal_feasibility) +
        0.11 * p.overload_pressure +
        0.09 * p.metric_distortion +
        0.08 * p.incentive_misalignment +
        0.06 * p.proxy_drift
    )
end

profiles = [
    GoalSystemProfile(84, 78, 82, 79, 83, 22, 18, 16, 82, 15, 80),
    GoalSystemProfile(38, 41, 36, 39, 40, 74, 69, 72, 34, 68, 32),
    GoalSystemProfile(73, 69, 71, 67, 72, 35, 33, 34, 69, 32, 69)
]

for (i, profile) in enumerate(profiles)
    effectiveness = goal_system_effectiveness(profile)
    risk = goal_system_risk(profile)
    @printf("Profile %d | Goal-system effectiveness: %.2f | Goal-system risk: %.2f\n",
            i, effectiveness, risk)
end

println("Responsible-use reminder: synthetic goal-system simulation only.")

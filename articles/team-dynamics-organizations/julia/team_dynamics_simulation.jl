# Team Dynamics in Organizations
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# team-system review, collaboration-system education, and reproducible workflows
# only. Not for employee screening, employment selection, team-fit scoring,
# collaboration scoring of workers, productivity ranking, individual performance
# management, or psychological assessment.

using Random
using Printf

Random.seed!(222)

struct TeamDynamicsProfile
    communication_quality::Float64
    trust_level::Float64
    role_clarity::Float64
    psychological_safety::Float64
    leadership_support::Float64
    conflict_load::Float64
    task_ambiguity::Float64
    coordination_cost::Float64
    participation_equity::Float64
    learning_routine_quality::Float64
end

function team_effectiveness(p::TeamDynamicsProfile)
    return (
        0.14 * p.communication_quality +
        0.12 * p.trust_level +
        0.12 * p.role_clarity +
        0.13 * p.psychological_safety +
        0.12 * p.leadership_support +
        0.11 * p.participation_equity +
        0.11 * p.learning_routine_quality -
        0.09 * p.conflict_load -
        0.08 * p.task_ambiguity -
        0.09 * p.coordination_cost
    )
end

function team_system_risk(p::TeamDynamicsProfile)
    return (
        0.11 * (100 - p.communication_quality) +
        0.10 * (100 - p.trust_level) +
        0.11 * (100 - p.role_clarity) +
        0.12 * (100 - p.psychological_safety) +
        0.10 * (100 - p.leadership_support) +
        0.10 * (100 - p.participation_equity) +
        0.10 * (100 - p.learning_routine_quality) +
        0.12 * p.conflict_load +
        0.12 * p.task_ambiguity +
        0.12 * p.coordination_cost
    )
end

profiles = [
    TeamDynamicsProfile(84, 82, 79, 83, 80, 22, 30, 34, 82, 80),
    TeamDynamicsProfile(38, 36, 41, 34, 39, 71, 68, 72, 35, 33),
    TeamDynamicsProfile(73, 70, 67, 71, 69, 35, 42, 48, 71, 68)
]

for (i, profile) in enumerate(profiles)
    effectiveness = team_effectiveness(profile)
    risk = team_system_risk(profile)
    @printf("Profile %d | Team effectiveness: %.2f | Team-system risk: %.2f\n",
            i, effectiveness, risk)
end

println("Responsible-use reminder: synthetic team dynamics simulation only.")

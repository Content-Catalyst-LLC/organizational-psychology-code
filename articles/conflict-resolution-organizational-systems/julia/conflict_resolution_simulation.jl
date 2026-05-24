# Conflict Resolution in Organizational Systems
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# conflict-system review, mediation-process education, and reproducible workflows
# only. Not for employee screening, employment selection, conflict-proneness
# scoring, collaboration scoring of workers, productivity ranking, individual
# performance management, or psychological assessment.

using Random
using Printf

Random.seed!(626)

struct ConflictResolutionProfile
    trust_level::Float64
    communication_clarity::Float64
    psychological_safety::Float64
    procedural_fairness::Float64
    integrative_skill::Float64
    blame_intensity::Float64
    power_asymmetry::Float64
    resource_strain::Float64
    mediation_access::Float64
end

function constructive_conflict_capacity(p::ConflictResolutionProfile)
    return (
        0.16 * p.trust_level +
        0.15 * p.communication_clarity +
        0.14 * p.psychological_safety +
        0.15 * p.procedural_fairness +
        0.12 * p.integrative_skill +
        0.10 * p.mediation_access -
        0.10 * p.blame_intensity -
        0.09 * p.power_asymmetry -
        0.07 * p.resource_strain
    )
end

function conflict_risk_score(p::ConflictResolutionProfile)
    return (
        0.13 * (100 - p.trust_level) +
        0.12 * (100 - p.communication_clarity) +
        0.11 * (100 - p.psychological_safety) +
        0.13 * (100 - p.procedural_fairness) +
        0.10 * (100 - p.integrative_skill) +
        0.10 * (100 - p.mediation_access) +
        0.14 * p.blame_intensity +
        0.13 * p.power_asymmetry +
        0.14 * p.resource_strain
    )
end

profiles = [
    ConflictResolutionProfile(82, 80, 81, 83, 76, 18, 22, 45, 84),
    ConflictResolutionProfile(33, 36, 34, 31, 38, 73, 70, 68, 32),
    ConflictResolutionProfile(71, 68, 69, 67, 65, 35, 39, 55, 69)
]

for (i, profile) in enumerate(profiles)
    capacity = constructive_conflict_capacity(profile)
    risk = conflict_risk_score(profile)
    @printf("Profile %d | Constructive conflict capacity: %.2f | Conflict risk: %.2f\n",
            i, capacity, risk)
end

println("Responsible-use reminder: synthetic conflict resolution simulation only.")

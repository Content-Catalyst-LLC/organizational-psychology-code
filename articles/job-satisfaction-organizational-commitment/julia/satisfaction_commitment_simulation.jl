# Job Satisfaction and Organizational Commitment
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# work-attitude review, retention-system education, and reproducible workflows
# only. Not for employee screening, employment selection, commitment scoring,
# retention-risk scoring of individual workers, productivity ranking,
# individual performance management, or psychological assessment.

using Random
using Printf

Random.seed!(414)

struct SatisfactionCommitmentProfile
    leadership_support::Float64
    reward_fairness::Float64
    developmental_opportunity::Float64
    workload_balance::Float64
    institutional_trust::Float64
    cultural_alignment::Float64
    role_insecurity::Float64
    exhaustion_pressure::Float64
    affective_commitment::Float64
    continuance_commitment::Float64
    normative_commitment::Float64
end

function job_satisfaction_score(p::SatisfactionCommitmentProfile)
    return (
        0.16 * p.leadership_support +
        0.15 * p.reward_fairness +
        0.13 * p.developmental_opportunity +
        0.14 * p.workload_balance +
        0.13 * p.institutional_trust +
        0.10 * p.cultural_alignment -
        0.09 * p.role_insecurity -
        0.10 * p.exhaustion_pressure
    )
end

function organizational_commitment_score(p::SatisfactionCommitmentProfile)
    return (
        0.18 * p.affective_commitment +
        0.12 * p.normative_commitment +
        0.13 * p.institutional_trust +
        0.11 * p.cultural_alignment +
        0.10 * p.leadership_support +
        0.08 * p.developmental_opportunity -
        0.08 * p.role_insecurity -
        0.08 * p.exhaustion_pressure -
        0.04 * p.continuance_commitment
    )
end

function retention_system_risk_score(p::SatisfactionCommitmentProfile)
    satisfaction = job_satisfaction_score(p)
    commitment = organizational_commitment_score(p)
    return (
        0.13 * (100 - satisfaction) +
        0.14 * (100 - commitment) +
        0.11 * (100 - p.institutional_trust) +
        0.10 * (100 - p.reward_fairness) +
        0.10 * (100 - p.workload_balance) +
        0.12 * p.role_insecurity +
        0.14 * p.exhaustion_pressure +
        0.08 * p.continuance_commitment
    )
end

profiles = [
    SatisfactionCommitmentProfile(84, 79, 82, 76, 83, 81, 18, 22, 84, 38, 68),
    SatisfactionCommitmentProfile(34, 31, 36, 28, 29, 33, 72, 74, 28, 78, 42),
    SatisfactionCommitmentProfile(73, 69, 71, 65, 69, 71, 35, 39, 71, 47, 60)
]

for (i, profile) in enumerate(profiles)
    satisfaction = job_satisfaction_score(profile)
    commitment = organizational_commitment_score(profile)
    risk = retention_system_risk_score(profile)
    @printf("Profile %d | Satisfaction: %.2f | Commitment: %.2f | Retention-system risk: %.2f\n",
            i, satisfaction, commitment, risk)
end

println("Responsible-use reminder: synthetic satisfaction and commitment simulation only.")

# Trust and Cooperation in Workplace Teams
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# trust-and-cooperation review, collaboration-system education, and reproducible
# workflows only. Not for employee screening, employment selection,
# trustworthiness scoring, cooperation scoring of workers, productivity ranking,
# individual performance management, or psychological assessment.

using Random
using Printf

Random.seed!(515)

struct TrustCooperationProfile
    competence_trust::Float64
    integrity_trust::Float64
    benevolence_trust::Float64
    reciprocity_norms::Float64
    communication_reliability::Float64
    opportunism_risk::Float64
    power_imbalance::Float64
    uncertainty_load::Float64
    leadership_credibility::Float64
    institutional_trust::Float64
end

function cooperative_capacity(p::TrustCooperationProfile)
    return (
        0.13 * p.competence_trust +
        0.14 * p.integrity_trust +
        0.12 * p.benevolence_trust +
        0.13 * p.reciprocity_norms +
        0.12 * p.communication_reliability +
        0.11 * p.leadership_credibility +
        0.11 * p.institutional_trust -
        0.10 * p.opportunism_risk -
        0.08 * p.power_imbalance -
        0.05 * p.uncertainty_load
    )
end

function trust_risk_score(p::TrustCooperationProfile)
    return (
        0.10 * (100 - p.competence_trust) +
        0.14 * (100 - p.integrity_trust) +
        0.10 * (100 - p.benevolence_trust) +
        0.12 * (100 - p.reciprocity_norms) +
        0.10 * (100 - p.communication_reliability) +
        0.10 * (100 - p.leadership_credibility) +
        0.12 * (100 - p.institutional_trust) +
        0.14 * p.opportunism_risk +
        0.10 * p.power_imbalance +
        0.08 * p.uncertainty_load
    )
end

profiles = [
    TrustCooperationProfile(84, 82, 78, 81, 83, 16, 20, 52, 84, 82),
    TrustCooperationProfile(43, 36, 34, 39, 41, 72, 69, 52, 34, 32),
    TrustCooperationProfile(73, 69, 66, 68, 70, 35, 39, 60, 71, 69)
]

for (i, profile) in enumerate(profiles)
    capacity = cooperative_capacity(profile)
    risk = trust_risk_score(profile)
    @printf("Profile %d | Cooperative capacity: %.2f | Trust risk: %.2f\n",
            i, capacity, risk)
end

println("Responsible-use reminder: synthetic trust and cooperation simulation only.")

# Institutional Values and Behavioral Expectations
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# values-governance review, organizational ethics education, legitimacy analysis,
# and reproducible workflows only. Not for employee screening, employment
# selection, cultural-loyalty scoring, morality scoring, values-alignment scoring
# of workers, productivity ranking, individual performance management, or
# psychological assessment.

using Random
using Printf

Random.seed!(606)

struct InstitutionalValuesProfile
    value_clarity::Float64
    leadership_consistency::Float64
    reinforcement_alignment::Float64
    psychological_safety::Float64
    accountability_strength::Float64
    decoupling_risk::Float64
    incentive_contradiction::Float64
    hierarchy_exemption::Float64
    legitimacy_pressure::Float64
end

function value_practice_alignment(p::InstitutionalValuesProfile)
    return (
        0.17 * p.value_clarity +
        0.16 * p.leadership_consistency +
        0.16 * p.reinforcement_alignment +
        0.14 * p.psychological_safety +
        0.14 * p.accountability_strength -
        0.10 * p.decoupling_risk -
        0.09 * p.incentive_contradiction -
        0.09 * p.hierarchy_exemption -
        0.05 * p.legitimacy_pressure
    )
end

function institutional_values_risk(p::InstitutionalValuesProfile)
    return (
        0.12 * (100 - p.value_clarity) +
        0.14 * (100 - p.leadership_consistency) +
        0.14 * (100 - p.reinforcement_alignment) +
        0.10 * (100 - p.psychological_safety) +
        0.14 * (100 - p.accountability_strength) +
        0.14 * p.decoupling_risk +
        0.10 * p.incentive_contradiction +
        0.08 * p.hierarchy_exemption +
        0.04 * p.legitimacy_pressure
    )
end

profiles = [
    InstitutionalValuesProfile(86, 83, 81, 82, 80, 16, 20, 12, 58),
    InstitutionalValuesProfile(48, 36, 31, 38, 34, 74, 70, 76, 58),
    InstitutionalValuesProfile(71, 66, 63, 69, 65, 35, 40, 31, 60)
]

for (i, profile) in enumerate(profiles)
    alignment = value_practice_alignment(profile)
    risk = institutional_values_risk(profile)
    @printf("Profile %d | Value-practice alignment: %.2f | Institutional values risk: %.2f\n",
            i, alignment, risk)
end

println("Responsible-use reminder: synthetic institutional values simulation only.")

# Authority and Power in Institutional Leadership
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# authority/governance-system review, legitimacy and procedural-fairness
# analysis, ethical-leadership education, and reproducible workflows only.
# Not for employee screening, employment selection, productivity ranking,
# loyalty scoring, political-influence scoring, dissent tracking, individual
# performance management, workplace surveillance, or psychological assessment.

using Random
using Printf

Random.seed!(626)

struct AuthorityGovernanceProfile
    formal_legitimacy::Float64
    procedural_fairness::Float64
    informational_access::Float64
    practical_influence::Float64
    ethical_credibility::Float64
    accountability_quality::Float64
    voice_access::Float64
    oversight_strength::Float64
    arbitrariness_risk::Float64
    governance_fragmentation::Float64
    distrust_pressure::Float64
    informal_power_concentration::Float64
end

function authority_effectiveness(p::AuthorityGovernanceProfile)
    return (
        0.12 * p.formal_legitimacy +
        0.12 * p.procedural_fairness +
        0.10 * p.informational_access +
        0.10 * p.practical_influence +
        0.12 * p.ethical_credibility +
        0.11 * p.accountability_quality +
        0.10 * p.voice_access +
        0.09 * p.oversight_strength -
        0.08 * p.arbitrariness_risk -
        0.07 * p.governance_fragmentation -
        0.07 * p.distrust_pressure -
        0.05 * p.informal_power_concentration
    )
end

function governance_risk(p::AuthorityGovernanceProfile)
    return (
        0.11 * (100 - p.formal_legitimacy) +
        0.12 * (100 - p.procedural_fairness) +
        0.08 * (100 - p.informational_access) +
        0.08 * (100 - p.practical_influence) +
        0.12 * (100 - p.ethical_credibility) +
        0.11 * (100 - p.accountability_quality) +
        0.09 * (100 - p.voice_access) +
        0.08 * (100 - p.oversight_strength) +
        0.10 * p.arbitrariness_risk +
        0.09 * p.governance_fragmentation +
        0.09 * p.distrust_pressure +
        0.08 * p.informal_power_concentration
    )
end

profiles = [
    AuthorityGovernanceProfile(84, 82, 79, 81, 83, 82, 80, 78, 18, 24, 20, 22),
    AuthorityGovernanceProfile(39, 34, 41, 38, 33, 35, 31, 34, 72, 69, 74, 76),
    AuthorityGovernanceProfile(73, 69, 71, 70, 72, 69, 67, 66, 35, 39, 37, 41)
]

for (i, profile) in enumerate(profiles)
    effectiveness = authority_effectiveness(profile)
    risk = governance_risk(profile)
    @printf("Profile %d | Authority effectiveness: %.2f | Governance risk: %.2f\n",
            i, effectiveness, risk)
end

println("Responsible-use reminder: synthetic authority/governance simulation only.")

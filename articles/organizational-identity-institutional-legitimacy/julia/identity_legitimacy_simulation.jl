# Organizational Identity and Institutional Legitimacy
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational identity review, legitimacy analysis, governance review,
# and reproducible workflows only. Not for employee screening, employment
# selection, cultural-loyalty scoring, worker legitimacy scoring,
# productivity ranking, individual performance management, or psychological assessment.

using Random
using Printf

Random.seed!(212)

struct IdentityLegitimacyProfile
    mission_clarity::Float64
    value_practice_alignment::Float64
    narrative_continuity::Float64
    leadership_credibility::Float64
    behavioral_consistency::Float64
    internal_fragmentation::Float64
    identity_contradiction::Float64
    legitimacy_pressure::Float64
end

function identity_coherence(p::IdentityLegitimacyProfile)
    return (
        0.18 * p.mission_clarity +
        0.17 * p.value_practice_alignment +
        0.15 * p.narrative_continuity +
        0.14 * p.leadership_credibility +
        0.14 * p.behavioral_consistency -
        0.10 * p.internal_fragmentation -
        0.07 * p.identity_contradiction -
        0.05 * p.legitimacy_pressure
    )
end

function identity_risk(p::IdentityLegitimacyProfile)
    return (
        0.14 * (100 - p.mission_clarity) +
        0.16 * (100 - p.value_practice_alignment) +
        0.10 * (100 - p.narrative_continuity) +
        0.12 * (100 - p.leadership_credibility) +
        0.10 * (100 - p.behavioral_consistency) +
        0.12 * p.internal_fragmentation +
        0.16 * p.identity_contradiction +
        0.10 * p.legitimacy_pressure
    )
end

profiles = [
    IdentityLegitimacyProfile(86, 82, 79, 81, 80, 20, 16, 60),
    IdentityLegitimacyProfile(44, 36, 41, 39, 38, 69, 72, 60),
    IdentityLegitimacyProfile(71, 66, 67, 65, 64, 39, 35, 60)
]

for (i, profile) in enumerate(profiles)
    coherence = identity_coherence(profile)
    risk = identity_risk(profile)
    @printf("Profile %d | Identity coherence: %.2f | Identity risk: %.2f\n",
            i, coherence, risk)
end

println("Responsible-use reminder: synthetic identity-legitimacy simulation only.")

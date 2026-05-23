# Culture Change in Organizations
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# culture-change review, organizational development education, and reproducible
# workflows only. Not for employee screening, employment selection,
# cultural-loyalty scoring, productivity ranking, individual performance
# management, or psychological assessment.

using Random
using Printf

Random.seed!(818)

struct CultureChangeProfile
    leadership_credibility::Float64
    narrative_coherence::Float64
    reinforcement_alignment::Float64
    adaptive_learning::Float64
    psychological_safety::Float64
    identity_adaptability::Float64
    resistance_intensity::Float64
    subcultural_fragmentation::Float64
    legacy_lock_in::Float64
    leadership_turnover::Float64
end

function culture_change_capacity(p::CultureChangeProfile)
    return (
        0.17 * p.leadership_credibility +
        0.15 * p.narrative_coherence +
        0.15 * p.reinforcement_alignment +
        0.14 * p.adaptive_learning +
        0.13 * p.psychological_safety +
        0.11 * p.identity_adaptability -
        0.12 * p.resistance_intensity -
        0.10 * p.subcultural_fragmentation -
        0.11 * p.legacy_lock_in -
        4.00 * p.leadership_turnover
    )
end

function culture_risk(p::CultureChangeProfile)
    return (
        0.14 * (100 - p.leadership_credibility) +
        0.10 * (100 - p.narrative_coherence) +
        0.14 * (100 - p.reinforcement_alignment) +
        0.10 * (100 - p.adaptive_learning) +
        0.10 * (100 - p.psychological_safety) +
        0.08 * (100 - p.identity_adaptability) +
        0.14 * p.resistance_intensity +
        0.10 * p.subcultural_fragmentation +
        0.08 * p.legacy_lock_in +
        2.00 * p.leadership_turnover
    )
end

profiles = [
    CultureChangeProfile(84, 82, 81, 80, 83, 76, 22, 26, 29, 0),
    CultureChangeProfile(34, 39, 31, 42, 36, 41, 72, 68, 74, 1),
    CultureChangeProfile(70, 66, 63, 67, 69, 64, 40, 42, 49, 0)
]

for (i, profile) in enumerate(profiles)
    capacity = culture_change_capacity(profile)
    risk = culture_risk(profile)
    @printf("Profile %d | Culture change capacity: %.2f | Culture risk: %.2f\n",
            i, capacity, risk)
end

println("Responsible-use reminder: synthetic culture-change simulation only.")

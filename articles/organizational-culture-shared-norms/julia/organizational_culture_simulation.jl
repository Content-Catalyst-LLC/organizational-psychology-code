# Organizational Culture and Shared Norms
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# culture review, organizational development education, legitimacy analysis,
# and reproducible workflows only. Not for employee screening, employment
# selection, cultural-loyalty scoring, cultural-fit scoring, productivity ranking,
# individual performance management, or psychological assessment.

using Random
using Printf

Random.seed!(303)

struct CultureProfile
    value_alignment::Float64
    normative_consistency::Float64
    leadership_credibility::Float64
    psychological_safety::Float64
    shared_meaning::Float64
    contradiction::Float64
    fragmentation::Float64
    incentive_distortion::Float64
    external_pressure::Float64
end

function cultural_coherence(p::CultureProfile)
    return (
        0.18 * p.value_alignment +
        0.16 * p.normative_consistency +
        0.15 * p.leadership_credibility +
        0.14 * p.psychological_safety +
        0.14 * p.shared_meaning -
        0.10 * p.contradiction -
        0.08 * p.fragmentation -
        0.10 * p.incentive_distortion -
        0.05 * p.external_pressure
    )
end

function culture_risk(p::CultureProfile)
    return (
        0.14 * (100 - p.value_alignment) +
        0.12 * (100 - p.normative_consistency) +
        0.12 * (100 - p.leadership_credibility) +
        0.12 * (100 - p.psychological_safety) +
        0.12 * (100 - p.shared_meaning) +
        0.14 * p.contradiction +
        0.10 * p.fragmentation +
        0.10 * p.incentive_distortion +
        0.04 * p.external_pressure
    )
end

profiles = [
    CultureProfile(84, 80, 81, 84, 82, 16, 22, 20, 58),
    CultureProfile(39, 41, 36, 34, 38, 73, 69, 71, 58),
    CultureProfile(71, 67, 66, 69, 68, 35, 39, 40, 60)
]

for (i, profile) in enumerate(profiles)
    coherence = cultural_coherence(profile)
    risk = culture_risk(profile)
    @printf("Profile %d | Cultural coherence: %.2f | Culture risk: %.2f\n",
            i, coherence, risk)
end

println("Responsible-use reminder: synthetic organizational culture simulation only.")

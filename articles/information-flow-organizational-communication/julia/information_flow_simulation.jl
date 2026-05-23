# Information Flow and Organizational Communication
# Synthetic Julia simulation.
#
# Responsible-use scope:
# Synthetic-data research, methods demonstration, institutional learning,
# organizational communication review, knowledge-flow governance, and reproducible
# workflows only. Not for employee screening, employment selection,
# communication surveillance, productivity ranking, individual performance
# management, or psychological assessment.

using Random
using Printf

Random.seed!(515)

struct InformationFlowProfile
    signal_quality::Float64
    timeliness::Float64
    interpretive_clarity::Float64
    cross_functional_connectivity::Float64
    psychological_safety::Float64
    distortion_risk::Float64
    overload_pressure::Float64
    hierarchy_delay::Float64
    external_signal_turbulence::Float64
end

function information_flow_quality(p::InformationFlowProfile)
    return (
        0.18 * p.signal_quality +
        0.15 * p.timeliness +
        0.15 * p.interpretive_clarity +
        0.14 * p.cross_functional_connectivity +
        0.13 * p.psychological_safety -
        0.10 * p.distortion_risk -
        0.08 * p.overload_pressure -
        0.10 * p.hierarchy_delay -
        0.05 * p.external_signal_turbulence
    )
end

function communication_risk(p::InformationFlowProfile)
    return (
        0.16 * (100 - p.signal_quality) +
        0.13 * (100 - p.timeliness) +
        0.12 * (100 - p.interpretive_clarity) +
        0.11 * (100 - p.cross_functional_connectivity) +
        0.12 * (100 - p.psychological_safety) +
        0.13 * p.distortion_risk +
        0.10 * p.overload_pressure +
        0.09 * p.hierarchy_delay +
        0.04 * p.external_signal_turbulence
    )
end

profiles = [
    InformationFlowProfile(84, 82, 80, 79, 83, 14, 32, 18, 58),
    InformationFlowProfile(46, 41, 38, 35, 31, 71, 72, 68, 58),
    InformationFlowProfile(70, 66, 64, 62, 67, 35, 50, 42, 60)
]

for (i, profile) in enumerate(profiles)
    quality = information_flow_quality(profile)
    risk = communication_risk(profile)
    @printf("Profile %d | Information flow quality: %.2f | Communication risk: %.2f\n",
            i, quality, risk)
end

println("Responsible-use reminder: synthetic organizational communication simulation only.")

# Leadership in Organizational Psychology
# Synthetic Julia simulation. Institutional learning only; not for employment decisions.

using Printf

struct LeadershipCapacityProfile
    trust_generation::Float64
    communication_clarity::Float64
    motivational_support::Float64
    legitimacy_quality::Float64
    adaptive_coordination::Float64
    psychological_safety::Float64
    role_clarity::Float64
    ethical_accountability::Float64
    decision_transparency::Float64
    voice_access::Float64
    ambiguity_pressure::Float64
    distrust_pressure::Float64
    fragmentation_pressure::Float64
    overload_pressure::Float64
end

function leadership_capacity(p::LeadershipCapacityProfile)
    return 0.11*p.trust_generation + 0.11*p.communication_clarity +
           0.10*p.motivational_support + 0.11*p.legitimacy_quality +
           0.10*p.adaptive_coordination + 0.10*p.psychological_safety +
           0.08*p.role_clarity + 0.09*p.ethical_accountability +
           0.08*p.decision_transparency + 0.08*p.voice_access -
           0.07*p.ambiguity_pressure - 0.08*p.distrust_pressure -
           0.07*p.fragmentation_pressure - 0.06*p.overload_pressure
end

profiles = [
    LeadershipCapacityProfile(83,81,79,82,80,81,80,82,81,80,20,18,22,24),
    LeadershipCapacityProfile(34,38,36,32,39,33,36,31,35,32,71,73,69,70)
]

for (i, profile) in enumerate(profiles)
    @printf("Profile %d | Leadership capacity: %.2f\n", i, leadership_capacity(profile))
end

println("Responsible-use reminder: synthetic leadership-capacity simulation only.")

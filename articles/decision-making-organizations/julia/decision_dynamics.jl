using Statistics
using Random

Random.seed!(42)

state = [
    0.76, # information quality
    0.72, # psychological safety
    0.70, # incentive alignment
    0.68, # interpretive diversity
    0.52, # coordination load
    0.55, # time pressure
    0.42, # bias pressure
    0.30, # leadership fragmentation
    0.34, # metric distortion
    0.70, # learning capacity
    0.72  # decision quality
]

function decision_quality_index(s)
    return mean(s[[1,2,3,4,10]]) - mean(s[[5,6,7,8,9]])
end

function institutional_risk_index(s)
    return mean([1-s[1], 1-s[2], 1-s[3], s[5], s[6], s[7], s[8], s[9]])
end

for t in 1:24
    if t == 8
        state[5] += 0.08
        state[6] += 0.07
        state[7] += 0.07
        state[11] -= 0.05
    end

    if t >= 12
        state[1] += 0.008
        state[2] += 0.010
        state[9] -= 0.007
        state[10] += 0.010
        state[11] += 0.008
    end

    state = clamp.(state, 0.0, 1.0)
end

println("Decision quality index: ", round(decision_quality_index(state), digits=3))
println("Institutional risk index: ", round(institutional_risk_index(state), digits=3))

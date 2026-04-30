# Toy organizational trust update model.

trust = 0.45
competence = 0.75
fairness = 0.70
psychological_safety = 0.65
violation = 0.20
learning_rate = 0.08

for t in 1:12
    trust = trust + learning_rate * (0.30 * competence + 0.30 * fairness + 0.25 * psychological_safety - 0.35 * violation)
    trust = clamp(trust, 0.0, 1.0)
    println("Time ", t, ": trust = ", round(trust, digits=3))
end

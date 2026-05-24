/*
Human Behavior in Organizations
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
loyalty scoring, dissent tracking, or individual worker decisions.
*/

#include <cmath>
#include <iostream>

struct HumanBehaviorProfile {
    double capability;
    double motivation;
    double role_clarity;
    double psychological_safety;
    double leadership_trust;
    double cultural_norm_strength;
    double incentive_alignment;
    double workload_pressure;
    double burnout_pressure;
    double hierarchical_pressure;
    double perceived_voice_efficacy;
    double fear_of_retaliation;
};

double behavior_quality_score(const HumanBehaviorProfile& p) {
    return
        0.16 * p.capability +
        0.15 * p.motivation +
        0.14 * p.role_clarity +
        0.12 * p.psychological_safety +
        0.12 * p.leadership_trust +
        0.10 * p.cultural_norm_strength +
        0.09 * p.incentive_alignment -
        0.08 * p.workload_pressure -
        0.08 * p.burnout_pressure -
        0.06 * p.hierarchical_pressure;
}

double voice_probability(const HumanBehaviorProfile& p) {
    double z = -2.0 +
        0.030 * p.psychological_safety +
        0.024 * p.leadership_trust +
        0.022 * p.perceived_voice_efficacy -
        0.026 * p.fear_of_retaliation -
        0.020 * p.hierarchical_pressure;
    return 1.0 / (1.0 + std::exp(-z));
}

int main() {
    HumanBehaviorProfile profile{72, 78, 82, 84, 85, 82, 80, 30, 24, 22, 80, 12};
    std::cout << "Synthetic behavior quality: "
              << behavior_quality_score(profile) << "\n";
    std::cout << "Synthetic voice probability: "
              << voice_probability(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

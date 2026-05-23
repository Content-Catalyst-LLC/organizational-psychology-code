/*
Learning Organizations and Knowledge Systems
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment or individual worker decisions.
*/

#include <iostream>

struct LearningProfile {
    double information_quality;
    double interpretive_openness;
    double memory_retention;
    double communication_flow;
    double psychological_safety;
    double governance_support;
    double complexity_load;
    double silo_intensity;
    double incentive_distortion;
    double turnover_pressure;
};

double learning_capacity(const LearningProfile& p) {
    return
        0.17 * p.information_quality +
        0.18 * p.interpretive_openness +
        0.15 * p.memory_retention +
        0.15 * p.communication_flow +
        0.13 * p.psychological_safety +
        0.10 * p.governance_support -
        0.07 * p.complexity_load -
        0.10 * p.silo_intensity -
        0.10 * p.incentive_distortion -
        0.05 * p.turnover_pressure;
}

int main() {
    LearningProfile profile{84, 82, 83, 86, 84, 78, 48, 20, 17, 19};
    std::cout << "Synthetic institutional learning capacity score: "
              << learning_capacity(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

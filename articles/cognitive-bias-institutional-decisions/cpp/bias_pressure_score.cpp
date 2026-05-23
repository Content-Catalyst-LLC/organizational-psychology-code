/*
Cognitive Bias in Institutional Decisions
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, executive ranking,
productivity ranking, or individual worker decisions.
*/

#include <iostream>

struct BiasPressureProfile {
    double signal_quality;
    double viewpoint_diversity;
    double analytical_discipline;
    double structured_challenge;
    double hierarchy_suppression;
    double time_pressure;
    double routine_reinforcement;
    double learning_review;
    double group_conformity;
};

double bias_pressure_score(const BiasPressureProfile& p) {
    return
        0.16 * p.hierarchy_suppression +
        0.15 * p.time_pressure +
        0.14 * p.routine_reinforcement +
        0.13 * p.group_conformity -
        0.16 * p.viewpoint_diversity -
        0.13 * p.analytical_discipline -
        0.14 * p.structured_challenge -
        0.12 * p.learning_review -
        0.10 * p.signal_quality;
}

int main() {
    BiasPressureProfile profile{84, 80, 82, 81, 14, 38, 36, 79, 28};
    std::cout << "Synthetic bias pressure score: "
              << bias_pressure_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

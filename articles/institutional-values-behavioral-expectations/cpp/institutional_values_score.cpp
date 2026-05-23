/*
Institutional Values and Behavioral Expectations
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
morality scoring, productivity ranking, or individual worker decisions.
*/

#include <iostream>

struct InstitutionalValuesProfile {
    double value_clarity;
    double leadership_consistency;
    double reinforcement_alignment;
    double psychological_safety;
    double accountability_strength;
    double decoupling_risk;
    double incentive_contradiction;
    double hierarchy_exemption;
    double legitimacy_pressure;
};

double value_practice_alignment_score(const InstitutionalValuesProfile& p) {
    return
        0.17 * p.value_clarity +
        0.16 * p.leadership_consistency +
        0.16 * p.reinforcement_alignment +
        0.14 * p.psychological_safety +
        0.14 * p.accountability_strength -
        0.10 * p.decoupling_risk -
        0.09 * p.incentive_contradiction -
        0.09 * p.hierarchy_exemption -
        0.05 * p.legitimacy_pressure;
}

int main() {
    InstitutionalValuesProfile profile{86, 83, 81, 82, 80, 16, 20, 12, 58};
    std::cout << "Synthetic value-practice alignment score: "
              << value_practice_alignment_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

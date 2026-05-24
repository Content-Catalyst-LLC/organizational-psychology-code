/*
Organizations as Complex Behavioral Systems
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
loyalty scoring, dissent tracking, or individual worker decisions.
*/

#include <iostream>

struct ComplexSystemProfile {
    double psychological_safety;
    double leadership_trust;
    double cultural_coherence;
    double incentive_alignment;
    double information_flow;
    double learning_capacity;
    double redundancy_slack;
    double workload_pressure;
    double silence_risk;
    double fragmentation_pressure;
    double environmental_uncertainty;
};

double complex_system_risk_score(const ComplexSystemProfile& p) {
    return
        0.11 * (100.0 - p.psychological_safety) +
        0.11 * (100.0 - p.leadership_trust) +
        0.09 * (100.0 - p.cultural_coherence) +
        0.09 * (100.0 - p.incentive_alignment) +
        0.09 * (100.0 - p.information_flow) +
        0.10 * (100.0 - p.learning_capacity) +
        0.08 * (100.0 - p.redundancy_slack) +
        0.09 * p.workload_pressure +
        0.08 * p.silence_risk +
        0.10 * p.fragmentation_pressure +
        0.08 * p.environmental_uncertainty;
}

int main() {
    ComplexSystemProfile profile{84, 85, 82, 80, 83, 82, 68, 30, 18, 22, 42};
    std::cout << "Synthetic complex system risk score: "
              << complex_system_risk_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

/*
Adaptive Organizations: Institutional Change and Strategic Transformation
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment or individual worker decisions.
*/

#include <iostream>

struct AdaptiveChangeProfile {
    double sensing_quality;
    double interpretive_coherence;
    double governance_alignment;
    double learning_capability;
    double resource_flexibility;
    double institutional_legitimacy;
    double organizational_inertia;
    double fragmentation;
    double resistance_friction;
    double environmental_pressure;
};

double adaptive_change_capacity(const AdaptiveChangeProfile& p) {
    return
        0.17 * p.sensing_quality +
        0.16 * p.interpretive_coherence +
        0.15 * p.governance_alignment +
        0.16 * p.learning_capability +
        0.12 * p.resource_flexibility +
        0.12 * p.institutional_legitimacy -
        0.13 * p.organizational_inertia -
        0.11 * p.fragmentation -
        0.10 * p.resistance_friction -
        0.05 * p.environmental_pressure;
}

int main() {
    AdaptiveChangeProfile profile{84, 81, 79, 83, 74, 80, 20, 18, 24, 62};
    std::cout << "Synthetic adaptive change capacity score: "
              << adaptive_change_capacity(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

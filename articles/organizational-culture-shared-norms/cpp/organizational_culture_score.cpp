/*
Organizational Culture and Shared Norms
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
cultural-fit scoring, productivity ranking, or individual worker decisions.
*/

#include <iostream>

struct CultureProfile {
    double value_alignment;
    double normative_consistency;
    double leadership_credibility;
    double psychological_safety;
    double shared_meaning;
    double contradiction;
    double fragmentation;
    double incentive_distortion;
    double external_pressure;
};

double cultural_coherence_score(const CultureProfile& p) {
    return
        0.18 * p.value_alignment +
        0.16 * p.normative_consistency +
        0.15 * p.leadership_credibility +
        0.14 * p.psychological_safety +
        0.14 * p.shared_meaning -
        0.10 * p.contradiction -
        0.08 * p.fragmentation -
        0.10 * p.incentive_distortion -
        0.05 * p.external_pressure;
}

int main() {
    CultureProfile profile{84, 80, 81, 84, 82, 16, 22, 20, 58};
    std::cout << "Synthetic cultural coherence score: "
              << cultural_coherence_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

/*
Culture Change in Organizations
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
productivity ranking, or individual worker decisions.
*/

#include <iostream>

struct CultureChangeProfile {
    double leadership_credibility;
    double narrative_coherence;
    double reinforcement_alignment;
    double adaptive_learning;
    double psychological_safety;
    double identity_adaptability;
    double resistance_intensity;
    double subcultural_fragmentation;
    double legacy_lock_in;
    double leadership_turnover;
};

double culture_change_capacity(const CultureChangeProfile& p) {
    return
        0.17 * p.leadership_credibility +
        0.15 * p.narrative_coherence +
        0.15 * p.reinforcement_alignment +
        0.14 * p.adaptive_learning +
        0.13 * p.psychological_safety +
        0.11 * p.identity_adaptability -
        0.12 * p.resistance_intensity -
        0.10 * p.subcultural_fragmentation -
        0.11 * p.legacy_lock_in -
        4.00 * p.leadership_turnover;
}

int main() {
    CultureChangeProfile profile{84, 82, 81, 80, 83, 76, 22, 26, 29, 0};
    std::cout << "Synthetic culture change capacity score: "
              << culture_change_capacity(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

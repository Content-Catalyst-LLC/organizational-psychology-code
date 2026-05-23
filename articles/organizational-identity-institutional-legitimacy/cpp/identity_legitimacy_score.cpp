/*
Organizational Identity and Institutional Legitimacy
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
worker legitimacy scoring, productivity ranking, or individual worker decisions.
*/

#include <iostream>

struct IdentityLegitimacyProfile {
    double mission_clarity;
    double value_practice_alignment;
    double narrative_continuity;
    double leadership_credibility;
    double behavioral_consistency;
    double internal_fragmentation;
    double identity_contradiction;
    double legitimacy_pressure;
};

double identity_coherence_score(const IdentityLegitimacyProfile& p) {
    return
        0.18 * p.mission_clarity +
        0.17 * p.value_practice_alignment +
        0.15 * p.narrative_continuity +
        0.14 * p.leadership_credibility +
        0.14 * p.behavioral_consistency -
        0.10 * p.internal_fragmentation -
        0.07 * p.identity_contradiction -
        0.05 * p.legitimacy_pressure;
}

int main() {
    IdentityLegitimacyProfile profile{86, 82, 79, 81, 80, 20, 16, 60};
    std::cout << "Synthetic identity coherence score: "
              << identity_coherence_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

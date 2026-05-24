/*
Authority and Power in Institutional Leadership
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
loyalty scoring, political-influence scoring, dissent tracking, or individual
worker decisions.
*/

#include <iostream>

struct AuthorityGovernanceProfile {
    double formal_legitimacy;
    double procedural_fairness;
    double informational_access;
    double practical_influence;
    double ethical_credibility;
    double accountability_quality;
    double voice_access;
    double oversight_strength;
    double arbitrariness_risk;
    double governance_fragmentation;
    double distrust_pressure;
    double informal_power_concentration;
};

double authority_effectiveness_score(const AuthorityGovernanceProfile& p) {
    return
        0.12 * p.formal_legitimacy +
        0.12 * p.procedural_fairness +
        0.10 * p.informational_access +
        0.10 * p.practical_influence +
        0.12 * p.ethical_credibility +
        0.11 * p.accountability_quality +
        0.10 * p.voice_access +
        0.09 * p.oversight_strength -
        0.08 * p.arbitrariness_risk -
        0.07 * p.governance_fragmentation -
        0.07 * p.distrust_pressure -
        0.05 * p.informal_power_concentration;
}

int main() {
    AuthorityGovernanceProfile profile{84, 82, 79, 81, 83, 82, 80, 78, 18, 24, 20, 22};
    std::cout << "Synthetic authority effectiveness score: "
              << authority_effectiveness_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

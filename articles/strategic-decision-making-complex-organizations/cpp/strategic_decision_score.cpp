/*
Strategic Decision-Making in Complex Organizations
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, executive ranking,
or individual worker decisions.
*/

#include <iostream>

struct StrategicDecisionProfile {
    double sensing_quality;
    double interpretive_coherence;
    double knowledge_integration;
    double option_diversity;
    double governance_quality;
    double adaptive_learning;
    double bias_pressure;
    double political_distortion;
    double complexity_load;
    double environmental_turbulence;
};

double strategic_decision_quality(const StrategicDecisionProfile& p) {
    return
        0.17 * p.sensing_quality +
        0.16 * p.interpretive_coherence +
        0.16 * p.knowledge_integration +
        0.12 * p.option_diversity +
        0.13 * p.governance_quality +
        0.14 * p.adaptive_learning -
        0.12 * p.bias_pressure -
        0.10 * p.political_distortion -
        0.09 * p.complexity_load -
        0.08 * p.environmental_turbulence;
}

int main() {
    StrategicDecisionProfile profile{84, 79, 82, 74, 77, 81, 18, 14, 58, 62};
    std::cout << "Synthetic strategic decision quality score: "
              << strategic_decision_quality(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

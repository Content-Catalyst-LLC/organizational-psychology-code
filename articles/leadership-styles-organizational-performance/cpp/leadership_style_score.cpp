/*
Leadership Styles and Organizational Performance
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
leadership-loyalty scoring, dissent tracking, or individual worker decisions.
*/

#include <iostream>

struct LeadershipStyleProfile {
    double participative_behavior;
    double structural_guidance;
    double communication_quality;
    double trust_generation;
    double developmental_support;
    double psychological_safety;
    double decision_fit;
    double cultural_alignment;
    double control_pressure;
    double ambiguity_risk;
    double disengagement_pressure;
};

double leadership_effectiveness_score(const LeadershipStyleProfile& p) {
    return
        0.11 * p.participative_behavior +
        0.12 * p.structural_guidance +
        0.13 * p.communication_quality +
        0.13 * p.trust_generation +
        0.11 * p.developmental_support +
        0.12 * p.psychological_safety +
        0.11 * p.decision_fit +
        0.10 * p.cultural_alignment -
        0.08 * p.control_pressure -
        0.07 * p.ambiguity_risk -
        0.07 * p.disengagement_pressure;
}

int main() {
    LeadershipStyleProfile profile{82, 80, 83, 81, 79, 80, 82, 81, 18, 22, 20};
    std::cout << "Synthetic leadership effectiveness score: "
              << leadership_effectiveness_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

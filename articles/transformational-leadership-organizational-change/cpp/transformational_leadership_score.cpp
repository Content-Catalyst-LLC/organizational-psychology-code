/*
Transformational Leadership and Organizational Change
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
leadership-loyalty scoring, dissent tracking, or individual worker decisions.
*/

#include <iostream>

struct TransformationalLeadershipProfile {
    double vision_credibility;
    double motivational_alignment;
    double intellectual_stimulation;
    double developmental_support;
    double institutional_trust;
    double psychological_safety;
    double change_communication;
    double implementation_support;
    double meaning_making_quality;
    double resistance_intensity;
    double ambiguity_pressure;
    double change_fatigue;
};

double transformational_capacity_score(const TransformationalLeadershipProfile& p) {
    return
        0.12 * p.vision_credibility +
        0.11 * p.motivational_alignment +
        0.11 * p.intellectual_stimulation +
        0.10 * p.developmental_support +
        0.12 * p.institutional_trust +
        0.11 * p.psychological_safety +
        0.10 * p.change_communication +
        0.09 * p.implementation_support +
        0.10 * p.meaning_making_quality -
        0.08 * p.resistance_intensity -
        0.07 * p.ambiguity_pressure -
        0.08 * p.change_fatigue;
}

int main() {
    TransformationalLeadershipProfile profile{84, 81, 80, 79, 82, 80, 83, 78, 82, 20, 22, 24};
    std::cout << "Synthetic transformational capacity score: "
              << transformational_capacity_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

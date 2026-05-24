/*
Psychological Safety in High-Performing Teams
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
courage scoring, voice scoring, productivity ranking, or individual decisions.
*/

#include <iostream>

struct PsychologicalSafetyProfile {
    double leadership_openness;
    double inclusion_quality;
    double learning_review_quality;
    double knowledge_sharing;
    double blame_intensity;
    double status_asymmetry;
    double perceived_penalty;
    double workload_pressure;
};

double psychological_safety_score(const PsychologicalSafetyProfile& p) {
    return
        0.18 * p.leadership_openness +
        0.16 * p.inclusion_quality +
        0.15 * p.learning_review_quality +
        0.14 * p.knowledge_sharing -
        0.13 * p.blame_intensity -
        0.11 * p.status_asymmetry -
        0.10 * p.perceived_penalty -
        0.06 * p.workload_pressure;
}

int main() {
    PsychologicalSafetyProfile profile{84, 82, 80, 81, 16, 20, 18, 52};
    std::cout << "Synthetic psychological safety score: "
              << psychological_safety_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

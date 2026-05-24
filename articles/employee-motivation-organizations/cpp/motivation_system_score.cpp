/*
Employee Motivation in Organizations
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
motivation scoring, loyalty scoring, or individual worker decisions.
*/

#include <iostream>

struct MotivationSystemProfile {
    double autonomy_support;
    double competence_development;
    double recognition_quality;
    double institutional_trust;
    double goal_clarity;
    double fairness_perception;
    double workload_strain;
    double control_pressure;
    double relatedness;
    double meaningful_work;
    double psychological_safety;
    double leadership_credibility;
};

double motivation_quality_score(const MotivationSystemProfile& p) {
    return
        0.12 * p.autonomy_support +
        0.11 * p.competence_development +
        0.10 * p.recognition_quality +
        0.12 * p.institutional_trust +
        0.10 * p.goal_clarity +
        0.11 * p.fairness_perception +
        0.10 * p.relatedness +
        0.11 * p.meaningful_work +
        0.10 * p.psychological_safety +
        0.10 * p.leadership_credibility -
        0.08 * p.workload_strain -
        0.07 * p.control_pressure;
}

int main() {
    MotivationSystemProfile profile{84, 80, 79, 82, 83, 81, 22, 18, 82, 84, 80, 82};
    std::cout << "Synthetic motivation quality score: "
              << motivation_quality_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

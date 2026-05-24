/*
Goal Setting and Performance Systems
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
goal-compliance scoring, cultural-loyalty scoring, or individual worker decisions.
*/

#include <iostream>

struct GoalSystemProfile {
    double goal_clarity;
    double goal_challenge;
    double feedback_quality;
    double employee_commitment;
    double strategic_alignment;
    double overload_pressure;
    double metric_distortion;
    double incentive_misalignment;
    double review_quality;
    double proxy_drift;
    double goal_feasibility;
};

double goal_system_effectiveness_score(const GoalSystemProfile& p) {
    return
        0.13 * p.goal_clarity +
        0.10 * p.goal_challenge +
        0.13 * p.feedback_quality +
        0.11 * p.employee_commitment +
        0.13 * p.strategic_alignment +
        0.11 * p.review_quality +
        0.11 * p.goal_feasibility -
        0.07 * p.overload_pressure -
        0.06 * p.metric_distortion -
        0.05 * p.incentive_misalignment -
        0.04 * p.proxy_drift;
}

int main() {
    GoalSystemProfile profile{84, 78, 82, 79, 83, 22, 18, 16, 82, 15, 80};
    std::cout << "Synthetic goal-system effectiveness score: "
              << goal_system_effectiveness_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

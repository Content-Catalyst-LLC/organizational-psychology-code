/*
Incentives and Workplace Behavior
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
incentive-compliance scoring, cultural-loyalty scoring, or individual worker decisions.
*/

#include <iostream>

struct IncentiveSystemProfile {
    double expectancy_strength;
    double fairness_perception;
    double strategic_alignment;
    double intrinsic_support;
    double feedback_clarity;
    double distortion_risk;
    double overload_pressure;
    double ethical_risk;
    double cooperation_support;
    double recognition_legitimacy;
    double reward_transparency;
    double hidden_labor_recognition;
};

double incentive_effectiveness_score(const IncentiveSystemProfile& p) {
    return
        0.12 * p.expectancy_strength +
        0.13 * p.fairness_perception +
        0.12 * p.strategic_alignment +
        0.10 * p.intrinsic_support +
        0.11 * p.feedback_clarity +
        0.10 * p.cooperation_support +
        0.10 * p.recognition_legitimacy +
        0.09 * p.reward_transparency +
        0.08 * p.hidden_labor_recognition -
        0.08 * p.distortion_risk -
        0.07 * p.overload_pressure -
        0.08 * p.ethical_risk;
}

int main() {
    IncentiveSystemProfile profile{83, 81, 82, 79, 80, 18, 24, 16, 82, 80, 81, 78};
    std::cout << "Synthetic incentive effectiveness score: "
              << incentive_effectiveness_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

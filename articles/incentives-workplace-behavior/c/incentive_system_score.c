/*
Incentives and Workplace Behavior
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
incentive-system review, reward-governance education, and reproducible workflows
only. Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
productivity ranking, incentive-compliance scoring, cultural-loyalty scoring,
or psychological assessment.
*/

#include <stdio.h>

double incentive_effectiveness_score(
    double expectancy_strength,
    double fairness_perception,
    double strategic_alignment,
    double intrinsic_support,
    double feedback_clarity,
    double distortion_risk,
    double overload_pressure,
    double ethical_risk,
    double cooperation_support,
    double recognition_legitimacy,
    double reward_transparency,
    double hidden_labor_recognition
) {
    return
        0.12 * expectancy_strength +
        0.13 * fairness_perception +
        0.12 * strategic_alignment +
        0.10 * intrinsic_support +
        0.11 * feedback_clarity +
        0.10 * cooperation_support +
        0.10 * recognition_legitimacy +
        0.09 * reward_transparency +
        0.08 * hidden_labor_recognition -
        0.08 * distortion_risk -
        0.07 * overload_pressure -
        0.08 * ethical_risk;
}

int main(void) {
    double score = incentive_effectiveness_score(83, 81, 82, 79, 80, 18, 24, 16, 82, 80, 81, 78);
    printf("Synthetic incentive effectiveness score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

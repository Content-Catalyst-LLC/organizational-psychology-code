/*
Goal Setting and Performance Systems
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
goal-system review, performance-system education, and reproducible workflows
only. Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
productivity ranking, goal-compliance scoring, cultural-loyalty scoring,
or psychological assessment.
*/

#include <stdio.h>

double goal_system_effectiveness_score(
    double goal_clarity,
    double goal_challenge,
    double feedback_quality,
    double employee_commitment,
    double strategic_alignment,
    double overload_pressure,
    double metric_distortion,
    double incentive_misalignment,
    double review_quality,
    double proxy_drift,
    double goal_feasibility
) {
    return
        0.13 * goal_clarity +
        0.10 * goal_challenge +
        0.13 * feedback_quality +
        0.11 * employee_commitment +
        0.13 * strategic_alignment +
        0.11 * review_quality +
        0.11 * goal_feasibility -
        0.07 * overload_pressure -
        0.06 * metric_distortion -
        0.05 * incentive_misalignment -
        0.04 * proxy_drift;
}

int main(void) {
    double score = goal_system_effectiveness_score(84, 78, 82, 79, 83, 22, 18, 16, 82, 15, 80);
    printf("Synthetic goal-system effectiveness score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

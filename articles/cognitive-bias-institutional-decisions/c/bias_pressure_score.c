/*
Cognitive Bias in Institutional Decisions
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
decision-governance review, bias-risk analysis, and reproducible workflows only.
Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
executive ranking, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double bias_pressure_score(
    double signal_quality,
    double viewpoint_diversity,
    double analytical_discipline,
    double structured_challenge,
    double hierarchy_suppression,
    double time_pressure,
    double routine_reinforcement,
    double learning_review,
    double group_conformity
) {
    return
        0.16 * hierarchy_suppression +
        0.15 * time_pressure +
        0.14 * routine_reinforcement +
        0.13 * group_conformity -
        0.16 * viewpoint_diversity -
        0.13 * analytical_discipline -
        0.14 * structured_challenge -
        0.12 * learning_review -
        0.10 * signal_quality;
}

int main(void) {
    double score = bias_pressure_score(84, 80, 82, 81, 14, 38, 36, 79, 28);
    printf("Synthetic bias pressure score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

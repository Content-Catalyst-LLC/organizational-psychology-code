/*
What Is Organizational Psychology?
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational psychology education, and reproducible workflows only. Not for
employee screening, hiring, promotion, compensation, discipline, termination,
workplace surveillance, individual performance management, productivity ranking,
loyalty scoring, dissent tracking, or psychological assessment.
*/

#include <stdio.h>

double outcome_quality_score(
    double capability,
    double motivation,
    double role_clarity,
    double autonomy,
    double fairness,
    double team_coordination,
    double leadership_trust,
    double psychological_safety,
    double communication_quality,
    double culture_strength,
    double workload_pressure,
    double burnout_pressure,
    double institutional_support,
    double voice_access
) {
    return
        0.11 * capability +
        0.10 * motivation +
        0.10 * role_clarity +
        0.07 * autonomy +
        0.08 * fairness +
        0.09 * team_coordination +
        0.10 * leadership_trust +
        0.10 * psychological_safety +
        0.08 * communication_quality +
        0.06 * culture_strength +
        0.08 * institutional_support +
        0.06 * voice_access -
        0.07 * workload_pressure -
        0.08 * burnout_pressure;
}

int main(void) {
    double score = outcome_quality_score(72, 76, 82, 78, 80, 80, 84, 81, 82, 79, 28, 25, 82, 80);
    printf("Synthetic modeled outcome quality: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

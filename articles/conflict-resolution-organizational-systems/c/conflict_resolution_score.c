/*
Conflict Resolution in Organizational Systems
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
conflict-system review, mediation-process education, and reproducible workflows
only. Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
cultural-loyalty scoring, conflict-proneness scoring, collaboration scoring of
workers, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double constructive_conflict_capacity_score(
    double trust_level,
    double communication_clarity,
    double psychological_safety,
    double procedural_fairness,
    double integrative_skill,
    double blame_intensity,
    double power_asymmetry,
    double resource_strain,
    double mediation_access
) {
    return
        0.16 * trust_level +
        0.15 * communication_clarity +
        0.14 * psychological_safety +
        0.15 * procedural_fairness +
        0.12 * integrative_skill +
        0.10 * mediation_access -
        0.10 * blame_intensity -
        0.09 * power_asymmetry -
        0.07 * resource_strain;
}

int main(void) {
    double score = constructive_conflict_capacity_score(82, 80, 81, 83, 76, 18, 22, 45, 84);
    printf("Synthetic constructive conflict capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

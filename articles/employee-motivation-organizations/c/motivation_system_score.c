/*
Employee Motivation in Organizations
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
motivational-systems review, work-design education, and reproducible workflows
only. Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
productivity ranking, motivation scoring, loyalty scoring, or psychological
assessment.
*/

#include <stdio.h>

double motivation_quality_score(
    double autonomy_support,
    double competence_development,
    double recognition_quality,
    double institutional_trust,
    double goal_clarity,
    double fairness_perception,
    double workload_strain,
    double control_pressure,
    double relatedness,
    double meaningful_work,
    double psychological_safety,
    double leadership_credibility
) {
    return
        0.12 * autonomy_support +
        0.11 * competence_development +
        0.10 * recognition_quality +
        0.12 * institutional_trust +
        0.10 * goal_clarity +
        0.11 * fairness_perception +
        0.10 * relatedness +
        0.11 * meaningful_work +
        0.10 * psychological_safety +
        0.10 * leadership_credibility -
        0.08 * workload_strain -
        0.07 * control_pressure;
}

int main(void) {
    double score = motivation_quality_score(84, 80, 79, 82, 83, 81, 22, 18, 82, 84, 80, 82);
    printf("Synthetic motivation quality score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

/*
Institutional Values and Behavioral Expectations
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
values-governance review, organizational ethics education, legitimacy analysis,
and reproducible workflows only. Not for employee screening, hiring, promotion,
compensation, discipline, termination, workplace surveillance, individual
performance management, cultural-loyalty scoring, morality scoring,
values-alignment scoring of workers, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double value_practice_alignment_score(
    double value_clarity,
    double leadership_consistency,
    double reinforcement_alignment,
    double psychological_safety,
    double accountability_strength,
    double decoupling_risk,
    double incentive_contradiction,
    double hierarchy_exemption,
    double legitimacy_pressure
) {
    return
        0.17 * value_clarity +
        0.16 * leadership_consistency +
        0.16 * reinforcement_alignment +
        0.14 * psychological_safety +
        0.14 * accountability_strength -
        0.10 * decoupling_risk -
        0.09 * incentive_contradiction -
        0.09 * hierarchy_exemption -
        0.05 * legitimacy_pressure;
}

int main(void) {
    double score = value_practice_alignment_score(86, 83, 81, 82, 80, 16, 20, 12, 58);
    printf("Synthetic value-practice alignment score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

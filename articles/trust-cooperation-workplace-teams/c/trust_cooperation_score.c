/*
Trust and Cooperation in Workplace Teams
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
trust-and-cooperation review, collaboration-system education, and reproducible
workflows only. Not for employee screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance
management, cultural-loyalty scoring, trustworthiness scoring, cooperation
scoring of workers, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double cooperative_capacity_score(
    double competence_trust,
    double integrity_trust,
    double benevolence_trust,
    double reciprocity_norms,
    double communication_reliability,
    double opportunism_risk,
    double power_imbalance,
    double uncertainty_load,
    double leadership_credibility,
    double institutional_trust
) {
    return
        0.13 * competence_trust +
        0.14 * integrity_trust +
        0.12 * benevolence_trust +
        0.13 * reciprocity_norms +
        0.12 * communication_reliability +
        0.11 * leadership_credibility +
        0.11 * institutional_trust -
        0.10 * opportunism_risk -
        0.08 * power_imbalance -
        0.05 * uncertainty_load;
}

int main(void) {
    double score = cooperative_capacity_score(84, 82, 78, 81, 83, 16, 20, 52, 84, 82);
    printf("Synthetic cooperative capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

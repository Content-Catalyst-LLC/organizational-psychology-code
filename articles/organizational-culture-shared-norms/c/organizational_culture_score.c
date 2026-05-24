/*
Organizational Culture and Shared Norms
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
culture review, organizational development education, legitimacy analysis,
and reproducible workflows only. Not for employee screening, hiring, promotion,
compensation, discipline, termination, workplace surveillance, individual
performance management, cultural-loyalty scoring, cultural-fit scoring,
productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double cultural_coherence_score(
    double value_alignment,
    double normative_consistency,
    double leadership_credibility,
    double psychological_safety,
    double shared_meaning,
    double contradiction,
    double fragmentation,
    double incentive_distortion,
    double external_pressure
) {
    return
        0.18 * value_alignment +
        0.16 * normative_consistency +
        0.15 * leadership_credibility +
        0.14 * psychological_safety +
        0.14 * shared_meaning -
        0.10 * contradiction -
        0.08 * fragmentation -
        0.10 * incentive_distortion -
        0.05 * external_pressure;
}

int main(void) {
    double score = cultural_coherence_score(84, 80, 81, 84, 82, 16, 22, 20, 58);
    printf("Synthetic cultural coherence score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

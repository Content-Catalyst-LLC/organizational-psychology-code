/*
Organizational Identity and Institutional Legitimacy
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational identity review, legitimacy analysis, governance review,
and reproducible workflows only. Not for employee screening, hiring,
promotion, compensation, discipline, termination, workplace surveillance,
individual performance management, cultural-loyalty scoring, worker
legitimacy scoring, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double identity_coherence_score(
    double mission_clarity,
    double value_practice_alignment,
    double narrative_continuity,
    double leadership_credibility,
    double behavioral_consistency,
    double internal_fragmentation,
    double identity_contradiction,
    double legitimacy_pressure
) {
    return
        0.18 * mission_clarity +
        0.17 * value_practice_alignment +
        0.15 * narrative_continuity +
        0.14 * leadership_credibility +
        0.14 * behavioral_consistency -
        0.10 * internal_fragmentation -
        0.07 * identity_contradiction -
        0.05 * legitimacy_pressure;
}

int main(void) {
    double score = identity_coherence_score(86, 82, 79, 81, 80, 20, 16, 60);
    printf("Synthetic identity coherence score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

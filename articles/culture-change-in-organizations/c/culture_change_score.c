/*
Culture Change in Organizations
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
culture-change review, organizational development education, and reproducible
workflows only. Not for employee screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance management,
cultural-loyalty scoring, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double culture_change_capacity(
    double leadership_credibility,
    double narrative_coherence,
    double reinforcement_alignment,
    double adaptive_learning,
    double psychological_safety,
    double identity_adaptability,
    double resistance_intensity,
    double subcultural_fragmentation,
    double legacy_lock_in,
    double leadership_turnover
) {
    return
        0.17 * leadership_credibility +
        0.15 * narrative_coherence +
        0.15 * reinforcement_alignment +
        0.14 * adaptive_learning +
        0.13 * psychological_safety +
        0.11 * identity_adaptability -
        0.12 * resistance_intensity -
        0.10 * subcultural_fragmentation -
        0.11 * legacy_lock_in -
        4.00 * leadership_turnover;
}

int main(void) {
    double score = culture_change_capacity(84, 82, 81, 80, 83, 76, 22, 26, 29, 0);
    printf("Synthetic culture change capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

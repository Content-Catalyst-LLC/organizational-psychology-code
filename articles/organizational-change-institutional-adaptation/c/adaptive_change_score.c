/*
Adaptive Organizations: Institutional Change and Strategic Transformation
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational change governance, and reproducible workflows only.
Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
or psychological assessment.
*/

#include <stdio.h>

double adaptive_change_capacity(
    double sensing_quality,
    double interpretive_coherence,
    double governance_alignment,
    double learning_capability,
    double resource_flexibility,
    double institutional_legitimacy,
    double organizational_inertia,
    double fragmentation,
    double resistance_friction,
    double environmental_pressure
) {
    return
        0.17 * sensing_quality +
        0.16 * interpretive_coherence +
        0.15 * governance_alignment +
        0.16 * learning_capability +
        0.12 * resource_flexibility +
        0.12 * institutional_legitimacy -
        0.13 * organizational_inertia -
        0.11 * fragmentation -
        0.10 * resistance_friction -
        0.05 * environmental_pressure;
}

int main(void) {
    double score = adaptive_change_capacity(84, 81, 79, 83, 74, 80, 20, 18, 24, 62);
    printf("Synthetic adaptive change capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

/*
Organizational Resilience in Complex Systems
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employee screening, hiring,
promotion, compensation, discipline, termination, workplace surveillance,
individual performance management, or psychological assessment.
*/

#include <stdio.h>

double resilience_capacity(
    double robustness,
    double redundancy,
    double adaptive_learning,
    double coordination_integrity,
    double governance_responsiveness,
    double psychological_safety,
    double external_exposure,
    double complexity_load,
    double accumulated_fragility
) {
    return
        0.18 * robustness +
        0.12 * redundancy +
        0.16 * adaptive_learning +
        0.14 * coordination_integrity +
        0.12 * governance_responsiveness +
        0.13 * psychological_safety -
        0.08 * external_exposure -
        0.07 * complexity_load -
        0.10 * accumulated_fragility;
}

int main(void) {
    double score = resilience_capacity(78, 72, 81, 79, 74, 83, 42, 51, 22);
    printf("Synthetic institutional resilience capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

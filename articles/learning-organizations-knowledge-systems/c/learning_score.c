/*
Learning Organizations and Knowledge Systems
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational knowledge governance, and reproducible workflows only.
Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
or psychological assessment.
*/

#include <stdio.h>

double learning_capacity(
    double information_quality,
    double interpretive_openness,
    double memory_retention,
    double communication_flow,
    double psychological_safety,
    double governance_support,
    double complexity_load,
    double silo_intensity,
    double incentive_distortion,
    double turnover_pressure
) {
    return
        0.17 * information_quality +
        0.18 * interpretive_openness +
        0.15 * memory_retention +
        0.15 * communication_flow +
        0.13 * psychological_safety +
        0.10 * governance_support -
        0.07 * complexity_load -
        0.10 * silo_intensity -
        0.10 * incentive_distortion -
        0.05 * turnover_pressure;
}

int main(void) {
    double score = learning_capacity(84, 82, 83, 86, 84, 78, 48, 20, 17, 19);
    printf("Synthetic institutional learning capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

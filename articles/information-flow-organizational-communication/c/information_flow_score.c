/*
Information Flow and Organizational Communication
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational communication review, knowledge-flow governance, and reproducible
workflows only. Not for employee screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance management,
communication surveillance, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double information_flow_quality(
    double signal_quality,
    double timeliness,
    double interpretive_clarity,
    double cross_functional_connectivity,
    double psychological_safety,
    double distortion_risk,
    double overload_pressure,
    double hierarchy_delay,
    double external_signal_turbulence
) {
    return
        0.18 * signal_quality +
        0.15 * timeliness +
        0.15 * interpretive_clarity +
        0.14 * cross_functional_connectivity +
        0.13 * psychological_safety -
        0.10 * distortion_risk -
        0.08 * overload_pressure -
        0.10 * hierarchy_delay -
        0.05 * external_signal_turbulence;
}

int main(void) {
    double score = information_flow_quality(84, 82, 80, 79, 83, 14, 32, 18, 58);
    printf("Synthetic information flow quality score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

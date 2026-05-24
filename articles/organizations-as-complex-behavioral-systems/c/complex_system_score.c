/*
Organizations as Complex Behavioral Systems
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational psychology education, and reproducible workflows only. Not for
employee screening, hiring, promotion, compensation, discipline, termination,
workplace surveillance, individual performance management, productivity ranking,
loyalty scoring, dissent tracking, or psychological assessment.
*/

#include <stdio.h>

double complex_system_risk_score(
    double psychological_safety,
    double leadership_trust,
    double cultural_coherence,
    double incentive_alignment,
    double information_flow,
    double learning_capacity,
    double redundancy_slack,
    double workload_pressure,
    double silence_risk,
    double fragmentation_pressure,
    double environmental_uncertainty
) {
    return
        0.11 * (100.0 - psychological_safety) +
        0.11 * (100.0 - leadership_trust) +
        0.09 * (100.0 - cultural_coherence) +
        0.09 * (100.0 - incentive_alignment) +
        0.09 * (100.0 - information_flow) +
        0.10 * (100.0 - learning_capacity) +
        0.08 * (100.0 - redundancy_slack) +
        0.09 * workload_pressure +
        0.08 * silence_risk +
        0.10 * fragmentation_pressure +
        0.08 * environmental_uncertainty;
}

int main(void) {
    double risk = complex_system_risk_score(84, 85, 82, 80, 83, 82, 68, 30, 18, 22, 42);
    printf("Synthetic complex system risk score: %.2f\n", risk);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

/*
Resistance to Organizational Change
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational change governance, and reproducible workflows only.
Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
or psychological assessment.
*/

#include <stdio.h>

double resistance_intensity(
    double perceived_loss,
    double uncertainty,
    double identity_threat,
    double routine_embeddedness,
    double power_displacement,
    double trust_in_leadership,
    double participation_quality,
    double implementation_clarity,
    double workload_strain,
    double failed_change_history
) {
    return
        0.17 * perceived_loss +
        0.16 * uncertainty +
        0.13 * identity_threat +
        0.13 * routine_embeddedness +
        0.10 * power_displacement +
        0.10 * workload_strain +
        6.0 * failed_change_history -
        0.12 * trust_in_leadership -
        0.08 * participation_quality -
        0.09 * implementation_clarity;
}

int main(void) {
    double score = resistance_intensity(26, 32, 24, 52, 20, 84, 81, 86, 41, 0);
    printf("Synthetic institutional resistance intensity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

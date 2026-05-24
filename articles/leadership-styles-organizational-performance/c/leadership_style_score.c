/*
Leadership Styles and Organizational Performance
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
leadership-system review, communication/trust/style-fit analysis, and
reproducible workflows only. Not for employee screening, hiring, promotion,
compensation, discipline, termination, workplace surveillance, individual
performance management, productivity ranking, leadership-loyalty scoring,
dissent tracking, or psychological assessment.
*/

#include <stdio.h>

double leadership_effectiveness_score(
    double participative_behavior,
    double structural_guidance,
    double communication_quality,
    double trust_generation,
    double developmental_support,
    double psychological_safety,
    double decision_fit,
    double cultural_alignment,
    double control_pressure,
    double ambiguity_risk,
    double disengagement_pressure
) {
    return
        0.11 * participative_behavior +
        0.12 * structural_guidance +
        0.13 * communication_quality +
        0.13 * trust_generation +
        0.11 * developmental_support +
        0.12 * psychological_safety +
        0.11 * decision_fit +
        0.10 * cultural_alignment -
        0.08 * control_pressure -
        0.07 * ambiguity_risk -
        0.07 * disengagement_pressure;
}

int main(void) {
    double score = leadership_effectiveness_score(82, 80, 83, 81, 79, 80, 82, 81, 18, 22, 20);
    printf("Synthetic leadership effectiveness score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

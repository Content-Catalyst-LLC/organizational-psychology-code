/*
Strategic Decision-Making in Complex Organizations
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
strategic governance, decision-process review, and reproducible workflows only.
Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
executive ranking, or psychological assessment.
*/

#include <stdio.h>

double strategic_decision_quality(
    double sensing_quality,
    double interpretive_coherence,
    double knowledge_integration,
    double option_diversity,
    double governance_quality,
    double adaptive_learning,
    double bias_pressure,
    double political_distortion,
    double complexity_load,
    double environmental_turbulence
) {
    return
        0.17 * sensing_quality +
        0.16 * interpretive_coherence +
        0.16 * knowledge_integration +
        0.12 * option_diversity +
        0.13 * governance_quality +
        0.14 * adaptive_learning -
        0.12 * bias_pressure -
        0.10 * political_distortion -
        0.09 * complexity_load -
        0.08 * environmental_turbulence;
}

int main(void) {
    double score = strategic_decision_quality(84, 79, 82, 74, 77, 81, 18, 14, 58, 62);
    printf("Synthetic strategic decision quality score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

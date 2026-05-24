/*
Authority and Power in Institutional Leadership
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
authority/governance-system review, legitimacy and procedural-fairness analysis,
ethical-leadership education, and reproducible workflows only. Not for employee
screening, hiring, promotion, compensation, discipline, termination, workplace
surveillance, individual performance management, productivity ranking, loyalty
scoring, political-influence scoring, dissent tracking, or psychological
assessment.
*/

#include <stdio.h>

double authority_effectiveness_score(
    double formal_legitimacy,
    double procedural_fairness,
    double informational_access,
    double practical_influence,
    double ethical_credibility,
    double accountability_quality,
    double voice_access,
    double oversight_strength,
    double arbitrariness_risk,
    double governance_fragmentation,
    double distrust_pressure,
    double informal_power_concentration
) {
    return
        0.12 * formal_legitimacy +
        0.12 * procedural_fairness +
        0.10 * informational_access +
        0.10 * practical_influence +
        0.12 * ethical_credibility +
        0.11 * accountability_quality +
        0.10 * voice_access +
        0.09 * oversight_strength -
        0.08 * arbitrariness_risk -
        0.07 * governance_fragmentation -
        0.07 * distrust_pressure -
        0.05 * informal_power_concentration;
}

int main(void) {
    double score = authority_effectiveness_score(84, 82, 79, 81, 83, 82, 80, 78, 18, 24, 20, 22);
    printf("Synthetic authority effectiveness score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

/*
Human Behavior in Organizations
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
organizational psychology education, and reproducible workflows only. Not for
employee screening, hiring, promotion, compensation, discipline, termination,
workplace surveillance, individual performance management, productivity ranking,
loyalty scoring, dissent tracking, or psychological assessment.
*/

#include <stdio.h>
#include <math.h>

double behavior_quality_score(
    double capability,
    double motivation,
    double role_clarity,
    double psychological_safety,
    double leadership_trust,
    double cultural_norm_strength,
    double incentive_alignment,
    double workload_pressure,
    double burnout_pressure,
    double hierarchical_pressure
) {
    return
        0.16 * capability +
        0.15 * motivation +
        0.14 * role_clarity +
        0.12 * psychological_safety +
        0.12 * leadership_trust +
        0.10 * cultural_norm_strength +
        0.09 * incentive_alignment -
        0.08 * workload_pressure -
        0.08 * burnout_pressure -
        0.06 * hierarchical_pressure;
}

double logistic(double z) {
    return 1.0 / (1.0 + exp(-z));
}

double voice_probability(
    double psychological_safety,
    double leadership_trust,
    double perceived_voice_efficacy,
    double fear_of_retaliation,
    double hierarchical_pressure
) {
    double z = -2.0 +
        0.030 * psychological_safety +
        0.024 * leadership_trust +
        0.022 * perceived_voice_efficacy -
        0.026 * fear_of_retaliation -
        0.020 * hierarchical_pressure;
    return logistic(z);
}

int main(void) {
    double score = behavior_quality_score(72, 78, 82, 84, 85, 82, 80, 30, 24, 22);
    double voice = voice_probability(84, 85, 80, 12, 22);
    printf("Synthetic behavior quality: %.2f\n", score);
    printf("Synthetic voice probability: %.3f\n", voice);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

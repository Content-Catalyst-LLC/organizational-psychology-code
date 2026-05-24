/*
Psychological Safety in High-Performing Teams
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
team-learning review, psychological safety education, and reproducible
workflows only. Not for employee screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance
management, cultural-loyalty scoring, courage scoring, voice scoring of
workers, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double psychological_safety_score(
    double leadership_openness,
    double inclusion_quality,
    double learning_review_quality,
    double knowledge_sharing,
    double blame_intensity,
    double status_asymmetry,
    double perceived_penalty,
    double workload_pressure
) {
    return
        0.18 * leadership_openness +
        0.16 * inclusion_quality +
        0.15 * learning_review_quality +
        0.14 * knowledge_sharing -
        0.13 * blame_intensity -
        0.11 * status_asymmetry -
        0.10 * perceived_penalty -
        0.06 * workload_pressure;
}

int main(void) {
    double score = psychological_safety_score(84, 82, 80, 81, 16, 20, 18, 52);
    printf("Synthetic psychological safety score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

/*
Job Satisfaction and Organizational Commitment
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
work-attitude review, retention-system education, and reproducible workflows
only. Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
cultural-loyalty scoring, commitment scoring, retention-risk scoring of
individual workers, productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double job_satisfaction_score(
    double leadership_support,
    double reward_fairness,
    double developmental_opportunity,
    double workload_balance,
    double institutional_trust,
    double cultural_alignment,
    double role_insecurity,
    double exhaustion_pressure
) {
    return
        0.16 * leadership_support +
        0.15 * reward_fairness +
        0.13 * developmental_opportunity +
        0.14 * workload_balance +
        0.13 * institutional_trust +
        0.10 * cultural_alignment -
        0.09 * role_insecurity -
        0.10 * exhaustion_pressure;
}

int main(void) {
    double score = job_satisfaction_score(84, 79, 82, 76, 83, 81, 18, 22);
    printf("Synthetic job satisfaction score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

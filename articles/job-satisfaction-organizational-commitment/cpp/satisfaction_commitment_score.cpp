/*
Job Satisfaction and Organizational Commitment
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
commitment scoring, retention-risk scoring, productivity ranking, or individual
worker decisions.
*/

#include <iostream>

struct WorkAttitudeProfile {
    double leadership_support;
    double reward_fairness;
    double developmental_opportunity;
    double workload_balance;
    double institutional_trust;
    double cultural_alignment;
    double role_insecurity;
    double exhaustion_pressure;
};

double job_satisfaction_score(const WorkAttitudeProfile& p) {
    return
        0.16 * p.leadership_support +
        0.15 * p.reward_fairness +
        0.13 * p.developmental_opportunity +
        0.14 * p.workload_balance +
        0.13 * p.institutional_trust +
        0.10 * p.cultural_alignment -
        0.09 * p.role_insecurity -
        0.10 * p.exhaustion_pressure;
}

int main() {
    WorkAttitudeProfile profile{84, 79, 82, 76, 83, 81, 18, 22};
    std::cout << "Synthetic job satisfaction score: "
              << job_satisfaction_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

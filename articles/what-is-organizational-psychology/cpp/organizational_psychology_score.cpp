/*
What Is Organizational Psychology?
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, productivity ranking,
loyalty scoring, dissent tracking, or individual worker decisions.
*/

#include <iostream>

struct WorkSystemProfile {
    double capability;
    double motivation;
    double role_clarity;
    double autonomy;
    double fairness;
    double team_coordination;
    double leadership_trust;
    double psychological_safety;
    double communication_quality;
    double culture_strength;
    double workload_pressure;
    double burnout_pressure;
    double institutional_support;
    double voice_access;
};

double outcome_quality_score(const WorkSystemProfile& p) {
    return
        0.11 * p.capability +
        0.10 * p.motivation +
        0.10 * p.role_clarity +
        0.07 * p.autonomy +
        0.08 * p.fairness +
        0.09 * p.team_coordination +
        0.10 * p.leadership_trust +
        0.10 * p.psychological_safety +
        0.08 * p.communication_quality +
        0.06 * p.culture_strength +
        0.08 * p.institutional_support +
        0.06 * p.voice_access -
        0.07 * p.workload_pressure -
        0.08 * p.burnout_pressure;
}

int main() {
    WorkSystemProfile profile{72, 76, 82, 78, 80, 80, 84, 81, 82, 79, 28, 25, 82, 80};
    std::cout << "Synthetic modeled outcome quality: "
              << outcome_quality_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

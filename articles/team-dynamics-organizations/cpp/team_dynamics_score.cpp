/*
Team Dynamics in Organizations
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
team-fit scoring, collaboration scoring, productivity ranking, or individual
worker decisions.
*/

#include <iostream>

struct TeamDynamicsProfile {
    double communication_quality;
    double trust_level;
    double role_clarity;
    double psychological_safety;
    double leadership_support;
    double conflict_load;
    double task_ambiguity;
    double coordination_cost;
    double participation_equity;
    double learning_routine_quality;
};

double team_effectiveness_score(const TeamDynamicsProfile& p) {
    return
        0.14 * p.communication_quality +
        0.12 * p.trust_level +
        0.12 * p.role_clarity +
        0.13 * p.psychological_safety +
        0.12 * p.leadership_support +
        0.11 * p.participation_equity +
        0.11 * p.learning_routine_quality -
        0.09 * p.conflict_load -
        0.08 * p.task_ambiguity -
        0.09 * p.coordination_cost;
}

int main() {
    TeamDynamicsProfile profile{84, 82, 79, 83, 80, 22, 30, 34, 82, 80};
    std::cout << "Synthetic team effectiveness score: "
              << team_effectiveness_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

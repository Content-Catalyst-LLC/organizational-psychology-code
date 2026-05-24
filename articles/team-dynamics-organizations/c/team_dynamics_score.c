/*
Team Dynamics in Organizations
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
team-system review, collaboration-system education, and reproducible workflows
only. Not for employee screening, hiring, promotion, compensation, discipline,
termination, workplace surveillance, individual performance management,
cultural-loyalty scoring, team-fit scoring, collaboration scoring of workers,
productivity ranking, or psychological assessment.
*/

#include <stdio.h>

double team_effectiveness_score(
    double communication_quality,
    double trust_level,
    double role_clarity,
    double psychological_safety,
    double leadership_support,
    double conflict_load,
    double task_ambiguity,
    double coordination_cost,
    double participation_equity,
    double learning_routine_quality
) {
    return
        0.14 * communication_quality +
        0.12 * trust_level +
        0.12 * role_clarity +
        0.13 * psychological_safety +
        0.12 * leadership_support +
        0.11 * participation_equity +
        0.11 * learning_routine_quality -
        0.09 * conflict_load -
        0.08 * task_ambiguity -
        0.09 * coordination_cost;
}

int main(void) {
    double score = team_effectiveness_score(84, 82, 79, 83, 80, 22, 30, 34, 82, 80);
    printf("Synthetic team effectiveness score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

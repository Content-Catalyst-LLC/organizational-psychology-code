/*
The Evolution of Organizational Psychology
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, organizational psychology
education, and history-of-field analysis only. Not for employee screening,
employment selection, ranking scholars, ranking departments, ranking journals,
workplace surveillance, or psychological assessment.
*/

#include <stdio.h>

double responsible_progress_score(
    double selection_testing,
    double efficiency_work_design,
    double motivation_attitudes,
    double groups_teams,
    double culture_leadership_change,
    double wellbeing_stress,
    double justice_validity_ethics,
    double digital_analytics,
    double systems_institutional_accountability
) {
    return
        0.18 * selection_testing +
        0.08 * efficiency_work_design +
        0.12 * motivation_attitudes +
        0.12 * groups_teams +
        0.14 * culture_leadership_change +
        0.15 * wellbeing_stress +
        0.17 * justice_validity_ethics +
        0.08 * digital_analytics +
        0.06 * systems_institutional_accountability;
}

int main(void) {
    double score = responsible_progress_score(72, 66, 84, 86, 88, 86, 92, 84, 90);
    printf("Synthetic responsible progress score: %.2f\n", score);
    printf("Responsible-use reminder: educational field-evolution demo only.\n");
    return 0;
}

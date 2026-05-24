/*
Transformational Leadership and Organizational Change
Simple C scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
transformational-leadership review, change-system analysis, and reproducible
workflows only. Not for employee screening, hiring, promotion, compensation,
discipline, termination, workplace surveillance, individual performance
management, productivity ranking, leadership-loyalty scoring, dissent tracking,
or psychological assessment.
*/

#include <stdio.h>

double transformational_capacity_score(
    double vision_credibility,
    double motivational_alignment,
    double intellectual_stimulation,
    double developmental_support,
    double institutional_trust,
    double psychological_safety,
    double change_communication,
    double implementation_support,
    double meaning_making_quality,
    double resistance_intensity,
    double ambiguity_pressure,
    double change_fatigue
) {
    return
        0.12 * vision_credibility +
        0.11 * motivational_alignment +
        0.11 * intellectual_stimulation +
        0.10 * developmental_support +
        0.12 * institutional_trust +
        0.11 * psychological_safety +
        0.10 * change_communication +
        0.09 * implementation_support +
        0.10 * meaning_making_quality -
        0.08 * resistance_intensity -
        0.07 * ambiguity_pressure -
        0.08 * change_fatigue;
}

int main(void) {
    double score = transformational_capacity_score(84, 81, 80, 79, 82, 80, 83, 78, 82, 20, 22, 24);
    printf("Synthetic transformational capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

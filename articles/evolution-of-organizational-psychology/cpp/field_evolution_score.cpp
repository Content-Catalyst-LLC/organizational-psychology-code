/*
The Evolution of Organizational Psychology
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, organizational psychology
education, and history-of-field analysis only. Not for employee or institution ranking.
*/

#include <iostream>

struct FieldEmphasis {
    double selection_testing;
    double efficiency_work_design;
    double motivation_attitudes;
    double groups_teams;
    double culture_leadership_change;
    double wellbeing_stress;
    double justice_validity_ethics;
    double digital_analytics;
    double systems_institutional_accountability;
};

double responsible_progress_score(const FieldEmphasis& f) {
    return
        0.18 * f.selection_testing +
        0.08 * f.efficiency_work_design +
        0.12 * f.motivation_attitudes +
        0.12 * f.groups_teams +
        0.14 * f.culture_leadership_change +
        0.15 * f.wellbeing_stress +
        0.17 * f.justice_validity_ethics +
        0.08 * f.digital_analytics +
        0.06 * f.systems_institutional_accountability;
}

int main() {
    FieldEmphasis broad{72, 66, 84, 86, 88, 86, 92, 84, 90};
    std::cout << "Synthetic responsible progress score: "
              << responsible_progress_score(broad) << "\n";
    std::cout << "Responsible-use reminder: educational field-evolution demo only.\n";
    return 0;
}

/*
Trust and Cooperation in Workplace Teams
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, cultural-loyalty scoring,
trustworthiness scoring, cooperation scoring, productivity ranking, or
individual worker decisions.
*/

#include <iostream>

struct TrustCooperationProfile {
    double competence_trust;
    double integrity_trust;
    double benevolence_trust;
    double reciprocity_norms;
    double communication_reliability;
    double opportunism_risk;
    double power_imbalance;
    double uncertainty_load;
    double leadership_credibility;
    double institutional_trust;
};

double cooperative_capacity_score(const TrustCooperationProfile& p) {
    return
        0.13 * p.competence_trust +
        0.14 * p.integrity_trust +
        0.12 * p.benevolence_trust +
        0.13 * p.reciprocity_norms +
        0.12 * p.communication_reliability +
        0.11 * p.leadership_credibility +
        0.11 * p.institutional_trust -
        0.10 * p.opportunism_risk -
        0.08 * p.power_imbalance -
        0.05 * p.uncertainty_load;
}

int main() {
    TrustCooperationProfile profile{84, 82, 78, 81, 83, 16, 20, 52, 84, 82};
    std::cout << "Synthetic cooperative capacity score: "
              << cooperative_capacity_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

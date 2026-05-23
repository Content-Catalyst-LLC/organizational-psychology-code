/*
Resistance to Organizational Change
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment or individual worker decisions.
*/

#include <iostream>

struct ChangeProfile {
    double perceived_loss;
    double uncertainty;
    double identity_threat;
    double routine_embeddedness;
    double power_displacement;
    double trust_in_leadership;
    double participation_quality;
    double implementation_clarity;
    double workload_strain;
    double failed_change_history;
};

double resistance_intensity(const ChangeProfile& p) {
    return
        0.17 * p.perceived_loss +
        0.16 * p.uncertainty +
        0.13 * p.identity_threat +
        0.13 * p.routine_embeddedness +
        0.10 * p.power_displacement +
        0.10 * p.workload_strain +
        6.0 * p.failed_change_history -
        0.12 * p.trust_in_leadership -
        0.08 * p.participation_quality -
        0.09 * p.implementation_clarity;
}

int main() {
    ChangeProfile profile{26, 32, 24, 52, 20, 84, 81, 86, 41, 0};
    std::cout << "Synthetic institutional resistance intensity score: "
              << resistance_intensity(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

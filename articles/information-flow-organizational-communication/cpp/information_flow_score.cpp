/*
Information Flow and Organizational Communication
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment, communication surveillance,
productivity ranking, or individual worker decisions.
*/

#include <iostream>

struct InformationFlowProfile {
    double signal_quality;
    double timeliness;
    double interpretive_clarity;
    double cross_functional_connectivity;
    double psychological_safety;
    double distortion_risk;
    double overload_pressure;
    double hierarchy_delay;
    double external_signal_turbulence;
};

double information_flow_quality(const InformationFlowProfile& p) {
    return
        0.18 * p.signal_quality +
        0.15 * p.timeliness +
        0.15 * p.interpretive_clarity +
        0.14 * p.cross_functional_connectivity +
        0.13 * p.psychological_safety -
        0.10 * p.distortion_risk -
        0.08 * p.overload_pressure -
        0.10 * p.hierarchy_delay -
        0.05 * p.external_signal_turbulence;
}

int main() {
    InformationFlowProfile profile{84, 82, 80, 79, 83, 14, 32, 18, 58};
    std::cout << "Synthetic information flow quality score: "
              << information_flow_quality(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

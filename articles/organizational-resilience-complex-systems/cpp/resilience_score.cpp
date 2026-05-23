/*
Organizational Resilience in Complex Systems
Simple C++ scoring demonstration.

Responsible-use scope:
Synthetic-data research, methods demonstration, institutional learning,
and reproducible workflows only. Not for employment or individual worker decisions.
*/

#include <iostream>
#include <string>

struct ResilienceProfile {
    double robustness;
    double redundancy;
    double adaptive_learning;
    double coordination_integrity;
    double governance_responsiveness;
    double psychological_safety;
    double external_exposure;
    double complexity_load;
    double accumulated_fragility;
};

double resilience_capacity(const ResilienceProfile& p) {
    return
        0.18 * p.robustness +
        0.12 * p.redundancy +
        0.16 * p.adaptive_learning +
        0.14 * p.coordination_integrity +
        0.12 * p.governance_responsiveness +
        0.13 * p.psychological_safety -
        0.08 * p.external_exposure -
        0.07 * p.complexity_load -
        0.10 * p.accumulated_fragility;
}

int main() {
    ResilienceProfile unit{78, 72, 81, 79, 74, 83, 42, 51, 22};
    std::cout << "Synthetic institutional resilience capacity score: "
              << resilience_capacity(unit) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
    return 0;
}

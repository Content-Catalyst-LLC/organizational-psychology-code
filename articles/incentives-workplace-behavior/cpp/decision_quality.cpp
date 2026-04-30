#include <iostream>

// Toy decision-quality score.
// Compile with: g++ cpp/decision_quality.cpp -o outputs/decision_quality

int main() {
    double information_flow = 0.78;
    double cognitive_diversity = 0.65;
    double bias_control = 0.70;
    double time_pressure = 0.35;
    double siloing = 0.30;

    double decision_quality =
        0.30 * information_flow +
        0.22 * cognitive_diversity +
        0.24 * bias_control -
        0.18 * time_pressure -
        0.20 * siloing;

    std::cout << "Decision quality score: " << decision_quality << "\n";
    return 0;
}

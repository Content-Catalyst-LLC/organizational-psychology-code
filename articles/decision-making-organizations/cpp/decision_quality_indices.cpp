#include <iostream>
int main() {
    double information_quality = 78, psychological_safety = 74, incentive_alignment = 72;
    double interpretive_diversity = 70, learning_capacity = 76;
    double coordination_load = 48, time_pressure = 51, bias_pressure = 38;
    double leadership_fragmentation = 22, metric_distortion = 25;
    double quality = information_quality + psychological_safety + incentive_alignment +
        interpretive_diversity + learning_capacity -
        coordination_load - time_pressure - bias_pressure -
        leadership_fragmentation - metric_distortion;
    std::cout << "Decision quality index: " << quality << "\n";
}

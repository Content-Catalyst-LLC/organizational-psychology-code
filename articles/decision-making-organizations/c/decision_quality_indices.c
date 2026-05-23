#include <stdio.h>

typedef struct {
    double information_quality;
    double psychological_safety;
    double incentive_alignment;
    double interpretive_diversity;
    double coordination_load;
    double time_pressure;
    double bias_pressure;
    double leadership_fragmentation;
    double metric_distortion;
    double learning_capacity;
} DecisionIndicators;

double decision_quality_index(DecisionIndicators x) {
    return x.information_quality + x.psychological_safety + x.incentive_alignment +
           x.interpretive_diversity + x.learning_capacity -
           x.coordination_load - x.time_pressure - x.bias_pressure -
           x.leadership_fragmentation - x.metric_distortion;
}

int main(void) {
    DecisionIndicators x = {78, 74, 72, 70, 48, 51, 38, 22, 25, 76};
    printf("Decision quality index: %.3f\n", decision_quality_index(x));
    return 0;
}

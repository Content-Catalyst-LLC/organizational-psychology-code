#include <stdio.h>

double leadership_capacity_score(double trust_generation, double communication_clarity,
    double motivational_support, double legitimacy_quality, double adaptive_coordination,
    double psychological_safety, double role_clarity, double ethical_accountability,
    double decision_transparency, double voice_access, double ambiguity_pressure,
    double distrust_pressure, double fragmentation_pressure, double overload_pressure) {
    return 0.11*trust_generation + 0.11*communication_clarity + 0.10*motivational_support +
           0.11*legitimacy_quality + 0.10*adaptive_coordination + 0.10*psychological_safety +
           0.08*role_clarity + 0.09*ethical_accountability + 0.08*decision_transparency +
           0.08*voice_access - 0.07*ambiguity_pressure - 0.08*distrust_pressure -
           0.07*fragmentation_pressure - 0.06*overload_pressure;
}

int main(void) {
    double score = leadership_capacity_score(83,81,79,82,80,81,80,82,81,80,20,18,22,24);
    printf("Synthetic leadership capacity score: %.2f\n", score);
    printf("Responsible-use reminder: institutional learning only.\n");
    return 0;
}

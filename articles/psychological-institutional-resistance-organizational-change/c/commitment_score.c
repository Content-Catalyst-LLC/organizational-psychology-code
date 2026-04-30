#include <stdio.h>

// Toy organizational commitment utility.
// Compile with: cc c/commitment_score.c -o outputs/commitment_score

double commitment_score(double motivation, double trust, double fairness, double role_clarity, double burnout) {
    return 0.25 * motivation + 0.25 * trust + 0.20 * fairness + 0.15 * role_clarity - 0.20 * burnout;
}

int main(void) {
    double score = commitment_score(0.75, 0.70, 0.65, 0.80, 0.25);
    printf("Commitment score: %.3f\n", score);
    return 0;
}

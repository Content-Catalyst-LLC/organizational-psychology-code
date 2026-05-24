package main

import "fmt"

func leadershipCapacityScore(t, c, m, l, a, p, r, e, d, v, u, di, f, o float64) float64 {
    return 0.11*t + 0.11*c + 0.10*m + 0.11*l + 0.10*a + 0.10*p +
        0.08*r + 0.09*e + 0.08*d + 0.08*v - 0.07*u - 0.08*di -
        0.07*f - 0.06*o
}

func main() {
    score := leadershipCapacityScore(83,81,79,82,80,81,80,82,81,80,20,18,22,24)
    fmt.Printf("Synthetic leadership capacity score: %.2f\n", score)
    fmt.Println("Responsible-use reminder: institutional learning only.")
}

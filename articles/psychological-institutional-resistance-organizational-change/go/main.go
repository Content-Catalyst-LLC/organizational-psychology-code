package main

import "fmt"

func decisionQuality(informationFlow, diversity, biasControl, timePressure, siloing float64) float64 {
	return 0.30*informationFlow + 0.22*diversity + 0.24*biasControl - 0.18*timePressure - 0.20*siloing
}

func main() {
	score := decisionQuality(0.78, 0.65, 0.70, 0.35, 0.30)
	fmt.Printf("Decision quality score: %.3f\n", score)
}

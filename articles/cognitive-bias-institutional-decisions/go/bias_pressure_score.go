// Cognitive Bias in Institutional Decisions
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, executive ranking,
// productivity ranking, or individual worker decisions.

package main

import "fmt"

type BiasPressureProfile struct {
	SignalQuality        float64
	ViewpointDiversity   float64
	AnalyticalDiscipline float64
	StructuredChallenge  float64
	HierarchySuppression float64
	TimePressure         float64
	RoutineReinforcement float64
	LearningReview       float64
	GroupConformity      float64
}

func BiasPressureScore(p BiasPressureProfile) float64 {
	return 0.16*p.HierarchySuppression +
		0.15*p.TimePressure +
		0.14*p.RoutineReinforcement +
		0.13*p.GroupConformity -
		0.16*p.ViewpointDiversity -
		0.13*p.AnalyticalDiscipline -
		0.14*p.StructuredChallenge -
		0.12*p.LearningReview -
		0.10*p.SignalQuality
}

func main() {
	profile := BiasPressureProfile{84, 80, 82, 81, 14, 38, 36, 79, 28}
	fmt.Printf("Synthetic bias pressure score: %.2f\n", BiasPressureScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

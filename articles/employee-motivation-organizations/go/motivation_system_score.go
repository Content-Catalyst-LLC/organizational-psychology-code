// Employee Motivation in Organizations
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// motivation scoring, loyalty scoring, or individual decisions.

package main

import "fmt"

type MotivationSystemProfile struct {
	AutonomySupport        float64
	CompetenceDevelopment float64
	RecognitionQuality    float64
	InstitutionalTrust    float64
	GoalClarity           float64
	FairnessPerception    float64
	WorkloadStrain        float64
	ControlPressure       float64
	Relatedness           float64
	MeaningfulWork        float64
	PsychologicalSafety   float64
	LeadershipCredibility float64
}

func MotivationQualityScore(p MotivationSystemProfile) float64 {
	return 0.12*p.AutonomySupport +
		0.11*p.CompetenceDevelopment +
		0.10*p.RecognitionQuality +
		0.12*p.InstitutionalTrust +
		0.10*p.GoalClarity +
		0.11*p.FairnessPerception +
		0.10*p.Relatedness +
		0.11*p.MeaningfulWork +
		0.10*p.PsychologicalSafety +
		0.10*p.LeadershipCredibility -
		0.08*p.WorkloadStrain -
		0.07*p.ControlPressure
}

func main() {
	profile := MotivationSystemProfile{84, 80, 79, 82, 83, 81, 22, 18, 82, 84, 80, 82}
	fmt.Printf("Synthetic motivation quality score: %.2f\n", MotivationQualityScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

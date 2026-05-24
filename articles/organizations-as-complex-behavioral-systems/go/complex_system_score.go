// Organizations as Complex Behavioral Systems
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// loyalty scoring, dissent tracking, or individual decisions.

package main

import "fmt"

type ComplexSystemProfile struct {
	PsychologicalSafety      float64
	LeadershipTrust         float64
	CulturalCoherence       float64
	IncentiveAlignment      float64
	InformationFlow         float64
	LearningCapacity        float64
	RedundancySlack         float64
	WorkloadPressure        float64
	SilenceRisk             float64
	FragmentationPressure   float64
	EnvironmentalUncertainty float64
}

func ComplexSystemRiskScore(p ComplexSystemProfile) float64 {
	return 0.11*(100.0-p.PsychologicalSafety) +
		0.11*(100.0-p.LeadershipTrust) +
		0.09*(100.0-p.CulturalCoherence) +
		0.09*(100.0-p.IncentiveAlignment) +
		0.09*(100.0-p.InformationFlow) +
		0.10*(100.0-p.LearningCapacity) +
		0.08*(100.0-p.RedundancySlack) +
		0.09*p.WorkloadPressure +
		0.08*p.SilenceRisk +
		0.10*p.FragmentationPressure +
		0.08*p.EnvironmentalUncertainty
}

func main() {
	profile := ComplexSystemProfile{84, 85, 82, 80, 83, 82, 68, 30, 18, 22, 42}
	fmt.Printf("Synthetic complex system risk score: %.2f\n", ComplexSystemRiskScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

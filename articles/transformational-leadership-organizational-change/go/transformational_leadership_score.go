// Transformational Leadership and Organizational Change
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// leadership-loyalty scoring, dissent tracking, or individual decisions.

package main

import "fmt"

type TransformationalLeadershipProfile struct {
	VisionCredibility     float64
	MotivationalAlignment float64
	IntellectualStimulation float64
	DevelopmentalSupport float64
	InstitutionalTrust   float64
	PsychologicalSafety  float64
	ChangeCommunication  float64
	ImplementationSupport float64
	MeaningMakingQuality float64
	ResistanceIntensity  float64
	AmbiguityPressure    float64
	ChangeFatigue        float64
}

func TransformationalCapacityScore(p TransformationalLeadershipProfile) float64 {
	return 0.12*p.VisionCredibility +
		0.11*p.MotivationalAlignment +
		0.11*p.IntellectualStimulation +
		0.10*p.DevelopmentalSupport +
		0.12*p.InstitutionalTrust +
		0.11*p.PsychologicalSafety +
		0.10*p.ChangeCommunication +
		0.09*p.ImplementationSupport +
		0.10*p.MeaningMakingQuality -
		0.08*p.ResistanceIntensity -
		0.07*p.AmbiguityPressure -
		0.08*p.ChangeFatigue
}

func main() {
	profile := TransformationalLeadershipProfile{84, 81, 80, 79, 82, 80, 83, 78, 82, 20, 22, 24}
	fmt.Printf("Synthetic transformational capacity score: %.2f\n", TransformationalCapacityScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

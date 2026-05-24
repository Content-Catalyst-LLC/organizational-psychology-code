// Leadership Styles and Organizational Performance
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// leadership-loyalty scoring, dissent tracking, or individual decisions.

package main

import "fmt"

type LeadershipStyleProfile struct {
	ParticipativeBehavior float64
	StructuralGuidance    float64
	CommunicationQuality  float64
	TrustGeneration       float64
	DevelopmentalSupport  float64
	PsychologicalSafety   float64
	DecisionFit           float64
	CulturalAlignment     float64
	ControlPressure       float64
	AmbiguityRisk         float64
	DisengagementPressure float64
}

func LeadershipEffectivenessScore(p LeadershipStyleProfile) float64 {
	return 0.11*p.ParticipativeBehavior +
		0.12*p.StructuralGuidance +
		0.13*p.CommunicationQuality +
		0.13*p.TrustGeneration +
		0.11*p.DevelopmentalSupport +
		0.12*p.PsychologicalSafety +
		0.11*p.DecisionFit +
		0.10*p.CulturalAlignment -
		0.08*p.ControlPressure -
		0.07*p.AmbiguityRisk -
		0.07*p.DisengagementPressure
}

func main() {
	profile := LeadershipStyleProfile{82, 80, 83, 81, 79, 80, 82, 81, 18, 22, 20}
	fmt.Printf("Synthetic leadership effectiveness score: %.2f\n", LeadershipEffectivenessScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

// Human Behavior in Organizations
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// loyalty scoring, dissent tracking, or individual decisions.

package main

import (
	"fmt"
	"math"
)

type HumanBehaviorProfile struct {
	Capability              float64
	Motivation              float64
	RoleClarity             float64
	PsychologicalSafety     float64
	LeadershipTrust         float64
	CulturalNormStrength    float64
	IncentiveAlignment      float64
	WorkloadPressure        float64
	BurnoutPressure         float64
	HierarchicalPressure    float64
	PerceivedVoiceEfficacy  float64
	FearOfRetaliation       float64
}

func BehaviorQualityScore(p HumanBehaviorProfile) float64 {
	return 0.16*p.Capability +
		0.15*p.Motivation +
		0.14*p.RoleClarity +
		0.12*p.PsychologicalSafety +
		0.12*p.LeadershipTrust +
		0.10*p.CulturalNormStrength +
		0.09*p.IncentiveAlignment -
		0.08*p.WorkloadPressure -
		0.08*p.BurnoutPressure -
		0.06*p.HierarchicalPressure
}

func VoiceProbability(p HumanBehaviorProfile) float64 {
	z := -2.0 +
		0.030*p.PsychologicalSafety +
		0.024*p.LeadershipTrust +
		0.022*p.PerceivedVoiceEfficacy -
		0.026*p.FearOfRetaliation -
		0.020*p.HierarchicalPressure
	return 1.0 / (1.0 + math.Exp(-z))
}

func main() {
	profile := HumanBehaviorProfile{72, 78, 82, 84, 85, 82, 80, 30, 24, 22, 80, 12}
	fmt.Printf("Synthetic behavior quality: %.2f\n", BehaviorQualityScore(profile))
	fmt.Printf("Synthetic voice probability: %.3f\n", VoiceProbability(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

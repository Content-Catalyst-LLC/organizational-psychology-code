// Psychological Safety in High-Performing Teams
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, courage scoring,
// voice scoring, productivity ranking, or individual worker decisions.

package main

import "fmt"

type PsychologicalSafetyProfile struct {
	LeadershipOpenness   float64
	InclusionQuality     float64
	LearningReviewQuality float64
	KnowledgeSharing     float64
	BlameIntensity       float64
	StatusAsymmetry      float64
	PerceivedPenalty     float64
	WorkloadPressure     float64
}

func PsychologicalSafetyScore(p PsychologicalSafetyProfile) float64 {
	return 0.18*p.LeadershipOpenness +
		0.16*p.InclusionQuality +
		0.15*p.LearningReviewQuality +
		0.14*p.KnowledgeSharing -
		0.13*p.BlameIntensity -
		0.11*p.StatusAsymmetry -
		0.10*p.PerceivedPenalty -
		0.06*p.WorkloadPressure
}

func main() {
	profile := PsychologicalSafetyProfile{84, 82, 80, 81, 16, 20, 18, 52}
	fmt.Printf("Synthetic psychological safety score: %.2f\n", PsychologicalSafetyScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

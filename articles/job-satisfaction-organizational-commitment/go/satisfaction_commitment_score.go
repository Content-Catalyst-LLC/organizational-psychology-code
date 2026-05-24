// Job Satisfaction and Organizational Commitment
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, commitment scoring,
// retention-risk scoring, productivity ranking, or individual decisions.

package main

import "fmt"

type WorkAttitudeProfile struct {
	LeadershipSupport       float64
	RewardFairness          float64
	DevelopmentalOpportunity float64
	WorkloadBalance         float64
	InstitutionalTrust      float64
	CulturalAlignment       float64
	RoleInsecurity          float64
	ExhaustionPressure      float64
}

func JobSatisfactionScore(p WorkAttitudeProfile) float64 {
	return 0.16*p.LeadershipSupport +
		0.15*p.RewardFairness +
		0.13*p.DevelopmentalOpportunity +
		0.14*p.WorkloadBalance +
		0.13*p.InstitutionalTrust +
		0.10*p.CulturalAlignment -
		0.09*p.RoleInsecurity -
		0.10*p.ExhaustionPressure
}

func main() {
	profile := WorkAttitudeProfile{84, 79, 82, 76, 83, 81, 18, 22}
	fmt.Printf("Synthetic job satisfaction score: %.2f\n", JobSatisfactionScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

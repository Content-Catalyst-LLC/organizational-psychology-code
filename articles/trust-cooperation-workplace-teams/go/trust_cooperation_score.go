// Trust and Cooperation in Workplace Teams
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, trustworthiness scoring,
// cooperation scoring, productivity ranking, or individual decisions.

package main

import "fmt"

type TrustCooperationProfile struct {
	CompetenceTrust         float64
	IntegrityTrust          float64
	BenevolenceTrust         float64
	ReciprocityNorms        float64
	CommunicationReliability float64
	OpportunismRisk         float64
	PowerImbalance          float64
	UncertaintyLoad         float64
	LeadershipCredibility   float64
	InstitutionalTrust      float64
}

func CooperativeCapacityScore(p TrustCooperationProfile) float64 {
	return 0.13*p.CompetenceTrust +
		0.14*p.IntegrityTrust +
		0.12*p.BenevolenceTrust +
		0.13*p.ReciprocityNorms +
		0.12*p.CommunicationReliability +
		0.11*p.LeadershipCredibility +
		0.11*p.InstitutionalTrust -
		0.10*p.OpportunismRisk -
		0.08*p.PowerImbalance -
		0.05*p.UncertaintyLoad
}

func main() {
	profile := TrustCooperationProfile{84, 82, 78, 81, 83, 16, 20, 52, 84, 82}
	fmt.Printf("Synthetic cooperative capacity score: %.2f\n", CooperativeCapacityScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

// What Is Organizational Psychology?
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// loyalty scoring, dissent tracking, or individual decisions.

package main

import "fmt"

type WorkSystemProfile struct {
	Capability          float64
	Motivation          float64
	RoleClarity         float64
	Autonomy            float64
	Fairness            float64
	TeamCoordination    float64
	LeadershipTrust     float64
	PsychologicalSafety float64
	CommunicationQuality float64
	CultureStrength     float64
	WorkloadPressure    float64
	BurnoutPressure     float64
	InstitutionalSupport float64
	VoiceAccess         float64
}

func OutcomeQualityScore(p WorkSystemProfile) float64 {
	return 0.11*p.Capability +
		0.10*p.Motivation +
		0.10*p.RoleClarity +
		0.07*p.Autonomy +
		0.08*p.Fairness +
		0.09*p.TeamCoordination +
		0.10*p.LeadershipTrust +
		0.10*p.PsychologicalSafety +
		0.08*p.CommunicationQuality +
		0.06*p.CultureStrength +
		0.08*p.InstitutionalSupport +
		0.06*p.VoiceAccess -
		0.07*p.WorkloadPressure -
		0.08*p.BurnoutPressure
}

func main() {
	profile := WorkSystemProfile{72, 76, 82, 78, 80, 80, 84, 81, 82, 79, 28, 25, 82, 80}
	fmt.Printf("Synthetic modeled outcome quality: %.2f\n", OutcomeQualityScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

// Resistance to Organizational Change
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment or individual worker decisions.

package main

import "fmt"

type ChangeProfile struct {
	PerceivedLoss        float64
	Uncertainty          float64
	IdentityThreat       float64
	RoutineEmbeddedness  float64
	PowerDisplacement    float64
	TrustInLeadership    float64
	ParticipationQuality float64
	ImplementationClarity float64
	WorkloadStrain       float64
	FailedChangeHistory  float64
}

func ResistanceIntensity(p ChangeProfile) float64 {
	return 0.17*p.PerceivedLoss +
		0.16*p.Uncertainty +
		0.13*p.IdentityThreat +
		0.13*p.RoutineEmbeddedness +
		0.10*p.PowerDisplacement +
		0.10*p.WorkloadStrain +
		6.0*p.FailedChangeHistory -
		0.12*p.TrustInLeadership -
		0.08*p.ParticipationQuality -
		0.09*p.ImplementationClarity
}

func main() {
	profile := ChangeProfile{26, 32, 24, 52, 20, 84, 81, 86, 41, 0}
	fmt.Printf("Synthetic institutional resistance intensity score: %.2f\n", ResistanceIntensity(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

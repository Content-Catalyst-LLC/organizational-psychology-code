// Learning Organizations and Knowledge Systems
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment or individual worker decisions.

package main

import "fmt"

type LearningProfile struct {
	InformationQuality  float64
	InterpretiveOpen    float64
	MemoryRetention     float64
	CommunicationFlow   float64
	PsychologicalSafety  float64
	GovernanceSupport    float64
	ComplexityLoad       float64
	SiloIntensity        float64
	IncentiveDistortion  float64
	TurnoverPressure     float64
}

func LearningCapacity(p LearningProfile) float64 {
	return 0.17*p.InformationQuality +
		0.18*p.InterpretiveOpen +
		0.15*p.MemoryRetention +
		0.15*p.CommunicationFlow +
		0.13*p.PsychologicalSafety +
		0.10*p.GovernanceSupport -
		0.07*p.ComplexityLoad -
		0.10*p.SiloIntensity -
		0.10*p.IncentiveDistortion -
		0.05*p.TurnoverPressure
}

func main() {
	profile := LearningProfile{84, 82, 83, 86, 84, 78, 48, 20, 17, 19}
	fmt.Printf("Synthetic institutional learning capacity score: %.2f\n", LearningCapacity(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

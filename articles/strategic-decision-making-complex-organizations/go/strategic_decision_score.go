// Strategic Decision-Making in Complex Organizations
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, executive ranking,
// or individual worker decisions.

package main

import "fmt"

type StrategicDecisionProfile struct {
	SensingQuality          float64
	InterpretiveCoherence  float64
	KnowledgeIntegration   float64
	OptionDiversity        float64
	GovernanceQuality      float64
	AdaptiveLearning       float64
	BiasPressure           float64
	PoliticalDistortion    float64
	ComplexityLoad         float64
	EnvironmentalTurbulence float64
}

func StrategicDecisionQuality(p StrategicDecisionProfile) float64 {
	return 0.17*p.SensingQuality +
		0.16*p.InterpretiveCoherence +
		0.16*p.KnowledgeIntegration +
		0.12*p.OptionDiversity +
		0.13*p.GovernanceQuality +
		0.14*p.AdaptiveLearning -
		0.12*p.BiasPressure -
		0.10*p.PoliticalDistortion -
		0.09*p.ComplexityLoad -
		0.08*p.EnvironmentalTurbulence
}

func main() {
	profile := StrategicDecisionProfile{84, 79, 82, 74, 77, 81, 18, 14, 58, 62}
	fmt.Printf("Synthetic strategic decision quality score: %.2f\n", StrategicDecisionQuality(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

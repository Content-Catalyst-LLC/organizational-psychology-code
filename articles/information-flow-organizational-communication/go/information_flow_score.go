// Information Flow and Organizational Communication
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, communication surveillance,
// productivity ranking, or individual worker decisions.

package main

import "fmt"

type InformationFlowProfile struct {
	SignalQuality               float64
	Timeliness                  float64
	InterpretiveClarity          float64
	CrossFunctionalConnectivity float64
	PsychologicalSafety          float64
	DistortionRisk              float64
	OverloadPressure            float64
	HierarchyDelay              float64
	ExternalSignalTurbulence    float64
}

func InformationFlowQuality(p InformationFlowProfile) float64 {
	return 0.18*p.SignalQuality +
		0.15*p.Timeliness +
		0.15*p.InterpretiveClarity +
		0.14*p.CrossFunctionalConnectivity +
		0.13*p.PsychologicalSafety -
		0.10*p.DistortionRisk -
		0.08*p.OverloadPressure -
		0.10*p.HierarchyDelay -
		0.05*p.ExternalSignalTurbulence
}

func main() {
	profile := InformationFlowProfile{84, 82, 80, 79, 83, 14, 32, 18, 58}
	fmt.Printf("Synthetic information flow quality score: %.2f\n", InformationFlowQuality(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

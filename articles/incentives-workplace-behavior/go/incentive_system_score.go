// Incentives and Workplace Behavior
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// incentive-compliance scoring, or individual decisions.

package main

import "fmt"

type IncentiveSystemProfile struct {
	ExpectancyStrength     float64
	FairnessPerception    float64
	StrategicAlignment    float64
	IntrinsicSupport      float64
	FeedbackClarity       float64
	DistortionRisk        float64
	OverloadPressure      float64
	EthicalRisk           float64
	CooperationSupport    float64
	RecognitionLegitimacy float64
	RewardTransparency   float64
	HiddenLaborRecognition float64
}

func IncentiveEffectivenessScore(p IncentiveSystemProfile) float64 {
	return 0.12*p.ExpectancyStrength +
		0.13*p.FairnessPerception +
		0.12*p.StrategicAlignment +
		0.10*p.IntrinsicSupport +
		0.11*p.FeedbackClarity +
		0.10*p.CooperationSupport +
		0.10*p.RecognitionLegitimacy +
		0.09*p.RewardTransparency +
		0.08*p.HiddenLaborRecognition -
		0.08*p.DistortionRisk -
		0.07*p.OverloadPressure -
		0.08*p.EthicalRisk
}

func main() {
	profile := IncentiveSystemProfile{83, 81, 82, 79, 80, 18, 24, 16, 82, 80, 81, 78}
	fmt.Printf("Synthetic incentive effectiveness score: %.2f\n", IncentiveEffectivenessScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

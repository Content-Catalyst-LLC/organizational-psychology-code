// The Evolution of Organizational Psychology
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, organizational psychology
// education, and history-of-field analysis only. Not for employee, scholar,
// department, journal, or institution ranking.

package main

import "fmt"

type FieldEmphasis struct {
	SelectionTesting                  float64
	EfficiencyWorkDesign              float64
	MotivationAttitudes               float64
	GroupsTeams                       float64
	CultureLeadershipChange           float64
	WellbeingStress                   float64
	JusticeValidityEthics            float64
	DigitalAnalytics                  float64
	SystemsInstitutionalAccountability float64
}

func ResponsibleProgressScore(f FieldEmphasis) float64 {
	return 0.18*f.SelectionTesting +
		0.08*f.EfficiencyWorkDesign +
		0.12*f.MotivationAttitudes +
		0.12*f.GroupsTeams +
		0.14*f.CultureLeadershipChange +
		0.15*f.WellbeingStress +
		0.17*f.JusticeValidityEthics +
		0.08*f.DigitalAnalytics +
		0.06*f.SystemsInstitutionalAccountability
}

func main() {
	broad := FieldEmphasis{72, 66, 84, 86, 88, 86, 92, 84, 90}
	fmt.Printf("Synthetic responsible progress score: %.2f\n", ResponsibleProgressScore(broad))
	fmt.Println("Responsible-use reminder: educational field-evolution demo only.")
}

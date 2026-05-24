// Team Dynamics in Organizations
// Simple Go scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, team-fit scoring,
// collaboration scoring, productivity ranking, or individual decisions.

package main

import "fmt"

type TeamDynamicsProfile struct {
	CommunicationQuality  float64
	TrustLevel            float64
	RoleClarity           float64
	PsychologicalSafety   float64
	LeadershipSupport     float64
	ConflictLoad          float64
	TaskAmbiguity         float64
	CoordinationCost      float64
	ParticipationEquity   float64
	LearningRoutineQuality float64
}

func TeamEffectivenessScore(p TeamDynamicsProfile) float64 {
	return 0.14*p.CommunicationQuality +
		0.12*p.TrustLevel +
		0.12*p.RoleClarity +
		0.13*p.PsychologicalSafety +
		0.12*p.LeadershipSupport +
		0.11*p.ParticipationEquity +
		0.11*p.LearningRoutineQuality -
		0.09*p.ConflictLoad -
		0.08*p.TaskAmbiguity -
		0.09*p.CoordinationCost
}

func main() {
	profile := TeamDynamicsProfile{84, 82, 79, 83, 80, 22, 30, 34, 82, 80}
	fmt.Printf("Synthetic team effectiveness score: %.2f\n", TeamEffectivenessScore(profile))
	fmt.Println("Responsible-use reminder: institutional learning only.")
}

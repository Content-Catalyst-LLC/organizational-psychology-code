// Team Dynamics in Organizations
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, team-fit scoring,
// collaboration scoring, productivity ranking, or individual decisions.

struct TeamDynamicsProfile {
    communication_quality: f64,
    trust_level: f64,
    role_clarity: f64,
    psychological_safety: f64,
    leadership_support: f64,
    conflict_load: f64,
    task_ambiguity: f64,
    coordination_cost: f64,
    participation_equity: f64,
    learning_routine_quality: f64,
}

fn team_effectiveness_score(p: &TeamDynamicsProfile) -> f64 {
    0.14 * p.communication_quality
        + 0.12 * p.trust_level
        + 0.12 * p.role_clarity
        + 0.13 * p.psychological_safety
        + 0.12 * p.leadership_support
        + 0.11 * p.participation_equity
        + 0.11 * p.learning_routine_quality
        - 0.09 * p.conflict_load
        - 0.08 * p.task_ambiguity
        - 0.09 * p.coordination_cost
}

fn main() {
    let profile = TeamDynamicsProfile {
        communication_quality: 84.0,
        trust_level: 82.0,
        role_clarity: 79.0,
        psychological_safety: 83.0,
        leadership_support: 80.0,
        conflict_load: 22.0,
        task_ambiguity: 30.0,
        coordination_cost: 34.0,
        participation_equity: 82.0,
        learning_routine_quality: 80.0,
    };

    println!(
        "Synthetic team effectiveness score: {:.2}",
        team_effectiveness_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

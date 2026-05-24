// What Is Organizational Psychology?
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// loyalty scoring, dissent tracking, or individual decisions.

struct WorkSystemProfile {
    capability: f64,
    motivation: f64,
    role_clarity: f64,
    autonomy: f64,
    fairness: f64,
    team_coordination: f64,
    leadership_trust: f64,
    psychological_safety: f64,
    communication_quality: f64,
    culture_strength: f64,
    workload_pressure: f64,
    burnout_pressure: f64,
    institutional_support: f64,
    voice_access: f64,
}

fn outcome_quality_score(p: &WorkSystemProfile) -> f64 {
    0.11 * p.capability
        + 0.10 * p.motivation
        + 0.10 * p.role_clarity
        + 0.07 * p.autonomy
        + 0.08 * p.fairness
        + 0.09 * p.team_coordination
        + 0.10 * p.leadership_trust
        + 0.10 * p.psychological_safety
        + 0.08 * p.communication_quality
        + 0.06 * p.culture_strength
        + 0.08 * p.institutional_support
        + 0.06 * p.voice_access
        - 0.07 * p.workload_pressure
        - 0.08 * p.burnout_pressure
}

fn main() {
    let profile = WorkSystemProfile {
        capability: 72.0,
        motivation: 76.0,
        role_clarity: 82.0,
        autonomy: 78.0,
        fairness: 80.0,
        team_coordination: 80.0,
        leadership_trust: 84.0,
        psychological_safety: 81.0,
        communication_quality: 82.0,
        culture_strength: 79.0,
        workload_pressure: 28.0,
        burnout_pressure: 25.0,
        institutional_support: 82.0,
        voice_access: 80.0,
    };

    println!(
        "Synthetic modeled outcome quality: {:.2}",
        outcome_quality_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

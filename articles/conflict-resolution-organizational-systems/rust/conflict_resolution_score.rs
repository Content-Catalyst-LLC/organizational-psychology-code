// Conflict Resolution in Organizational Systems
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, conflict-proneness
// scoring, collaboration scoring, productivity ranking, or individual decisions.

struct ConflictResolutionProfile {
    trust_level: f64,
    communication_clarity: f64,
    psychological_safety: f64,
    procedural_fairness: f64,
    integrative_skill: f64,
    blame_intensity: f64,
    power_asymmetry: f64,
    resource_strain: f64,
    mediation_access: f64,
}

fn constructive_conflict_capacity_score(p: &ConflictResolutionProfile) -> f64 {
    0.16 * p.trust_level
        + 0.15 * p.communication_clarity
        + 0.14 * p.psychological_safety
        + 0.15 * p.procedural_fairness
        + 0.12 * p.integrative_skill
        + 0.10 * p.mediation_access
        - 0.10 * p.blame_intensity
        - 0.09 * p.power_asymmetry
        - 0.07 * p.resource_strain
}

fn main() {
    let profile = ConflictResolutionProfile {
        trust_level: 82.0,
        communication_clarity: 80.0,
        psychological_safety: 81.0,
        procedural_fairness: 83.0,
        integrative_skill: 76.0,
        blame_intensity: 18.0,
        power_asymmetry: 22.0,
        resource_strain: 45.0,
        mediation_access: 84.0,
    };

    println!(
        "Synthetic constructive conflict capacity score: {:.2}",
        constructive_conflict_capacity_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

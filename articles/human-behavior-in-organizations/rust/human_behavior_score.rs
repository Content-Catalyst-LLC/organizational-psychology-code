// Human Behavior in Organizations
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// loyalty scoring, dissent tracking, or individual decisions.

struct HumanBehaviorProfile {
    capability: f64,
    motivation: f64,
    role_clarity: f64,
    psychological_safety: f64,
    leadership_trust: f64,
    cultural_norm_strength: f64,
    incentive_alignment: f64,
    workload_pressure: f64,
    burnout_pressure: f64,
    hierarchical_pressure: f64,
    perceived_voice_efficacy: f64,
    fear_of_retaliation: f64,
}

fn behavior_quality_score(p: &HumanBehaviorProfile) -> f64 {
    0.16 * p.capability
        + 0.15 * p.motivation
        + 0.14 * p.role_clarity
        + 0.12 * p.psychological_safety
        + 0.12 * p.leadership_trust
        + 0.10 * p.cultural_norm_strength
        + 0.09 * p.incentive_alignment
        - 0.08 * p.workload_pressure
        - 0.08 * p.burnout_pressure
        - 0.06 * p.hierarchical_pressure
}

fn voice_probability(p: &HumanBehaviorProfile) -> f64 {
    let z = -2.0
        + 0.030 * p.psychological_safety
        + 0.024 * p.leadership_trust
        + 0.022 * p.perceived_voice_efficacy
        - 0.026 * p.fear_of_retaliation
        - 0.020 * p.hierarchical_pressure;
    1.0 / (1.0 + (-z).exp())
}

fn main() {
    let profile = HumanBehaviorProfile {
        capability: 72.0,
        motivation: 78.0,
        role_clarity: 82.0,
        psychological_safety: 84.0,
        leadership_trust: 85.0,
        cultural_norm_strength: 82.0,
        incentive_alignment: 80.0,
        workload_pressure: 30.0,
        burnout_pressure: 24.0,
        hierarchical_pressure: 22.0,
        perceived_voice_efficacy: 80.0,
        fear_of_retaliation: 12.0,
    };

    println!(
        "Synthetic behavior quality: {:.2}",
        behavior_quality_score(&profile)
    );
    println!(
        "Synthetic voice probability: {:.3}",
        voice_probability(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

// Learning Organizations and Knowledge Systems
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment or individual worker decisions.

struct LearningProfile {
    information_quality: f64,
    interpretive_openness: f64,
    memory_retention: f64,
    communication_flow: f64,
    psychological_safety: f64,
    governance_support: f64,
    complexity_load: f64,
    silo_intensity: f64,
    incentive_distortion: f64,
    turnover_pressure: f64,
}

fn learning_capacity(p: &LearningProfile) -> f64 {
    0.17 * p.information_quality
        + 0.18 * p.interpretive_openness
        + 0.15 * p.memory_retention
        + 0.15 * p.communication_flow
        + 0.13 * p.psychological_safety
        + 0.10 * p.governance_support
        - 0.07 * p.complexity_load
        - 0.10 * p.silo_intensity
        - 0.10 * p.incentive_distortion
        - 0.05 * p.turnover_pressure
}

fn main() {
    let profile = LearningProfile {
        information_quality: 84.0,
        interpretive_openness: 82.0,
        memory_retention: 83.0,
        communication_flow: 86.0,
        psychological_safety: 84.0,
        governance_support: 78.0,
        complexity_load: 48.0,
        silo_intensity: 20.0,
        incentive_distortion: 17.0,
        turnover_pressure: 19.0,
    };

    println!(
        "Synthetic institutional learning capacity score: {:.2}",
        learning_capacity(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

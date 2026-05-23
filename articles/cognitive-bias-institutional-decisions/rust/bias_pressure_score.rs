// Cognitive Bias in Institutional Decisions
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, executive ranking,
// productivity ranking, or individual worker decisions.

struct BiasPressureProfile {
    signal_quality: f64,
    viewpoint_diversity: f64,
    analytical_discipline: f64,
    structured_challenge: f64,
    hierarchy_suppression: f64,
    time_pressure: f64,
    routine_reinforcement: f64,
    learning_review: f64,
    group_conformity: f64,
}

fn bias_pressure_score(p: &BiasPressureProfile) -> f64 {
    0.16 * p.hierarchy_suppression
        + 0.15 * p.time_pressure
        + 0.14 * p.routine_reinforcement
        + 0.13 * p.group_conformity
        - 0.16 * p.viewpoint_diversity
        - 0.13 * p.analytical_discipline
        - 0.14 * p.structured_challenge
        - 0.12 * p.learning_review
        - 0.10 * p.signal_quality
}

fn main() {
    let profile = BiasPressureProfile {
        signal_quality: 84.0,
        viewpoint_diversity: 80.0,
        analytical_discipline: 82.0,
        structured_challenge: 81.0,
        hierarchy_suppression: 14.0,
        time_pressure: 38.0,
        routine_reinforcement: 36.0,
        learning_review: 79.0,
        group_conformity: 28.0,
    };

    println!(
        "Synthetic bias pressure score: {:.2}",
        bias_pressure_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

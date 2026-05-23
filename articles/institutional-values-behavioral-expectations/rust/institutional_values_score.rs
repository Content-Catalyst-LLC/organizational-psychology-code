// Institutional Values and Behavioral Expectations
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, cultural-loyalty scoring,
// morality scoring, productivity ranking, or individual worker decisions.

struct InstitutionalValuesProfile {
    value_clarity: f64,
    leadership_consistency: f64,
    reinforcement_alignment: f64,
    psychological_safety: f64,
    accountability_strength: f64,
    decoupling_risk: f64,
    incentive_contradiction: f64,
    hierarchy_exemption: f64,
    legitimacy_pressure: f64,
}

fn value_practice_alignment_score(p: &InstitutionalValuesProfile) -> f64 {
    0.17 * p.value_clarity
        + 0.16 * p.leadership_consistency
        + 0.16 * p.reinforcement_alignment
        + 0.14 * p.psychological_safety
        + 0.14 * p.accountability_strength
        - 0.10 * p.decoupling_risk
        - 0.09 * p.incentive_contradiction
        - 0.09 * p.hierarchy_exemption
        - 0.05 * p.legitimacy_pressure
}

fn main() {
    let profile = InstitutionalValuesProfile {
        value_clarity: 86.0,
        leadership_consistency: 83.0,
        reinforcement_alignment: 81.0,
        psychological_safety: 82.0,
        accountability_strength: 80.0,
        decoupling_risk: 16.0,
        incentive_contradiction: 20.0,
        hierarchy_exemption: 12.0,
        legitimacy_pressure: 58.0,
    };

    println!(
        "Synthetic value-practice alignment score: {:.2}",
        value_practice_alignment_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

// Leadership Styles and Organizational Performance
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// leadership-loyalty scoring, dissent tracking, or individual decisions.

struct LeadershipStyleProfile {
    participative_behavior: f64,
    structural_guidance: f64,
    communication_quality: f64,
    trust_generation: f64,
    developmental_support: f64,
    psychological_safety: f64,
    decision_fit: f64,
    cultural_alignment: f64,
    control_pressure: f64,
    ambiguity_risk: f64,
    disengagement_pressure: f64,
}

fn leadership_effectiveness_score(p: &LeadershipStyleProfile) -> f64 {
    0.11 * p.participative_behavior
        + 0.12 * p.structural_guidance
        + 0.13 * p.communication_quality
        + 0.13 * p.trust_generation
        + 0.11 * p.developmental_support
        + 0.12 * p.psychological_safety
        + 0.11 * p.decision_fit
        + 0.10 * p.cultural_alignment
        - 0.08 * p.control_pressure
        - 0.07 * p.ambiguity_risk
        - 0.07 * p.disengagement_pressure
}

fn main() {
    let profile = LeadershipStyleProfile {
        participative_behavior: 82.0,
        structural_guidance: 80.0,
        communication_quality: 83.0,
        trust_generation: 81.0,
        developmental_support: 79.0,
        psychological_safety: 80.0,
        decision_fit: 82.0,
        cultural_alignment: 81.0,
        control_pressure: 18.0,
        ambiguity_risk: 22.0,
        disengagement_pressure: 20.0,
    };

    println!(
        "Synthetic leadership effectiveness score: {:.2}",
        leadership_effectiveness_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

// Transformational Leadership and Organizational Change
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// leadership-loyalty scoring, dissent tracking, or individual decisions.

struct TransformationalLeadershipProfile {
    vision_credibility: f64,
    motivational_alignment: f64,
    intellectual_stimulation: f64,
    developmental_support: f64,
    institutional_trust: f64,
    psychological_safety: f64,
    change_communication: f64,
    implementation_support: f64,
    meaning_making_quality: f64,
    resistance_intensity: f64,
    ambiguity_pressure: f64,
    change_fatigue: f64,
}

fn transformational_capacity_score(p: &TransformationalLeadershipProfile) -> f64 {
    0.12 * p.vision_credibility
        + 0.11 * p.motivational_alignment
        + 0.11 * p.intellectual_stimulation
        + 0.10 * p.developmental_support
        + 0.12 * p.institutional_trust
        + 0.11 * p.psychological_safety
        + 0.10 * p.change_communication
        + 0.09 * p.implementation_support
        + 0.10 * p.meaning_making_quality
        - 0.08 * p.resistance_intensity
        - 0.07 * p.ambiguity_pressure
        - 0.08 * p.change_fatigue
}

fn main() {
    let profile = TransformationalLeadershipProfile {
        vision_credibility: 84.0,
        motivational_alignment: 81.0,
        intellectual_stimulation: 80.0,
        developmental_support: 79.0,
        institutional_trust: 82.0,
        psychological_safety: 80.0,
        change_communication: 83.0,
        implementation_support: 78.0,
        meaning_making_quality: 82.0,
        resistance_intensity: 20.0,
        ambiguity_pressure: 22.0,
        change_fatigue: 24.0,
    };

    println!(
        "Synthetic transformational capacity score: {:.2}",
        transformational_capacity_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

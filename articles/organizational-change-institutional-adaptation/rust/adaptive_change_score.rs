// Adaptive Organizations: Institutional Change and Strategic Transformation
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment or individual worker decisions.

struct AdaptiveChangeProfile {
    sensing_quality: f64,
    interpretive_coherence: f64,
    governance_alignment: f64,
    learning_capability: f64,
    resource_flexibility: f64,
    institutional_legitimacy: f64,
    organizational_inertia: f64,
    fragmentation: f64,
    resistance_friction: f64,
    environmental_pressure: f64,
}

fn adaptive_change_capacity(p: &AdaptiveChangeProfile) -> f64 {
    0.17 * p.sensing_quality
        + 0.16 * p.interpretive_coherence
        + 0.15 * p.governance_alignment
        + 0.16 * p.learning_capability
        + 0.12 * p.resource_flexibility
        + 0.12 * p.institutional_legitimacy
        - 0.13 * p.organizational_inertia
        - 0.11 * p.fragmentation
        - 0.10 * p.resistance_friction
        - 0.05 * p.environmental_pressure
}

fn main() {
    let profile = AdaptiveChangeProfile {
        sensing_quality: 84.0,
        interpretive_coherence: 81.0,
        governance_alignment: 79.0,
        learning_capability: 83.0,
        resource_flexibility: 74.0,
        institutional_legitimacy: 80.0,
        organizational_inertia: 20.0,
        fragmentation: 18.0,
        resistance_friction: 24.0,
        environmental_pressure: 62.0,
    };

    println!(
        "Synthetic adaptive change capacity score: {:.2}",
        adaptive_change_capacity(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

// Strategic Decision-Making in Complex Organizations
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, executive ranking,
// or individual worker decisions.

struct StrategicDecisionProfile {
    sensing_quality: f64,
    interpretive_coherence: f64,
    knowledge_integration: f64,
    option_diversity: f64,
    governance_quality: f64,
    adaptive_learning: f64,
    bias_pressure: f64,
    political_distortion: f64,
    complexity_load: f64,
    environmental_turbulence: f64,
}

fn strategic_decision_quality(p: &StrategicDecisionProfile) -> f64 {
    0.17 * p.sensing_quality
        + 0.16 * p.interpretive_coherence
        + 0.16 * p.knowledge_integration
        + 0.12 * p.option_diversity
        + 0.13 * p.governance_quality
        + 0.14 * p.adaptive_learning
        - 0.12 * p.bias_pressure
        - 0.10 * p.political_distortion
        - 0.09 * p.complexity_load
        - 0.08 * p.environmental_turbulence
}

fn main() {
    let profile = StrategicDecisionProfile {
        sensing_quality: 84.0,
        interpretive_coherence: 79.0,
        knowledge_integration: 82.0,
        option_diversity: 74.0,
        governance_quality: 77.0,
        adaptive_learning: 81.0,
        bias_pressure: 18.0,
        political_distortion: 14.0,
        complexity_load: 58.0,
        environmental_turbulence: 62.0,
    };

    println!(
        "Synthetic strategic decision quality score: {:.2}",
        strategic_decision_quality(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

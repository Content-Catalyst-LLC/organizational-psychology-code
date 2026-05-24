// Organizations as Complex Behavioral Systems
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// loyalty scoring, dissent tracking, or individual decisions.

struct ComplexSystemProfile {
    psychological_safety: f64,
    leadership_trust: f64,
    cultural_coherence: f64,
    incentive_alignment: f64,
    information_flow: f64,
    learning_capacity: f64,
    redundancy_slack: f64,
    workload_pressure: f64,
    silence_risk: f64,
    fragmentation_pressure: f64,
    environmental_uncertainty: f64,
}

fn complex_system_risk_score(p: &ComplexSystemProfile) -> f64 {
    0.11 * (100.0 - p.psychological_safety)
        + 0.11 * (100.0 - p.leadership_trust)
        + 0.09 * (100.0 - p.cultural_coherence)
        + 0.09 * (100.0 - p.incentive_alignment)
        + 0.09 * (100.0 - p.information_flow)
        + 0.10 * (100.0 - p.learning_capacity)
        + 0.08 * (100.0 - p.redundancy_slack)
        + 0.09 * p.workload_pressure
        + 0.08 * p.silence_risk
        + 0.10 * p.fragmentation_pressure
        + 0.08 * p.environmental_uncertainty
}

fn main() {
    let profile = ComplexSystemProfile {
        psychological_safety: 84.0,
        leadership_trust: 85.0,
        cultural_coherence: 82.0,
        incentive_alignment: 80.0,
        information_flow: 83.0,
        learning_capacity: 82.0,
        redundancy_slack: 68.0,
        workload_pressure: 30.0,
        silence_risk: 18.0,
        fragmentation_pressure: 22.0,
        environmental_uncertainty: 42.0,
    };

    println!(
        "Synthetic complex system risk score: {:.2}",
        complex_system_risk_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

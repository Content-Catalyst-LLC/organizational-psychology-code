// Organizational Resilience in Complex Systems
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment or individual worker decisions.

struct ResilienceProfile {
    robustness: f64,
    redundancy: f64,
    adaptive_learning: f64,
    coordination_integrity: f64,
    governance_responsiveness: f64,
    psychological_safety: f64,
    external_exposure: f64,
    complexity_load: f64,
    accumulated_fragility: f64,
}

fn resilience_capacity(p: &ResilienceProfile) -> f64 {
    0.18 * p.robustness
        + 0.12 * p.redundancy
        + 0.16 * p.adaptive_learning
        + 0.14 * p.coordination_integrity
        + 0.12 * p.governance_responsiveness
        + 0.13 * p.psychological_safety
        - 0.08 * p.external_exposure
        - 0.07 * p.complexity_load
        - 0.10 * p.accumulated_fragility
}

fn main() {
    let unit = ResilienceProfile {
        robustness: 78.0,
        redundancy: 72.0,
        adaptive_learning: 81.0,
        coordination_integrity: 79.0,
        governance_responsiveness: 74.0,
        psychological_safety: 83.0,
        external_exposure: 42.0,
        complexity_load: 51.0,
        accumulated_fragility: 22.0,
    };

    println!(
        "Synthetic institutional resilience capacity score: {:.2}",
        resilience_capacity(&unit)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

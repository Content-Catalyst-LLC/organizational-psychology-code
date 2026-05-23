// Resistance to Organizational Change
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment or individual worker decisions.

struct ChangeProfile {
    perceived_loss: f64,
    uncertainty: f64,
    identity_threat: f64,
    routine_embeddedness: f64,
    power_displacement: f64,
    trust_in_leadership: f64,
    participation_quality: f64,
    implementation_clarity: f64,
    workload_strain: f64,
    failed_change_history: f64,
}

fn resistance_intensity(p: &ChangeProfile) -> f64 {
    0.17 * p.perceived_loss
        + 0.16 * p.uncertainty
        + 0.13 * p.identity_threat
        + 0.13 * p.routine_embeddedness
        + 0.10 * p.power_displacement
        + 0.10 * p.workload_strain
        + 6.0 * p.failed_change_history
        - 0.12 * p.trust_in_leadership
        - 0.08 * p.participation_quality
        - 0.09 * p.implementation_clarity
}

fn main() {
    let profile = ChangeProfile {
        perceived_loss: 26.0,
        uncertainty: 32.0,
        identity_threat: 24.0,
        routine_embeddedness: 52.0,
        power_displacement: 20.0,
        trust_in_leadership: 84.0,
        participation_quality: 81.0,
        implementation_clarity: 86.0,
        workload_strain: 41.0,
        failed_change_history: 0.0,
    };

    println!(
        "Synthetic institutional resistance intensity score: {:.2}",
        resistance_intensity(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

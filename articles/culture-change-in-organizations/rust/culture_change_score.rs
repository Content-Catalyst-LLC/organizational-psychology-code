// Culture Change in Organizations
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, cultural-loyalty scoring,
// productivity ranking, or individual worker decisions.

struct CultureChangeProfile {
    leadership_credibility: f64,
    narrative_coherence: f64,
    reinforcement_alignment: f64,
    adaptive_learning: f64,
    psychological_safety: f64,
    identity_adaptability: f64,
    resistance_intensity: f64,
    subcultural_fragmentation: f64,
    legacy_lock_in: f64,
    leadership_turnover: f64,
}

fn culture_change_capacity(p: &CultureChangeProfile) -> f64 {
    0.17 * p.leadership_credibility
        + 0.15 * p.narrative_coherence
        + 0.15 * p.reinforcement_alignment
        + 0.14 * p.adaptive_learning
        + 0.13 * p.psychological_safety
        + 0.11 * p.identity_adaptability
        - 0.12 * p.resistance_intensity
        - 0.10 * p.subcultural_fragmentation
        - 0.11 * p.legacy_lock_in
        - 4.00 * p.leadership_turnover
}

fn main() {
    let profile = CultureChangeProfile {
        leadership_credibility: 84.0,
        narrative_coherence: 82.0,
        reinforcement_alignment: 81.0,
        adaptive_learning: 80.0,
        psychological_safety: 83.0,
        identity_adaptability: 76.0,
        resistance_intensity: 22.0,
        subcultural_fragmentation: 26.0,
        legacy_lock_in: 29.0,
        leadership_turnover: 0.0,
    };

    println!(
        "Synthetic culture change capacity score: {:.2}",
        culture_change_capacity(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

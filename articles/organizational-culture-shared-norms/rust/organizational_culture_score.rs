// Organizational Culture and Shared Norms
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, cultural-loyalty scoring,
// cultural-fit scoring, productivity ranking, or individual worker decisions.

struct CultureProfile {
    value_alignment: f64,
    normative_consistency: f64,
    leadership_credibility: f64,
    psychological_safety: f64,
    shared_meaning: f64,
    contradiction: f64,
    fragmentation: f64,
    incentive_distortion: f64,
    external_pressure: f64,
}

fn cultural_coherence_score(p: &CultureProfile) -> f64 {
    0.18 * p.value_alignment
        + 0.16 * p.normative_consistency
        + 0.15 * p.leadership_credibility
        + 0.14 * p.psychological_safety
        + 0.14 * p.shared_meaning
        - 0.10 * p.contradiction
        - 0.08 * p.fragmentation
        - 0.10 * p.incentive_distortion
        - 0.05 * p.external_pressure
}

fn main() {
    let profile = CultureProfile {
        value_alignment: 84.0,
        normative_consistency: 80.0,
        leadership_credibility: 81.0,
        psychological_safety: 84.0,
        shared_meaning: 82.0,
        contradiction: 16.0,
        fragmentation: 22.0,
        incentive_distortion: 20.0,
        external_pressure: 58.0,
    };

    println!(
        "Synthetic cultural coherence score: {:.2}",
        cultural_coherence_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

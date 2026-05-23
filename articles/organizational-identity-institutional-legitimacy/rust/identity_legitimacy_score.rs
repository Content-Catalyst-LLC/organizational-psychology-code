// Organizational Identity and Institutional Legitimacy
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, cultural-loyalty scoring,
// worker legitimacy scoring, productivity ranking, or individual worker decisions.

struct IdentityLegitimacyProfile {
    mission_clarity: f64,
    value_practice_alignment: f64,
    narrative_continuity: f64,
    leadership_credibility: f64,
    behavioral_consistency: f64,
    internal_fragmentation: f64,
    identity_contradiction: f64,
    legitimacy_pressure: f64,
}

fn identity_coherence_score(p: &IdentityLegitimacyProfile) -> f64 {
    0.18 * p.mission_clarity
        + 0.17 * p.value_practice_alignment
        + 0.15 * p.narrative_continuity
        + 0.14 * p.leadership_credibility
        + 0.14 * p.behavioral_consistency
        - 0.10 * p.internal_fragmentation
        - 0.07 * p.identity_contradiction
        - 0.05 * p.legitimacy_pressure
}

fn main() {
    let profile = IdentityLegitimacyProfile {
        mission_clarity: 86.0,
        value_practice_alignment: 82.0,
        narrative_continuity: 79.0,
        leadership_credibility: 81.0,
        behavioral_consistency: 80.0,
        internal_fragmentation: 20.0,
        identity_contradiction: 16.0,
        legitimacy_pressure: 60.0,
    };

    println!(
        "Synthetic identity coherence score: {:.2}",
        identity_coherence_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

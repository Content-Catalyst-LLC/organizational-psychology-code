// Authority and Power in Institutional Leadership
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// loyalty scoring, political-influence scoring, dissent tracking, or individual
// decisions.

struct AuthorityGovernanceProfile {
    formal_legitimacy: f64,
    procedural_fairness: f64,
    informational_access: f64,
    practical_influence: f64,
    ethical_credibility: f64,
    accountability_quality: f64,
    voice_access: f64,
    oversight_strength: f64,
    arbitrariness_risk: f64,
    governance_fragmentation: f64,
    distrust_pressure: f64,
    informal_power_concentration: f64,
}

fn authority_effectiveness_score(p: &AuthorityGovernanceProfile) -> f64 {
    0.12 * p.formal_legitimacy
        + 0.12 * p.procedural_fairness
        + 0.10 * p.informational_access
        + 0.10 * p.practical_influence
        + 0.12 * p.ethical_credibility
        + 0.11 * p.accountability_quality
        + 0.10 * p.voice_access
        + 0.09 * p.oversight_strength
        - 0.08 * p.arbitrariness_risk
        - 0.07 * p.governance_fragmentation
        - 0.07 * p.distrust_pressure
        - 0.05 * p.informal_power_concentration
}

fn main() {
    let profile = AuthorityGovernanceProfile {
        formal_legitimacy: 84.0,
        procedural_fairness: 82.0,
        informational_access: 79.0,
        practical_influence: 81.0,
        ethical_credibility: 83.0,
        accountability_quality: 82.0,
        voice_access: 80.0,
        oversight_strength: 78.0,
        arbitrariness_risk: 18.0,
        governance_fragmentation: 24.0,
        distrust_pressure: 20.0,
        informal_power_concentration: 22.0,
    };

    println!(
        "Synthetic authority effectiveness score: {:.2}",
        authority_effectiveness_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

// Trust and Cooperation in Workplace Teams
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, trustworthiness scoring,
// cooperation scoring, productivity ranking, or individual decisions.

struct TrustCooperationProfile {
    competence_trust: f64,
    integrity_trust: f64,
    benevolence_trust: f64,
    reciprocity_norms: f64,
    communication_reliability: f64,
    opportunism_risk: f64,
    power_imbalance: f64,
    uncertainty_load: f64,
    leadership_credibility: f64,
    institutional_trust: f64,
}

fn cooperative_capacity_score(p: &TrustCooperationProfile) -> f64 {
    0.13 * p.competence_trust
        + 0.14 * p.integrity_trust
        + 0.12 * p.benevolence_trust
        + 0.13 * p.reciprocity_norms
        + 0.12 * p.communication_reliability
        + 0.11 * p.leadership_credibility
        + 0.11 * p.institutional_trust
        - 0.10 * p.opportunism_risk
        - 0.08 * p.power_imbalance
        - 0.05 * p.uncertainty_load
}

fn main() {
    let profile = TrustCooperationProfile {
        competence_trust: 84.0,
        integrity_trust: 82.0,
        benevolence_trust: 78.0,
        reciprocity_norms: 81.0,
        communication_reliability: 83.0,
        opportunism_risk: 16.0,
        power_imbalance: 20.0,
        uncertainty_load: 52.0,
        leadership_credibility: 84.0,
        institutional_trust: 82.0,
    };

    println!(
        "Synthetic cooperative capacity score: {:.2}",
        cooperative_capacity_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

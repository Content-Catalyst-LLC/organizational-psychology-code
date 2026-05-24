// Job Satisfaction and Organizational Commitment
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, commitment scoring,
// retention-risk scoring, productivity ranking, or individual decisions.

struct WorkAttitudeProfile {
    leadership_support: f64,
    reward_fairness: f64,
    developmental_opportunity: f64,
    workload_balance: f64,
    institutional_trust: f64,
    cultural_alignment: f64,
    role_insecurity: f64,
    exhaustion_pressure: f64,
}

fn job_satisfaction_score(p: &WorkAttitudeProfile) -> f64 {
    0.16 * p.leadership_support
        + 0.15 * p.reward_fairness
        + 0.13 * p.developmental_opportunity
        + 0.14 * p.workload_balance
        + 0.13 * p.institutional_trust
        + 0.10 * p.cultural_alignment
        - 0.09 * p.role_insecurity
        - 0.10 * p.exhaustion_pressure
}

fn main() {
    let profile = WorkAttitudeProfile {
        leadership_support: 84.0,
        reward_fairness: 79.0,
        developmental_opportunity: 82.0,
        workload_balance: 76.0,
        institutional_trust: 83.0,
        cultural_alignment: 81.0,
        role_insecurity: 18.0,
        exhaustion_pressure: 22.0,
    };

    println!(
        "Synthetic job satisfaction score: {:.2}",
        job_satisfaction_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

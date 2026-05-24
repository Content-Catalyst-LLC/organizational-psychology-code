// Employee Motivation in Organizations
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// motivation scoring, loyalty scoring, or individual decisions.

struct MotivationSystemProfile {
    autonomy_support: f64,
    competence_development: f64,
    recognition_quality: f64,
    institutional_trust: f64,
    goal_clarity: f64,
    fairness_perception: f64,
    workload_strain: f64,
    control_pressure: f64,
    relatedness: f64,
    meaningful_work: f64,
    psychological_safety: f64,
    leadership_credibility: f64,
}

fn motivation_quality_score(p: &MotivationSystemProfile) -> f64 {
    0.12 * p.autonomy_support
        + 0.11 * p.competence_development
        + 0.10 * p.recognition_quality
        + 0.12 * p.institutional_trust
        + 0.10 * p.goal_clarity
        + 0.11 * p.fairness_perception
        + 0.10 * p.relatedness
        + 0.11 * p.meaningful_work
        + 0.10 * p.psychological_safety
        + 0.10 * p.leadership_credibility
        - 0.08 * p.workload_strain
        - 0.07 * p.control_pressure
}

fn main() {
    let profile = MotivationSystemProfile {
        autonomy_support: 84.0,
        competence_development: 80.0,
        recognition_quality: 79.0,
        institutional_trust: 82.0,
        goal_clarity: 83.0,
        fairness_perception: 81.0,
        workload_strain: 22.0,
        control_pressure: 18.0,
        relatedness: 82.0,
        meaningful_work: 84.0,
        psychological_safety: 80.0,
        leadership_credibility: 82.0,
    };

    println!(
        "Synthetic motivation quality score: {:.2}",
        motivation_quality_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

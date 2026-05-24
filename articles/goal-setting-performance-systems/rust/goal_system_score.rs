// Goal Setting and Performance Systems
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// goal-compliance scoring, or individual decisions.

struct GoalSystemProfile {
    goal_clarity: f64,
    goal_challenge: f64,
    feedback_quality: f64,
    employee_commitment: f64,
    strategic_alignment: f64,
    overload_pressure: f64,
    metric_distortion: f64,
    incentive_misalignment: f64,
    review_quality: f64,
    proxy_drift: f64,
    goal_feasibility: f64,
}

fn goal_system_effectiveness_score(p: &GoalSystemProfile) -> f64 {
    0.13 * p.goal_clarity
        + 0.10 * p.goal_challenge
        + 0.13 * p.feedback_quality
        + 0.11 * p.employee_commitment
        + 0.13 * p.strategic_alignment
        + 0.11 * p.review_quality
        + 0.11 * p.goal_feasibility
        - 0.07 * p.overload_pressure
        - 0.06 * p.metric_distortion
        - 0.05 * p.incentive_misalignment
        - 0.04 * p.proxy_drift
}

fn main() {
    let profile = GoalSystemProfile {
        goal_clarity: 84.0,
        goal_challenge: 78.0,
        feedback_quality: 82.0,
        employee_commitment: 79.0,
        strategic_alignment: 83.0,
        overload_pressure: 22.0,
        metric_distortion: 18.0,
        incentive_misalignment: 16.0,
        review_quality: 82.0,
        proxy_drift: 15.0,
        goal_feasibility: 80.0,
    };

    println!(
        "Synthetic goal-system effectiveness score: {:.2}",
        goal_system_effectiveness_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

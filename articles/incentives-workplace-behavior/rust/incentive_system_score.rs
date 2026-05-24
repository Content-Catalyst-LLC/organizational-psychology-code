// Incentives and Workplace Behavior
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, productivity ranking,
// incentive-compliance scoring, or individual decisions.

struct IncentiveSystemProfile {
    expectancy_strength: f64,
    fairness_perception: f64,
    strategic_alignment: f64,
    intrinsic_support: f64,
    feedback_clarity: f64,
    distortion_risk: f64,
    overload_pressure: f64,
    ethical_risk: f64,
    cooperation_support: f64,
    recognition_legitimacy: f64,
    reward_transparency: f64,
    hidden_labor_recognition: f64,
}

fn incentive_effectiveness_score(p: &IncentiveSystemProfile) -> f64 {
    0.12 * p.expectancy_strength
        + 0.13 * p.fairness_perception
        + 0.12 * p.strategic_alignment
        + 0.10 * p.intrinsic_support
        + 0.11 * p.feedback_clarity
        + 0.10 * p.cooperation_support
        + 0.10 * p.recognition_legitimacy
        + 0.09 * p.reward_transparency
        + 0.08 * p.hidden_labor_recognition
        - 0.08 * p.distortion_risk
        - 0.07 * p.overload_pressure
        - 0.08 * p.ethical_risk
}

fn main() {
    let profile = IncentiveSystemProfile {
        expectancy_strength: 83.0,
        fairness_perception: 81.0,
        strategic_alignment: 82.0,
        intrinsic_support: 79.0,
        feedback_clarity: 80.0,
        distortion_risk: 18.0,
        overload_pressure: 24.0,
        ethical_risk: 16.0,
        cooperation_support: 82.0,
        recognition_legitimacy: 80.0,
        reward_transparency: 81.0,
        hidden_labor_recognition: 78.0,
    };

    println!(
        "Synthetic incentive effectiveness score: {:.2}",
        incentive_effectiveness_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

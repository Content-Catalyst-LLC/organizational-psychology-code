// Psychological Safety in High-Performing Teams
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, courage scoring,
// voice scoring, productivity ranking, or individual worker decisions.

struct PsychologicalSafetyProfile {
    leadership_openness: f64,
    inclusion_quality: f64,
    learning_review_quality: f64,
    knowledge_sharing: f64,
    blame_intensity: f64,
    status_asymmetry: f64,
    perceived_penalty: f64,
    workload_pressure: f64,
}

fn psychological_safety_score(p: &PsychologicalSafetyProfile) -> f64 {
    0.18 * p.leadership_openness
        + 0.16 * p.inclusion_quality
        + 0.15 * p.learning_review_quality
        + 0.14 * p.knowledge_sharing
        - 0.13 * p.blame_intensity
        - 0.11 * p.status_asymmetry
        - 0.10 * p.perceived_penalty
        - 0.06 * p.workload_pressure
}

fn main() {
    let profile = PsychologicalSafetyProfile {
        leadership_openness: 84.0,
        inclusion_quality: 82.0,
        learning_review_quality: 80.0,
        knowledge_sharing: 81.0,
        blame_intensity: 16.0,
        status_asymmetry: 20.0,
        perceived_penalty: 18.0,
        workload_pressure: 52.0,
    };

    println!(
        "Synthetic psychological safety score: {:.2}",
        psychological_safety_score(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

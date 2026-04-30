fn commitment_score(motivation: f64, trust: f64, fairness: f64, role_clarity: f64, burnout: f64) -> f64 {
    0.25 * motivation + 0.25 * trust + 0.20 * fairness + 0.15 * role_clarity - 0.20 * burnout
}

fn main() {
    let score = commitment_score(0.75, 0.70, 0.65, 0.80, 0.25);
    println!("Commitment score: {:.3}", score);
}

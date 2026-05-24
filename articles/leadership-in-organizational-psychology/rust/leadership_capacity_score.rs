fn leadership_capacity_score(values: [f64; 14]) -> f64 {
    let weights = [0.11,0.11,0.10,0.11,0.10,0.10,0.08,0.09,0.08,0.08,-0.07,-0.08,-0.07,-0.06];
    values.iter().zip(weights.iter()).map(|(v,w)| v*w).sum()
}

fn main() {
    let score = leadership_capacity_score([83.0,81.0,79.0,82.0,80.0,81.0,80.0,82.0,81.0,80.0,20.0,18.0,22.0,24.0]);
    println!("Synthetic leadership capacity score: {:.2}", score);
    println!("Responsible-use reminder: institutional learning only.");
}

// Information Flow and Organizational Communication
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, institutional learning,
// and reproducible workflows only. Not for employment, communication surveillance,
// productivity ranking, or individual worker decisions.

struct InformationFlowProfile {
    signal_quality: f64,
    timeliness: f64,
    interpretive_clarity: f64,
    cross_functional_connectivity: f64,
    psychological_safety: f64,
    distortion_risk: f64,
    overload_pressure: f64,
    hierarchy_delay: f64,
    external_signal_turbulence: f64,
}

fn information_flow_quality(p: &InformationFlowProfile) -> f64 {
    0.18 * p.signal_quality
        + 0.15 * p.timeliness
        + 0.15 * p.interpretive_clarity
        + 0.14 * p.cross_functional_connectivity
        + 0.13 * p.psychological_safety
        - 0.10 * p.distortion_risk
        - 0.08 * p.overload_pressure
        - 0.10 * p.hierarchy_delay
        - 0.05 * p.external_signal_turbulence
}

fn main() {
    let profile = InformationFlowProfile {
        signal_quality: 84.0,
        timeliness: 82.0,
        interpretive_clarity: 80.0,
        cross_functional_connectivity: 79.0,
        psychological_safety: 83.0,
        distortion_risk: 14.0,
        overload_pressure: 32.0,
        hierarchy_delay: 18.0,
        external_signal_turbulence: 58.0,
    };

    println!(
        "Synthetic information flow quality score: {:.2}",
        information_flow_quality(&profile)
    );
    println!("Responsible-use reminder: institutional learning only.");
}

// The Evolution of Organizational Psychology
// Simple Rust scoring demonstration.
//
// Responsible-use scope:
// Synthetic-data research, methods demonstration, organizational psychology
// education, and history-of-field analysis only. Not for employee, scholar,
// department, journal, or institution ranking.

struct FieldEmphasis {
    selection_testing: f64,
    efficiency_work_design: f64,
    motivation_attitudes: f64,
    groups_teams: f64,
    culture_leadership_change: f64,
    wellbeing_stress: f64,
    justice_validity_ethics: f64,
    digital_analytics: f64,
    systems_institutional_accountability: f64,
}

fn responsible_progress_score(f: &FieldEmphasis) -> f64 {
    0.18 * f.selection_testing
        + 0.08 * f.efficiency_work_design
        + 0.12 * f.motivation_attitudes
        + 0.12 * f.groups_teams
        + 0.14 * f.culture_leadership_change
        + 0.15 * f.wellbeing_stress
        + 0.17 * f.justice_validity_ethics
        + 0.08 * f.digital_analytics
        + 0.06 * f.systems_institutional_accountability
}

fn main() {
    let broad = FieldEmphasis {
        selection_testing: 72.0,
        efficiency_work_design: 66.0,
        motivation_attitudes: 84.0,
        groups_teams: 86.0,
        culture_leadership_change: 88.0,
        wellbeing_stress: 86.0,
        justice_validity_ethics: 92.0,
        digital_analytics: 84.0,
        systems_institutional_accountability: 90.0,
    };

    println!(
        "Synthetic responsible progress score: {:.2}",
        responsible_progress_score(&broad)
    );
    println!("Responsible-use reminder: educational field-evolution demo only.");
}

"""
Python Workflow: Simulating Field Evolution Across Research Emphases

Responsible-use scope:
This workflow is for synthetic-data research, methods demonstration,
institutional learning, organizational psychology education, and history-of-field
analysis. It is not a tool for ranking scholars, departments, journals, workers,
employees, or institutions.
"""

from __future__ import annotations

from pathlib import Path

import pandas as pd
from sklearn.cluster import KMeans
from sklearn.decomposition import PCA
from sklearn.preprocessing import MinMaxScaler


ROOT = Path(__file__).resolve().parents[1]
RAW_DATA = ROOT / "data" / "raw" / "organizational_psychology_evolution_synthetic.csv"
TABLE_DIR = ROOT / "outputs" / "tables"
FIGURE_DIR = ROOT / "outputs" / "figures"

TABLE_DIR.mkdir(parents=True, exist_ok=True)
FIGURE_DIR.mkdir(parents=True, exist_ok=True)

FEATURES = [
    "selection_testing",
    "efficiency_work_design",
    "motivation_attitudes",
    "groups_teams",
    "culture_leadership_change",
    "wellbeing_stress",
    "justice_validity_ethics",
    "digital_analytics",
    "systems_institutional_accountability",
]


def load_data() -> pd.DataFrame:
    """Load synthetic field-evolution data."""
    return pd.read_csv(RAW_DATA)


def add_orientation_indices(history: pd.DataFrame) -> pd.DataFrame:
    """Add transparent synthetic field-orientation indices."""
    df = history.copy()

    df["industrial_orientation"] = (
        0.46 * df["selection_testing"]
        + 0.40 * df["efficiency_work_design"]
        + 0.14 * df["motivation_attitudes"]
    )

    df["organizational_orientation"] = (
        0.16 * df["motivation_attitudes"]
        + 0.16 * df["groups_teams"]
        + 0.20 * df["culture_leadership_change"]
        + 0.14 * df["wellbeing_stress"]
        + 0.14 * df["justice_validity_ethics"]
        + 0.10 * df["digital_analytics"]
        + 0.10 * df["systems_institutional_accountability"]
    )

    df["systems_ethics_orientation"] = (
        0.16 * df["groups_teams"]
        + 0.20 * df["culture_leadership_change"]
        + 0.18 * df["wellbeing_stress"]
        + 0.20 * df["justice_validity_ethics"]
        + 0.12 * df["digital_analytics"]
        + 0.14 * df["systems_institutional_accountability"]
    )

    df["field_expansion_index"] = (
        df["organizational_orientation"] - df["industrial_orientation"]
    )

    df["responsible_progress_index"] = (
        0.18 * df["selection_testing"]
        + 0.08 * df["efficiency_work_design"]
        + 0.12 * df["motivation_attitudes"]
        + 0.12 * df["groups_teams"]
        + 0.14 * df["culture_leadership_change"]
        + 0.15 * df["wellbeing_stress"]
        + 0.17 * df["justice_validity_ethics"]
        + 0.08 * df["digital_analytics"]
        + 0.06 * df["systems_institutional_accountability"]
    )

    return df


def add_synthetic_phase_clusters(df: pd.DataFrame) -> pd.DataFrame:
    """Add PCA and K-means labels for a conceptual phase map."""
    scaled = MinMaxScaler().fit_transform(df[FEATURES])

    pca = PCA(n_components=2)
    components = pca.fit_transform(scaled)

    clustered = df.copy()
    clustered["pc1_field_breadth"] = components[:, 0]
    clustered["pc2_measurement_to_systems"] = components[:, 1]

    kmeans = KMeans(n_clusters=3, random_state=42, n_init=10)
    clustered["synthetic_phase_cluster"] = kmeans.fit_predict(scaled)

    # Assign labels by dominant period pattern for interpretive readability.
    label_map = {}
    sorted_clusters = (
        clustered.groupby("synthetic_phase_cluster")["organizational_orientation"]
        .mean()
        .sort_values()
        .index
        .tolist()
    )
    readable_labels = [
        "Measurement and efficiency phase",
        "Organizational systems expansion phase",
        "Digital, justice, well-being, and accountability phase",
    ]
    for cluster_id, label in zip(sorted_clusters, readable_labels):
        label_map[cluster_id] = label

    clustered["interpreted_phase"] = clustered["synthetic_phase_cluster"].map(label_map)
    return clustered


def build_scenarios() -> pd.DataFrame:
    """Compare two synthetic field-use scenarios."""
    scenario = pd.DataFrame(
        [
            {
                "scenario": "Narrow administrative use of psychology",
                "selection_testing": 86,
                "efficiency_work_design": 84,
                "motivation_attitudes": 28,
                "groups_teams": 24,
                "culture_leadership_change": 18,
                "wellbeing_stress": 18,
                "justice_validity_ethics": 26,
                "digital_analytics": 10,
                "systems_institutional_accountability": 16,
            },
            {
                "scenario": "Broad responsible organizational psychology",
                "selection_testing": 72,
                "efficiency_work_design": 66,
                "motivation_attitudes": 84,
                "groups_teams": 86,
                "culture_leadership_change": 88,
                "wellbeing_stress": 86,
                "justice_validity_ethics": 92,
                "digital_analytics": 84,
                "systems_institutional_accountability": 90,
            },
        ]
    )

    scenario = add_orientation_indices(scenario)
    return scenario[
        [
            "scenario",
            "industrial_orientation",
            "organizational_orientation",
            "systems_ethics_orientation",
            "field_expansion_index",
            "responsible_progress_index",
        ]
    ]


def main() -> None:
    history = load_data()
    indexed = add_orientation_indices(history)
    indexed = add_synthetic_phase_clusters(indexed)

    indexed.to_csv(TABLE_DIR / "field_evolution_indices.csv", index=False)

    scenarios = build_scenarios()
    scenarios.to_csv(TABLE_DIR / "field_evolution_scenario_comparison.csv", index=False)

    long_history = indexed.melt(
        id_vars=[
            "period",
            "industrial_orientation",
            "organizational_orientation",
            "systems_ethics_orientation",
            "field_expansion_index",
            "responsible_progress_index",
            "interpreted_phase",
        ],
        value_vars=FEATURES,
        var_name="research_emphasis",
        value_name="synthetic_emphasis_score",
    )
    long_history.to_csv(TABLE_DIR / "field_evolution_long_format.csv", index=False)

    with open(TABLE_DIR / "interpretation_note.txt", "w", encoding="utf-8") as handle:
        handle.write("Synthetic organizational psychology field-evolution workflow\n")
        handle.write("===========================================================\n\n")
        handle.write(
            "These outputs are conceptual teaching artifacts. They are not bibliometric "
            "findings, historical measurements, publication counts, citation records, "
            "or rankings of scholars, departments, journals, workers, employees, or institutions.\n"
        )

    print(indexed)
    print(scenarios)
    print("Wrote outputs to:", TABLE_DIR)


if __name__ == "__main__":
    main()

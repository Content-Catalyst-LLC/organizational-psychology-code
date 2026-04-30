"""Synthetic organizational psychology simulation.

This script creates toy employee-survey and communication-network data.
It is educational only and not a hiring, surveillance, diagnostic, or HR assessment tool.
"""

from pathlib import Path
import csv
import random

random.seed(42)

n_employees = 180
n_waves = 8
teams = [f"T{i:02d}" for i in range(1, 13)]

employees = []
observations = []
edges = []
observation_id = 1
edge_id = 1

for i in range(1, n_employees + 1):
    employee_id = f"E{i:03d}"
    team_id = random.choice(teams)
    department_id = f"D{random.randint(1, 4):02d}"
    role_level = random.choice(["individual_contributor", "manager", "senior_manager"])
    tenure_months = random.randint(3, 120)

    employees.append({
        "employee_id": employee_id,
        "team_id": team_id,
        "department_id": department_id,
        "role_level": role_level,
        "tenure_months": tenure_months,
    })

    motivation = random.uniform(0.30, 0.90)
    role_clarity = random.uniform(0.25, 0.90)
    leadership_trust = random.uniform(0.20, 0.95)
    psychological_safety = random.uniform(0.20, 0.95)
    fairness = random.uniform(0.20, 0.90)
    workload = random.uniform(0.10, 0.85)

    for wave in range(1, n_waves + 1):
        burnout_risk = max(0.0, min(1.0, 0.45 * workload - 0.18 * fairness - 0.15 * psychological_safety + random.gauss(0, 0.05)))
        commitment = max(0.0, min(1.0, 0.25 * motivation + 0.20 * leadership_trust + 0.20 * fairness + 0.15 * role_clarity - 0.18 * burnout_risk + random.gauss(0, 0.04)))
        job_satisfaction = max(0.0, min(1.0, 0.22 * motivation + 0.22 * fairness + 0.18 * psychological_safety + 0.15 * role_clarity - 0.20 * workload + random.gauss(0, 0.04)))

        observations.append({
            "observation_id": observation_id,
            "employee_id": employee_id,
            "team_id": team_id,
            "wave": wave,
            "motivation": round(motivation, 3),
            "role_clarity": round(role_clarity, 3),
            "leadership_trust": round(leadership_trust, 3),
            "psychological_safety": round(psychological_safety, 3),
            "perceived_fairness": round(fairness, 3),
            "workload_pressure": round(workload, 3),
            "burnout_risk": round(burnout_risk, 3),
            "commitment": round(commitment, 3),
            "job_satisfaction": round(job_satisfaction, 3),
        })
        observation_id += 1

        # Simple dynamic updates.
        motivation = max(0.0, min(1.0, motivation + 0.015 * job_satisfaction - 0.010 * burnout_risk + random.gauss(0, 0.02)))
        leadership_trust = max(0.0, min(1.0, leadership_trust + 0.012 * fairness - 0.010 * workload + random.gauss(0, 0.02)))
        psychological_safety = max(0.0, min(1.0, psychological_safety + 0.010 * leadership_trust - 0.008 * burnout_risk + random.gauss(0, 0.02)))
        workload = max(0.0, min(1.0, workload + random.gauss(0, 0.025)))

# Synthetic communication network.
employee_ids = [e["employee_id"] for e in employees]
for week in range(1, 9):
    for source in employee_ids:
        contacts = random.sample(employee_ids, k=5)
        for target in contacts:
            if target == source:
                continue
            edges.append({
                "edge_id": edge_id,
                "source_employee_id": source,
                "target_employee_id": target,
                "interaction_weight": round(random.uniform(0.1, 1.0), 3),
                "channel": random.choice(["chat", "email", "meeting", "document"]),
                "week_index": week,
            })
            edge_id += 1

processed = Path(__file__).resolve().parents[1] / "data" / "processed"
processed.mkdir(parents=True, exist_ok=True)

employees_path = processed / "synthetic_employees.csv"
observations_path = processed / "synthetic_organizational_observations.csv"
edges_path = processed / "synthetic_communication_edges.csv"

for path, rows in [
    (employees_path, employees),
    (observations_path, observations),
    (edges_path, edges),
]:
    with path.open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=rows[0].keys())
        writer.writeheader()
        writer.writerows(rows)

print(f"Wrote {len(employees)} employees to {employees_path}")
print(f"Wrote {len(observations)} observations to {observations_path}")
print(f"Wrote {len(edges)} communication edges to {edges_path}")

! Organizations as Complex Behavioral Systems
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! loyalty scoring, dissent tracking, or individual decisions.

program complex_system_score_program
  implicit none
  real :: psychological_safety, leadership_trust, cultural_coherence
  real :: incentive_alignment, information_flow, learning_capacity
  real :: redundancy_slack, workload_pressure, silence_risk
  real :: fragmentation_pressure, environmental_uncertainty, risk

  psychological_safety = 84.0
  leadership_trust = 85.0
  cultural_coherence = 82.0
  incentive_alignment = 80.0
  information_flow = 83.0
  learning_capacity = 82.0
  redundancy_slack = 68.0
  workload_pressure = 30.0
  silence_risk = 18.0
  fragmentation_pressure = 22.0
  environmental_uncertainty = 42.0

  risk = 0.11 * (100.0 - psychological_safety) + &
         0.11 * (100.0 - leadership_trust) + &
         0.09 * (100.0 - cultural_coherence) + &
         0.09 * (100.0 - incentive_alignment) + &
         0.09 * (100.0 - information_flow) + &
         0.10 * (100.0 - learning_capacity) + &
         0.08 * (100.0 - redundancy_slack) + &
         0.09 * workload_pressure + &
         0.08 * silence_risk + &
         0.10 * fragmentation_pressure + &
         0.08 * environmental_uncertainty

  print *, "Synthetic complex system risk score:", risk
  print *, "Responsible-use reminder: institutional learning only."
end program complex_system_score_program

! Goal Setting and Performance Systems
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! goal-compliance scoring, or individual decisions.

program goal_system_score_program
  implicit none
  real :: goal_clarity, goal_challenge, feedback_quality, employee_commitment
  real :: strategic_alignment, overload_pressure, metric_distortion
  real :: incentive_misalignment, review_quality, proxy_drift
  real :: goal_feasibility, score

  goal_clarity = 84.0
  goal_challenge = 78.0
  feedback_quality = 82.0
  employee_commitment = 79.0
  strategic_alignment = 83.0
  overload_pressure = 22.0
  metric_distortion = 18.0
  incentive_misalignment = 16.0
  review_quality = 82.0
  proxy_drift = 15.0
  goal_feasibility = 80.0

  score = 0.13 * goal_clarity + 0.10 * goal_challenge + &
          0.13 * feedback_quality + 0.11 * employee_commitment + &
          0.13 * strategic_alignment + 0.11 * review_quality + &
          0.11 * goal_feasibility - 0.07 * overload_pressure - &
          0.06 * metric_distortion - 0.05 * incentive_misalignment - &
          0.04 * proxy_drift

  print *, "Synthetic goal-system effectiveness score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program goal_system_score_program

! Institutional Values and Behavioral Expectations
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, cultural-loyalty scoring,
! morality scoring, productivity ranking, or individual worker decisions.

program institutional_values_score
  implicit none
  real :: value_clarity, leadership_consistency, reinforcement_alignment
  real :: psychological_safety, accountability_strength, decoupling_risk
  real :: incentive_contradiction, hierarchy_exemption, legitimacy_pressure
  real :: score

  value_clarity = 86.0
  leadership_consistency = 83.0
  reinforcement_alignment = 81.0
  psychological_safety = 82.0
  accountability_strength = 80.0
  decoupling_risk = 16.0
  incentive_contradiction = 20.0
  hierarchy_exemption = 12.0
  legitimacy_pressure = 58.0

  score = 0.17 * value_clarity + 0.16 * leadership_consistency + &
          0.16 * reinforcement_alignment + 0.14 * psychological_safety + &
          0.14 * accountability_strength - 0.10 * decoupling_risk - &
          0.09 * incentive_contradiction - 0.09 * hierarchy_exemption - &
          0.05 * legitimacy_pressure

  print *, "Synthetic value-practice alignment score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program institutional_values_score

! Learning Organizations and Knowledge Systems
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment or individual worker decisions.

program learning_score
  implicit none
  real :: information_quality, interpretive_openness, memory_retention
  real :: communication_flow, psychological_safety, governance_support
  real :: complexity_load, silo_intensity, incentive_distortion, turnover_pressure
  real :: score

  information_quality = 84.0
  interpretive_openness = 82.0
  memory_retention = 83.0
  communication_flow = 86.0
  psychological_safety = 84.0
  governance_support = 78.0
  complexity_load = 48.0
  silo_intensity = 20.0
  incentive_distortion = 17.0
  turnover_pressure = 19.0

  score = 0.17 * information_quality + 0.18 * interpretive_openness + &
          0.15 * memory_retention + 0.15 * communication_flow + &
          0.13 * psychological_safety + 0.10 * governance_support - &
          0.07 * complexity_load - 0.10 * silo_intensity - &
          0.10 * incentive_distortion - 0.05 * turnover_pressure

  print *, "Synthetic institutional learning capacity score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program learning_score

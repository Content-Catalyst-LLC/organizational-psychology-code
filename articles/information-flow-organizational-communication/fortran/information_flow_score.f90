! Information Flow and Organizational Communication
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, communication surveillance,
! productivity ranking, or individual worker decisions.

program information_flow_score
  implicit none
  real :: signal_quality, timeliness, interpretive_clarity
  real :: cross_functional_connectivity, psychological_safety, distortion_risk
  real :: overload_pressure, hierarchy_delay, external_signal_turbulence
  real :: score

  signal_quality = 84.0
  timeliness = 82.0
  interpretive_clarity = 80.0
  cross_functional_connectivity = 79.0
  psychological_safety = 83.0
  distortion_risk = 14.0
  overload_pressure = 32.0
  hierarchy_delay = 18.0
  external_signal_turbulence = 58.0

  score = 0.18 * signal_quality + 0.15 * timeliness + &
          0.15 * interpretive_clarity + 0.14 * cross_functional_connectivity + &
          0.13 * psychological_safety - 0.10 * distortion_risk - &
          0.08 * overload_pressure - 0.10 * hierarchy_delay - &
          0.05 * external_signal_turbulence

  print *, "Synthetic information flow quality score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program information_flow_score

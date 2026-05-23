! Organizational Resilience in Complex Systems
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment or individual worker decisions.

program resilience_score
  implicit none
  real :: robustness, redundancy, adaptive_learning
  real :: coordination_integrity, governance_responsiveness
  real :: psychological_safety, external_exposure
  real :: complexity_load, accumulated_fragility
  real :: score

  robustness = 78.0
  redundancy = 72.0
  adaptive_learning = 81.0
  coordination_integrity = 79.0
  governance_responsiveness = 74.0
  psychological_safety = 83.0
  external_exposure = 42.0
  complexity_load = 51.0
  accumulated_fragility = 22.0

  score = 0.18 * robustness + 0.12 * redundancy + 0.16 * adaptive_learning + &
          0.14 * coordination_integrity + 0.12 * governance_responsiveness + &
          0.13 * psychological_safety - 0.08 * external_exposure - &
          0.07 * complexity_load - 0.10 * accumulated_fragility

  print *, "Synthetic institutional resilience capacity score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program resilience_score

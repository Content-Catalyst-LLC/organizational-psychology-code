! Organizational Culture and Shared Norms
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, cultural-loyalty scoring,
! cultural-fit scoring, productivity ranking, or individual worker decisions.

program organizational_culture_score
  implicit none
  real :: value_alignment, normative_consistency, leadership_credibility
  real :: psychological_safety, shared_meaning, contradiction
  real :: fragmentation, incentive_distortion, external_pressure
  real :: score

  value_alignment = 84.0
  normative_consistency = 80.0
  leadership_credibility = 81.0
  psychological_safety = 84.0
  shared_meaning = 82.0
  contradiction = 16.0
  fragmentation = 22.0
  incentive_distortion = 20.0
  external_pressure = 58.0

  score = 0.18 * value_alignment + 0.16 * normative_consistency + &
          0.15 * leadership_credibility + 0.14 * psychological_safety + &
          0.14 * shared_meaning - 0.10 * contradiction - &
          0.08 * fragmentation - 0.10 * incentive_distortion - &
          0.05 * external_pressure

  print *, "Synthetic cultural coherence score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program organizational_culture_score

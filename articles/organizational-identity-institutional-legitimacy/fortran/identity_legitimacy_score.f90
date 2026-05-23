! Organizational Identity and Institutional Legitimacy
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, cultural-loyalty scoring,
! worker legitimacy scoring, productivity ranking, or individual worker decisions.

program identity_legitimacy_score
  implicit none
  real :: mission_clarity, value_practice_alignment, narrative_continuity
  real :: leadership_credibility, behavioral_consistency, internal_fragmentation
  real :: identity_contradiction, legitimacy_pressure, score

  mission_clarity = 86.0
  value_practice_alignment = 82.0
  narrative_continuity = 79.0
  leadership_credibility = 81.0
  behavioral_consistency = 80.0
  internal_fragmentation = 20.0
  identity_contradiction = 16.0
  legitimacy_pressure = 60.0

  score = 0.18 * mission_clarity + 0.17 * value_practice_alignment + &
          0.15 * narrative_continuity + 0.14 * leadership_credibility + &
          0.14 * behavioral_consistency - 0.10 * internal_fragmentation - &
          0.07 * identity_contradiction - 0.05 * legitimacy_pressure

  print *, "Synthetic identity coherence score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program identity_legitimacy_score

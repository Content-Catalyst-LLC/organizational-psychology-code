! Culture Change in Organizations
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, cultural-loyalty scoring,
! productivity ranking, or individual worker decisions.

program culture_change_score
  implicit none
  real :: leadership_credibility, narrative_coherence, reinforcement_alignment
  real :: adaptive_learning, psychological_safety, identity_adaptability
  real :: resistance_intensity, subcultural_fragmentation, legacy_lock_in
  real :: leadership_turnover, score

  leadership_credibility = 84.0
  narrative_coherence = 82.0
  reinforcement_alignment = 81.0
  adaptive_learning = 80.0
  psychological_safety = 83.0
  identity_adaptability = 76.0
  resistance_intensity = 22.0
  subcultural_fragmentation = 26.0
  legacy_lock_in = 29.0
  leadership_turnover = 0.0

  score = 0.17 * leadership_credibility + 0.15 * narrative_coherence + &
          0.15 * reinforcement_alignment + 0.14 * adaptive_learning + &
          0.13 * psychological_safety + 0.11 * identity_adaptability - &
          0.12 * resistance_intensity - 0.10 * subcultural_fragmentation - &
          0.11 * legacy_lock_in - 4.00 * leadership_turnover

  print *, "Synthetic culture change capacity score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program culture_change_score

! Cognitive Bias in Institutional Decisions
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, executive ranking,
! productivity ranking, or individual worker decisions.

program bias_pressure_score_program
  implicit none
  real :: signal_quality, viewpoint_diversity, analytical_discipline
  real :: structured_challenge, hierarchy_suppression, time_pressure
  real :: routine_reinforcement, learning_review, group_conformity
  real :: score

  signal_quality = 84.0
  viewpoint_diversity = 80.0
  analytical_discipline = 82.0
  structured_challenge = 81.0
  hierarchy_suppression = 14.0
  time_pressure = 38.0
  routine_reinforcement = 36.0
  learning_review = 79.0
  group_conformity = 28.0

  score = 0.16 * hierarchy_suppression + 0.15 * time_pressure + &
          0.14 * routine_reinforcement + 0.13 * group_conformity - &
          0.16 * viewpoint_diversity - 0.13 * analytical_discipline - &
          0.14 * structured_challenge - 0.12 * learning_review - &
          0.10 * signal_quality

  print *, "Synthetic bias pressure score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program bias_pressure_score_program

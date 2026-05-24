! Team Dynamics in Organizations
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, team-fit scoring,
! collaboration scoring, productivity ranking, or individual decisions.

program team_dynamics_score_program
  implicit none
  real :: communication_quality, trust_level, role_clarity
  real :: psychological_safety, leadership_support, conflict_load
  real :: task_ambiguity, coordination_cost, participation_equity
  real :: learning_routine_quality, score

  communication_quality = 84.0
  trust_level = 82.0
  role_clarity = 79.0
  psychological_safety = 83.0
  leadership_support = 80.0
  conflict_load = 22.0
  task_ambiguity = 30.0
  coordination_cost = 34.0
  participation_equity = 82.0
  learning_routine_quality = 80.0

  score = 0.14 * communication_quality + 0.12 * trust_level + &
          0.12 * role_clarity + 0.13 * psychological_safety + &
          0.12 * leadership_support + 0.11 * participation_equity + &
          0.11 * learning_routine_quality - 0.09 * conflict_load - &
          0.08 * task_ambiguity - 0.09 * coordination_cost

  print *, "Synthetic team effectiveness score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program team_dynamics_score_program

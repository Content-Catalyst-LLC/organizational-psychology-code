! Employee Motivation in Organizations
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! motivation scoring, loyalty scoring, or individual decisions.

program motivation_system_score_program
  implicit none
  real :: autonomy_support, competence_development, recognition_quality
  real :: institutional_trust, goal_clarity, fairness_perception
  real :: workload_strain, control_pressure, relatedness
  real :: meaningful_work, psychological_safety, leadership_credibility
  real :: score

  autonomy_support = 84.0
  competence_development = 80.0
  recognition_quality = 79.0
  institutional_trust = 82.0
  goal_clarity = 83.0
  fairness_perception = 81.0
  workload_strain = 22.0
  control_pressure = 18.0
  relatedness = 82.0
  meaningful_work = 84.0
  psychological_safety = 80.0
  leadership_credibility = 82.0

  score = 0.12 * autonomy_support + 0.11 * competence_development + &
          0.10 * recognition_quality + 0.12 * institutional_trust + &
          0.10 * goal_clarity + 0.11 * fairness_perception + &
          0.10 * relatedness + 0.11 * meaningful_work + &
          0.10 * psychological_safety + 0.10 * leadership_credibility - &
          0.08 * workload_strain - 0.07 * control_pressure

  print *, "Synthetic motivation quality score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program motivation_system_score_program

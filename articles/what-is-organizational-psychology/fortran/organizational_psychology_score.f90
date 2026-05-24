! What Is Organizational Psychology?
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! loyalty scoring, dissent tracking, or individual decisions.

program organizational_psychology_score_program
  implicit none
  real :: capability, motivation, role_clarity, autonomy, fairness
  real :: team_coordination, leadership_trust, psychological_safety
  real :: communication_quality, culture_strength, workload_pressure
  real :: burnout_pressure, institutional_support, voice_access, score

  capability = 72.0
  motivation = 76.0
  role_clarity = 82.0
  autonomy = 78.0
  fairness = 80.0
  team_coordination = 80.0
  leadership_trust = 84.0
  psychological_safety = 81.0
  communication_quality = 82.0
  culture_strength = 79.0
  workload_pressure = 28.0
  burnout_pressure = 25.0
  institutional_support = 82.0
  voice_access = 80.0

  score = 0.11 * capability + 0.10 * motivation + 0.10 * role_clarity + &
          0.07 * autonomy + 0.08 * fairness + 0.09 * team_coordination + &
          0.10 * leadership_trust + 0.10 * psychological_safety + &
          0.08 * communication_quality + 0.06 * culture_strength + &
          0.08 * institutional_support + 0.06 * voice_access - &
          0.07 * workload_pressure - 0.08 * burnout_pressure

  print *, "Synthetic modeled outcome quality:", score
  print *, "Responsible-use reminder: institutional learning only."
end program organizational_psychology_score_program

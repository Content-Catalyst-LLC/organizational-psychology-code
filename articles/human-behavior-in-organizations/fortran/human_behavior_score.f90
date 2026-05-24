! Human Behavior in Organizations
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! loyalty scoring, dissent tracking, or individual decisions.

program human_behavior_score_program
  implicit none
  real :: capability, motivation, role_clarity, psychological_safety
  real :: leadership_trust, cultural_norm_strength, incentive_alignment
  real :: workload_pressure, burnout_pressure, hierarchical_pressure
  real :: perceived_voice_efficacy, fear_of_retaliation, score, z, voice_probability

  capability = 72.0
  motivation = 78.0
  role_clarity = 82.0
  psychological_safety = 84.0
  leadership_trust = 85.0
  cultural_norm_strength = 82.0
  incentive_alignment = 80.0
  workload_pressure = 30.0
  burnout_pressure = 24.0
  hierarchical_pressure = 22.0
  perceived_voice_efficacy = 80.0
  fear_of_retaliation = 12.0

  score = 0.16 * capability + 0.15 * motivation + 0.14 * role_clarity + &
          0.12 * psychological_safety + 0.12 * leadership_trust + &
          0.10 * cultural_norm_strength + 0.09 * incentive_alignment - &
          0.08 * workload_pressure - 0.08 * burnout_pressure - &
          0.06 * hierarchical_pressure

  z = -2.0 + 0.030 * psychological_safety + 0.024 * leadership_trust + &
      0.022 * perceived_voice_efficacy - 0.026 * fear_of_retaliation - &
      0.020 * hierarchical_pressure

  voice_probability = 1.0 / (1.0 + exp(-z))

  print *, "Synthetic behavior quality:", score
  print *, "Synthetic voice probability:", voice_probability
  print *, "Responsible-use reminder: institutional learning only."
end program human_behavior_score_program

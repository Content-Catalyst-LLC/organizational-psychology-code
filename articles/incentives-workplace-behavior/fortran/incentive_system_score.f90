! Incentives and Workplace Behavior
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! incentive-compliance scoring, or individual decisions.

program incentive_system_score_program
  implicit none
  real :: expectancy_strength, fairness_perception, strategic_alignment
  real :: intrinsic_support, feedback_clarity, distortion_risk
  real :: overload_pressure, ethical_risk, cooperation_support
  real :: recognition_legitimacy, reward_transparency
  real :: hidden_labor_recognition, score

  expectancy_strength = 83.0
  fairness_perception = 81.0
  strategic_alignment = 82.0
  intrinsic_support = 79.0
  feedback_clarity = 80.0
  distortion_risk = 18.0
  overload_pressure = 24.0
  ethical_risk = 16.0
  cooperation_support = 82.0
  recognition_legitimacy = 80.0
  reward_transparency = 81.0
  hidden_labor_recognition = 78.0

  score = 0.12 * expectancy_strength + 0.13 * fairness_perception + &
          0.12 * strategic_alignment + 0.10 * intrinsic_support + &
          0.11 * feedback_clarity + 0.10 * cooperation_support + &
          0.10 * recognition_legitimacy + 0.09 * reward_transparency + &
          0.08 * hidden_labor_recognition - 0.08 * distortion_risk - &
          0.07 * overload_pressure - 0.08 * ethical_risk

  print *, "Synthetic incentive effectiveness score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program incentive_system_score_program

! Leadership Styles and Organizational Performance
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! leadership-loyalty scoring, dissent tracking, or individual decisions.

program leadership_style_score_program
  implicit none
  real :: participative_behavior, structural_guidance, communication_quality
  real :: trust_generation, developmental_support, psychological_safety
  real :: decision_fit, cultural_alignment, control_pressure
  real :: ambiguity_risk, disengagement_pressure, score

  participative_behavior = 82.0
  structural_guidance = 80.0
  communication_quality = 83.0
  trust_generation = 81.0
  developmental_support = 79.0
  psychological_safety = 80.0
  decision_fit = 82.0
  cultural_alignment = 81.0
  control_pressure = 18.0
  ambiguity_risk = 22.0
  disengagement_pressure = 20.0

  score = 0.11 * participative_behavior + 0.12 * structural_guidance + &
          0.13 * communication_quality + 0.13 * trust_generation + &
          0.11 * developmental_support + 0.12 * psychological_safety + &
          0.11 * decision_fit + 0.10 * cultural_alignment - &
          0.08 * control_pressure - 0.07 * ambiguity_risk - &
          0.07 * disengagement_pressure

  print *, "Synthetic leadership effectiveness score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program leadership_style_score_program

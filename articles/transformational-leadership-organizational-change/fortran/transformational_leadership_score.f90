! Transformational Leadership and Organizational Change
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! leadership-loyalty scoring, dissent tracking, or individual decisions.

program transformational_leadership_score_program
  implicit none
  real :: vision_credibility, motivational_alignment, intellectual_stimulation
  real :: developmental_support, institutional_trust, psychological_safety
  real :: change_communication, implementation_support, meaning_making_quality
  real :: resistance_intensity, ambiguity_pressure, change_fatigue
  real :: score

  vision_credibility = 84.0
  motivational_alignment = 81.0
  intellectual_stimulation = 80.0
  developmental_support = 79.0
  institutional_trust = 82.0
  psychological_safety = 80.0
  change_communication = 83.0
  implementation_support = 78.0
  meaning_making_quality = 82.0
  resistance_intensity = 20.0
  ambiguity_pressure = 22.0
  change_fatigue = 24.0

  score = 0.12 * vision_credibility + 0.11 * motivational_alignment + &
          0.11 * intellectual_stimulation + 0.10 * developmental_support + &
          0.12 * institutional_trust + 0.11 * psychological_safety + &
          0.10 * change_communication + 0.09 * implementation_support + &
          0.10 * meaning_making_quality - 0.08 * resistance_intensity - &
          0.07 * ambiguity_pressure - 0.08 * change_fatigue

  print *, "Synthetic transformational capacity score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program transformational_leadership_score_program

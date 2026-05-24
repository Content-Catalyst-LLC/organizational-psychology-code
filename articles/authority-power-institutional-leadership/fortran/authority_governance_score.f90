! Authority and Power in Institutional Leadership
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, productivity ranking,
! loyalty scoring, political-influence scoring, dissent tracking, or individual
! decisions.

program authority_governance_score_program
  implicit none
  real :: formal_legitimacy, procedural_fairness, informational_access
  real :: practical_influence, ethical_credibility, accountability_quality
  real :: voice_access, oversight_strength, arbitrariness_risk
  real :: governance_fragmentation, distrust_pressure
  real :: informal_power_concentration, score

  formal_legitimacy = 84.0
  procedural_fairness = 82.0
  informational_access = 79.0
  practical_influence = 81.0
  ethical_credibility = 83.0
  accountability_quality = 82.0
  voice_access = 80.0
  oversight_strength = 78.0
  arbitrariness_risk = 18.0
  governance_fragmentation = 24.0
  distrust_pressure = 20.0
  informal_power_concentration = 22.0

  score = 0.12 * formal_legitimacy + 0.12 * procedural_fairness + &
          0.10 * informational_access + 0.10 * practical_influence + &
          0.12 * ethical_credibility + 0.11 * accountability_quality + &
          0.10 * voice_access + 0.09 * oversight_strength - &
          0.08 * arbitrariness_risk - 0.07 * governance_fragmentation - &
          0.07 * distrust_pressure - 0.05 * informal_power_concentration

  print *, "Synthetic authority effectiveness score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program authority_governance_score_program

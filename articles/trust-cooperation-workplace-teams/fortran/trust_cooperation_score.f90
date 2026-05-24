! Trust and Cooperation in Workplace Teams
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, trustworthiness scoring,
! cooperation scoring, productivity ranking, or individual decisions.

program trust_cooperation_score_program
  implicit none
  real :: competence_trust, integrity_trust, benevolence_trust
  real :: reciprocity_norms, communication_reliability, opportunism_risk
  real :: power_imbalance, uncertainty_load, leadership_credibility
  real :: institutional_trust, score

  competence_trust = 84.0
  integrity_trust = 82.0
  benevolence_trust = 78.0
  reciprocity_norms = 81.0
  communication_reliability = 83.0
  opportunism_risk = 16.0
  power_imbalance = 20.0
  uncertainty_load = 52.0
  leadership_credibility = 84.0
  institutional_trust = 82.0

  score = 0.13 * competence_trust + 0.14 * integrity_trust + &
          0.12 * benevolence_trust + 0.13 * reciprocity_norms + &
          0.12 * communication_reliability + 0.11 * leadership_credibility + &
          0.11 * institutional_trust - 0.10 * opportunism_risk - &
          0.08 * power_imbalance - 0.05 * uncertainty_load

  print *, "Synthetic cooperative capacity score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program trust_cooperation_score_program

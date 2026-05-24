! Job Satisfaction and Organizational Commitment
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, commitment scoring,
! retention-risk scoring, productivity ranking, or individual decisions.

program satisfaction_commitment_score_program
  implicit none
  real :: leadership_support, reward_fairness, developmental_opportunity
  real :: workload_balance, institutional_trust, cultural_alignment
  real :: role_insecurity, exhaustion_pressure, score

  leadership_support = 84.0
  reward_fairness = 79.0
  developmental_opportunity = 82.0
  workload_balance = 76.0
  institutional_trust = 83.0
  cultural_alignment = 81.0
  role_insecurity = 18.0
  exhaustion_pressure = 22.0

  score = 0.16 * leadership_support + 0.15 * reward_fairness + &
          0.13 * developmental_opportunity + 0.14 * workload_balance + &
          0.13 * institutional_trust + 0.10 * cultural_alignment - &
          0.09 * role_insecurity - 0.10 * exhaustion_pressure

  print *, "Synthetic job satisfaction score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program satisfaction_commitment_score_program

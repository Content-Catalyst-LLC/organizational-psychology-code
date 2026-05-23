! Resistance to Organizational Change
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment or individual worker decisions.

program change_resistance_score
  implicit none
  real :: perceived_loss, uncertainty, identity_threat
  real :: routine_embeddedness, power_displacement, trust_in_leadership
  real :: participation_quality, implementation_clarity, workload_strain
  real :: failed_change_history, score

  perceived_loss = 26.0
  uncertainty = 32.0
  identity_threat = 24.0
  routine_embeddedness = 52.0
  power_displacement = 20.0
  trust_in_leadership = 84.0
  participation_quality = 81.0
  implementation_clarity = 86.0
  workload_strain = 41.0
  failed_change_history = 0.0

  score = 0.17 * perceived_loss + 0.16 * uncertainty + &
          0.13 * identity_threat + 0.13 * routine_embeddedness + &
          0.10 * power_displacement + 0.10 * workload_strain + &
          6.0 * failed_change_history - 0.12 * trust_in_leadership - &
          0.08 * participation_quality - 0.09 * implementation_clarity

  print *, "Synthetic institutional resistance intensity score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program change_resistance_score

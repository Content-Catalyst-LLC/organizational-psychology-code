! The Evolution of Organizational Psychology
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, organizational psychology
! education, and history-of-field analysis only. Not for employee, scholar,
! department, or journal ranking.

program field_evolution_score_program
  implicit none
  real :: selection_testing, efficiency_work_design, motivation_attitudes
  real :: groups_teams, culture_leadership_change, wellbeing_stress
  real :: justice_validity_ethics, digital_analytics
  real :: systems_institutional_accountability, score

  selection_testing = 72.0
  efficiency_work_design = 66.0
  motivation_attitudes = 84.0
  groups_teams = 86.0
  culture_leadership_change = 88.0
  wellbeing_stress = 86.0
  justice_validity_ethics = 92.0
  digital_analytics = 84.0
  systems_institutional_accountability = 90.0

  score = 0.18 * selection_testing + 0.08 * efficiency_work_design + &
          0.12 * motivation_attitudes + 0.12 * groups_teams + &
          0.14 * culture_leadership_change + 0.15 * wellbeing_stress + &
          0.17 * justice_validity_ethics + 0.08 * digital_analytics + &
          0.06 * systems_institutional_accountability

  print *, "Synthetic responsible progress score:", score
  print *, "Responsible-use reminder: educational field-evolution demo only."
end program field_evolution_score_program

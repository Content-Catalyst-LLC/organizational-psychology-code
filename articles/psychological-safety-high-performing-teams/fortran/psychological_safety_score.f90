! Psychological Safety in High-Performing Teams
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, courage scoring,
! voice scoring, productivity ranking, or individual worker decisions.

program psychological_safety_score_program
  implicit none
  real :: leadership_openness, inclusion_quality, learning_review_quality
  real :: knowledge_sharing, blame_intensity, status_asymmetry
  real :: perceived_penalty, workload_pressure, score

  leadership_openness = 84.0
  inclusion_quality = 82.0
  learning_review_quality = 80.0
  knowledge_sharing = 81.0
  blame_intensity = 16.0
  status_asymmetry = 20.0
  perceived_penalty = 18.0
  workload_pressure = 52.0

  score = 0.18 * leadership_openness + 0.16 * inclusion_quality + &
          0.15 * learning_review_quality + 0.14 * knowledge_sharing - &
          0.13 * blame_intensity - 0.11 * status_asymmetry - &
          0.10 * perceived_penalty - 0.06 * workload_pressure

  print *, "Synthetic psychological safety score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program psychological_safety_score_program

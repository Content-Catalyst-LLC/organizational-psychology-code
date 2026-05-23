! Strategic Decision-Making in Complex Organizations
! Simple Fortran scoring demonstration.
!
! Responsible-use scope:
! Synthetic-data research, methods demonstration, institutional learning,
! and reproducible workflows only. Not for employment, executive ranking,
! or individual worker decisions.

program strategic_decision_score
  implicit none
  real :: sensing_quality, interpretive_coherence, knowledge_integration
  real :: option_diversity, governance_quality, adaptive_learning
  real :: bias_pressure, political_distortion, complexity_load
  real :: environmental_turbulence, score

  sensing_quality = 84.0
  interpretive_coherence = 79.0
  knowledge_integration = 82.0
  option_diversity = 74.0
  governance_quality = 77.0
  adaptive_learning = 81.0
  bias_pressure = 18.0
  political_distortion = 14.0
  complexity_load = 58.0
  environmental_turbulence = 62.0

  score = 0.17 * sensing_quality + 0.16 * interpretive_coherence + &
          0.16 * knowledge_integration + 0.12 * option_diversity + &
          0.13 * governance_quality + 0.14 * adaptive_learning - &
          0.12 * bias_pressure - 0.10 * political_distortion - &
          0.09 * complexity_load - 0.08 * environmental_turbulence

  print *, "Synthetic strategic decision quality score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program strategic_decision_score

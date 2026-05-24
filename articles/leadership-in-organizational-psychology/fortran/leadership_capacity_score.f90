program leadership_capacity_score_program
  implicit none
  real :: score
  score = 0.11*83.0 + 0.11*81.0 + 0.10*79.0 + 0.11*82.0 + 0.10*80.0 + &
          0.10*81.0 + 0.08*80.0 + 0.09*82.0 + 0.08*81.0 + 0.08*80.0 - &
          0.07*20.0 - 0.08*18.0 - 0.07*22.0 - 0.06*24.0
  print *, "Synthetic leadership capacity score:", score
  print *, "Responsible-use reminder: institutional learning only."
end program leadership_capacity_score_program

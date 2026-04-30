program organizational_resilience
  implicit none

  integer :: t
  real :: functioning
  real, parameter :: baseline = 0.82
  real, parameter :: recovery = 0.10
  real, parameter :: learning = 0.08
  real, parameter :: strain = 0.05

  functioning = 0.45

  print *, "Time", "Functioning"

  do t = 1, 12
     functioning = functioning + recovery * (baseline - functioning) + learning - strain
     if (functioning > 1.0) functioning = 1.0
     if (functioning < 0.0) functioning = 0.0
     print *, t, functioning
  end do

end program organizational_resilience

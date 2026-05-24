#include <iostream>

struct Profile { double t,c,m,l,a,p,r,e,d,v,u,di,f,o; };

double leadership_capacity_score(const Profile& x) {
    return 0.11*x.t + 0.11*x.c + 0.10*x.m + 0.11*x.l + 0.10*x.a + 0.10*x.p +
           0.08*x.r + 0.09*x.e + 0.08*x.d + 0.08*x.v - 0.07*x.u - 0.08*x.di -
           0.07*x.f - 0.06*x.o;
}

int main() {
    Profile profile{83,81,79,82,80,81,80,82,81,80,20,18,22,24};
    std::cout << "Synthetic leadership capacity score: " << leadership_capacity_score(profile) << "\n";
    std::cout << "Responsible-use reminder: institutional learning only.\n";
}

P=.7;
Q=.7;
Vn=.3;
Vp=.8;
k2=.8;
n=Vn/Vp;

A=3*P^2*n
B=-3*P^2*n+sqrt(3)*P*Q*n*(2*k2-1)
C=3*n*k2*Q^2*(1-k2)-sqrt(3)*P*Q*n*k2

delta=B^2-4*A*C;

k1=(-B+sqrt(delta))/2/A
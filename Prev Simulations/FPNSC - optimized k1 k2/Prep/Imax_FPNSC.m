clc
syms n k1 k2 P Q Vp Vn

K1=P/Vn*((n+1)*k1-1);
K2=Q/Vn*((n-1)*k2+1);
K3=P/Vn*((n-1)*k1+1);
K4=Q/Vn*((n+1)*k2-1);

K1b=(-.5*K1+sqrt(3)/2*K4)^2;
K2b=(.5*K2+sqrt(3)/2*K3)^2;

diff_K1b_k1=diff(K1b,k1)
pretty(diff_K1b_k1);
solv_k1=solve(diff_K1b_k1==0,k1)
pretty(solv_k1);

diff_K2b_k2=diff(K2b,k2)
pretty(diff_K2b_k2);
solv_k2=solve(diff_K2b_k2==0,k2);
pretty(solv_k2);

clc

K1c=(-.5*K1-sqrt(3)/2*K4)^2;
K2c=(.5*K2-sqrt(3)/2*K3)^2;

diff_K1c_k1=diff(K1c,k1)
pretty(diff_K1c_k1);
solv_k1=solve(diff_K1c_k1==0,k1)
pretty(solv_k1);

diff_K2c_k2=diff(K2c,k2)
pretty(diff_K2c_k2);
solv_k2=solve(diff_K2c_k2==0,k2);
pretty(solv_k2);
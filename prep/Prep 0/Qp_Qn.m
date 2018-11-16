clc
clear all
close all
syms n k1 k2 P Q Vp Vn

Xg=0.5;

phi=0;
VL=.9; VU=1.1;
Vgp=.9;
Vgn=0;

x=max(cos(phi), max(cos(phi+2*pi/3), cos(phi-2*pi/3)));
y=min(cos(phi), min(cos(phi+2*pi/3), cos(phi-2*pi/3)));


Vpr=sqrt((x*VL^2-y*VU^2+sqrt((x*VL^2-y*VU^2)^2-(VL^2-VU^2)^2))/(2*(x-y)))
Vnr=sqrt((x*VL^2-y*VU^2-sqrt((x*VL^2-y*VU^2)^2-(VL^2-VU^2)^2))/(2*(x-y)))


Qp=3/2*(Vpr*(Vpr-Vgp))/Xg
Qn=3/2*(Vnr*(Vgn-Vnr))/Xg

In=Qn/Vnr;

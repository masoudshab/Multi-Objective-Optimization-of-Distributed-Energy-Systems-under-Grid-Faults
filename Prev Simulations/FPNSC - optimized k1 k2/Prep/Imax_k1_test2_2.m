clc 
clear all
P=.7;
Q=.4;
Vn=.1;
Vp=.6;
k2=.8;
i=1;

n=Vn/Vp;
              
k1=0:.001:1;
%                     k1(2)=(P-sqrt(3)*Q+sqrt(3)*Q*(1+n)*k2(k))/(P*(1+n));
%                     k1(3)=(P+sqrt(3)*Q-sqrt(3)*Q*(1+n)*k2(k))/(P*(1+n))
%                    

for j=1:1001
                        K1(j)=P/Vn*((n+1)*k1(j)-1);
                        K2(j)=Q/Vn*((n-1)*k2+1);
                        K3(j)=P/Vn*((n-1)*k1(j)+1);
                        K4(j)=Q/Vn*((n+1)*k2-1);
                        
                        Ia(j)=K1(j)^2+K2(j)^2;
                        Ib(j)=(-.5*K1(j)+sqrt(3)/2*K4(j))^2+(.5*K2(j)+sqrt(3)/2*K3(j))^2;
                        Ic(j)=(-.5*K1(j)-sqrt(3)/2*K4(j))^2+(.5*K2(j)-sqrt(3)/2*K3(j))^2;
                        
                        Imax(j)=sqrt(max(max(Ia(j),Ib(j)),Ic(j)));
end

figure
plot(k1,Imax,'LineWidth',2)
hold on
plot(k1,sqrt(Ia),'r')
plot(k1,sqrt(Ib),'g')
plot(k1,sqrt(Ic),'k')

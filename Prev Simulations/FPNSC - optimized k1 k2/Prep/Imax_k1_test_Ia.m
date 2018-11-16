clc 
clear all
P=.7; p=1;
Q=.4; q=1;
Vn=.1; vn=1;
Vp=.6; vp=1;
k2=.8; k=1;
k1=.01:0.01:1;

n=Vn(vn)/Vp(vp);
                
for j=1:100
                        K1(j)=P(p)/Vn(vn)*((n+1)*k1(j)-1);
                        K2(j)=Q(q)/Vn(vn)*((n-1)*k2(k)+1);
                        K3(j)=P(p)/Vn(vn)*((n-1)*k1(j)+1);
                        K4(j)=Q(q)/Vn(vn)*((n+1)*k2(k)-1);
                        
                        Ia(j)=K1(j)^2+K2(j)^2;
                        Ib(j)=(-.5*K1(j)+sqrt(3)/2*K4(j))^2+(.5*K2(j)+sqrt(3)/2*K3(j))^2;
                        Ic(j)=(-.5*K1(j)-sqrt(3)/2*K4(j))^2+(.5*K2(j)-sqrt(3)/2*K3(j))^2;
                        
                        Imax(j)=sqrt(max(max(Ia(j),Ib(j)),Ic(j)));
end


plot(k1,sqrt(Ia),'r')
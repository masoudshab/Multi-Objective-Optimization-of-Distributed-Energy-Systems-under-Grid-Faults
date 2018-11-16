clc 
clear all
P=.7;
Q=.4;
Vn=.3;
Vp=[.6 .8];
k2=[.6 .8];
i=1;

for vp=1:2
    n=Vn/Vp(vp);
                k1(1)=1/(n+1);
                for k=1:2
                    k1(2)=(P-sqrt(3)*Q+sqrt(3)*Q*(1+n)*k2(k))/(P*(1+n));
                    k1(3)=(P+sqrt(3)*Q-sqrt(3)*Q*(1+n)*k2(k))/(P*(1+n))
                    
                    for j=1:3
                        if k1(j)>1
                            k1(j)=1
                        end
                        if k1(j)<0
                            k1(j)=0
                        end
                        K1(j)=P/Vn*((n+1)*k1(j)-1);
                        K2(j)=Q/Vn*((n-1)*k2(k)+1);
                        K3(j)=P/Vn*((n-1)*k1(j)+1);
                        K4(j)=Q/Vn*((n+1)*k2(k)-1);
                        
                        Ia(j)=K1(j)^2+K2(j)^2
                        Ib(j)=(-.5*K1(j)+sqrt(3)/2*K4(j))^2+(.5*K2(j)+sqrt(3)/2*K3(j))^2
                        Ic(j)=(-.5*K1(j)-sqrt(3)/2*K4(j))^2+(.5*K2(j)-sqrt(3)/2*K3(j))^2
                        
                        Imax(j)=sqrt(max(max(Ia(j),Ib(j)),Ic(j)))
                    end
                    
                    J=find(Imax==min(Imax))
                    X2(i,:)=[P Q n(vp) Vn k2(k) k1(J) min(Imax)]
                    i=i+1;
                end
end


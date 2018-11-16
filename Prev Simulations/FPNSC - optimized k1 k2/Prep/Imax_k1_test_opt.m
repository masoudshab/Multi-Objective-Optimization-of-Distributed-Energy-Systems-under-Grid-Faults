clc
clear all
syms n k1 k2 P Q Vp Vn

P=[.4 .7];
Q=[.4 .7];
Vn=[.1 .3];
Vp=[.6 .8];
k2=[.2 .6 .8];
k1=.01:0.01:1;
i=1;

for p=1:2
    for q=1:2
        for vn=1:2
            for vp=1:2
                n=Vn(vn)/Vp(vp);
                for k=1:3
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
                    
                    k1_opt(1)=1/(n+1);
                    k1_opt(2)=(P(p)-sqrt(3)*Q(q)+sqrt(3)*Q(q)*(1+n)*k2(k))/(P(p)*(1+n));
                    k1_opt(3)=(P(p)+sqrt(3)*Q(q)-sqrt(3)*Q(q)*(1+n)*k2(k))/(P(p)*(1+n));
                    
                    for o=1:3
                    
                        if k1_opt(o)>1
                            k1_opt(o)=1;
                        end
                        if k1_opt(o)<0
                            k1_opt(o)=0;
                        end
                        K1_opt(o)=P(p)/Vn(vn)*((n+1)*k1_opt(o)-1);
                        K2_opt(o)=Q(q)/Vn(vn)*((n-1)*k2(k)+1);
                        K3_opt(o)=P(p)/Vn(vn)*((n-1)*k1_opt(o)+1);
                        K4_opt(o)=Q(q)/Vn(vn)*((n+1)*k2(k)-1);
                        
                        Ia_opt(o)=K1_opt(o)^2+K2_opt(o)^2;
                        Ib_opt(o)=(-.5*K1_opt(o)+sqrt(3)/2*K4_opt(o))^2+(.5*K2_opt(o)+sqrt(3)/2*K3_opt(o))^2;
                        Ic_opt(o)=(-.5*K1_opt(o)-sqrt(3)/2*K4_opt(o))^2+(.5*K2_opt(o)-sqrt(3)/2*K3_opt(o))^2;
                        
                        Imax_opt(o)=sqrt(max(max(Ia_opt(o),Ib_opt(o)),Ic_opt(o)));
                    end
                    O=find(Imax_opt==min(Imax_opt));
                    J=find(Imax==min(Imax));
                    X1(:,i)=[i k1(J) min(Imax) k1_opt(O) min(Imax_opt)];
                    
                    figure
plot(k1,Imax,'LineWidth',2)
hold on
plot(k1,sqrt(Ia),'r')
plot(k1,sqrt(Ib),'g')
plot(k1,sqrt(Ic),'k')
plot(k1(J),min(Imax),'o','LineWidth',2)
legend('Imax','Ia','Ib','Ic')
% hold on
% plot(k1_opt,sqrt(Ia_opt),'ro')
% plot(k1_opt,sqrt(Ib_opt),'go')
% plot(k1_opt,sqrt(Ic_opt),'ko')
                    title(i)
                    
                    xlabel([k1(J) k1_opt(O)]);
                    ylabel([min(Imax) min(Imax_opt)]);
i=i+1;
                end
            end
        end
    end
end

X1;


                        
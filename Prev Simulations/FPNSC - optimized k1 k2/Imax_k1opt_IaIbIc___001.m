clc
clear all
close all
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
                    k1_opt(2)=(P(p)*(2-n)+sqrt(3)*Q(q)*n*(2*k2(k)-1))/(2*P(p)*(n^2+1-n));
                    k1_opt(3)=(P(p)*(2-n)-sqrt(3)*Q(q)*n*(2*k2(k)-1))/(2*P(p)*(n^2+1-n));
                    o_num=3;
                    
                    A=3*P(p)^2*n; B=-3*P(p)^2*n+sqrt(3)*P(p)*Q(q)*n*(2*k2(k)-1); C=3*n*k2(k)*Q(q)^2*(1-k2(k))-sqrt(3)*P(p)*Q(q)*n*k2(k);
                    delta=B^2-4*A*C;
                    
                    if delta>=0
                        k1_intsec_IaIb=(-B+sqrt(delta))/2/A;
                        o_num=4;
                        k1_opt(o_num)=k1_intsec_IaIb;
                    end
                    
                    for o=1:o_num
                    
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
                    X1(:,i)=[i k1(J) min(Imax)];
                    
                   if i==18 || i==23 || i==24 || i==33 || i==34 || i==36
                       
                       figure

plot(k1,Imax,'--','LineWidth',3)
hold on
plot(k1,sqrt(Ia),'r')
plot(k1,sqrt(Ib),'g')
plot(k1,sqrt(Ic),'k')

legend('Imax','Ia','Ib','Ic')
hold on
plot(k1_opt(O),min(Imax_opt),'bs','MarkerSize',10,'MarkerFaceColor','b')

plot(k1(J),min(Imax),'o','LineWidth',2)

                    title([P(p); Q(q); Vn(vn); Vp(vp); i])
                    
                    xlabel([k1(J) k1_opt(O)]);
                    ylabel([min(Imax) min(Imax_opt)]);
 
%% 
                    A=3*P(p)^2*n; B=-3*P(p)^2*n+sqrt(3)*P(p)*Q(q)*n*(2*k2(k)-1); C=3*n*k2(k)*Q(q)^2*(1-k2(k))-sqrt(3)*P(p)*Q(q)*n*k2(k);
                    delta=B^2-4*A*C;
                    if delta>=0
                        k1_intsec_IaIb=(-B+sqrt(delta))/2/A;
                        o_num=4;
                        k1_opt(o_num)=k1_intsec_IaIb;
                        
                        
                        if k1_intsec_IaIb<1 && k1_intsec_IaIb>0
                           
                        K1_intsec=P(p)/Vn(vn)*((n+1)*k1_intsec_IaIb-1);
                        K2_intsec=Q(q)/Vn(vn)*((n-1)*k2(k)+1);
                        K3_intsec=P(p)/Vn(vn)*((n-1)*k1_intsec_IaIb+1);
                        K4_intsec=Q(q)/Vn(vn)*((n+1)*k2(k)-1);
                        
                        Ia_intsec=K1_intsec^2+K2_intsec^2;
                        Ic_intsec=(-.5*K1_intsec-sqrt(3)/2*K4_intsec)^2+(.5*K2_intsec-sqrt(3)/2*K3_intsec)^2;
                        
                        plot(k1_intsec_IaIb,sqrt(Ia_intsec),'ks','MarkerSize',10)

                        Imax_intsec=sqrt(max(Ia_intsec,Ic_intsec));
                        end
                    end
                    
                    
                    
                  %%
                    A=3*P(p)^2*n; B=-3*P(p)^2*n-sqrt(3)*P(p)*Q(q)*n*(2*k2(k)-1); C=3*n*k2(k)*Q(q)^2*(1-k2(k))+sqrt(3)*P(p)*Q(q)*n*k2(k);
                    delta_IaIc=B^2-4*A*C;
                    if delta_IaIc>=0
                        k1_intsec_IaIc=(-B+sqrt(delta_IaIc))/2/A;
                                     
                        if k1_intsec_IaIc<1 && k1_intsec_IaIc>0
                           
                        K1_intsec=P(p)/Vn(vn)*((n+1)*k1_intsec_IaIc-1);
                        K2_intsec=Q(q)/Vn(vn)*((n-1)*k2(k)+1);
                        K3_intsec=P(p)/Vn(vn)*((n-1)*k1_intsec_IaIc+1);
                        K4_intsec=Q(q)/Vn(vn)*((n+1)*k2(k)-1);
                        
                        Ia_intsec=K1_intsec^2+K2_intsec^2;
                        Ib_intsec=(-.5*K1_intsec+sqrt(3)/2*K4_intsec)^2+(.5*K2_intsec+sqrt(3)/2*K3_intsec)^2;

                        plot(k1_intsec_IaIc,sqrt(Ia_intsec),'bs','MarkerSize',10)

                        end
                        

                        end
                    end
                    
                        i=i+1;
                    
                end
            end
        end
    end
end

X1;


                        
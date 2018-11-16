clc
clear all
close all
syms n k1 k2 P Q Vp Vn

P=[.4 .7];
Q=[.4 .7];
Vn=[.3];
Vp=[.7];
k2=[.8 .85 .9];
k1=.01:0.01:1;
i=1;

for p=1:2
    for q=1:2
        for vn=1:1
            for vp=1:1
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
                    
%                    if i==18 || i==23 || i==24 || i==33 || i==34 || i==36
                       
                       figure
set(0,'DefaultAxesFontSize',24,'DefaultAxesFontName','Helvetica','DefaultAxesFontWeight','bold','DefaultLineLineWidth',2,'DefaultAxesLineWidth',1)
plot(k1,Imax,'--','color',[0 .45 .74],'LineWidth',6)
grid on
hold on
plot(k1,sqrt(Ia),'color',[0.75 0 .75])
plot(k1,sqrt(Ib),'color',[.85 .33 .1])
plot(k1,sqrt(Ic),'color',[0 .5 0])

legend('Imax','Ia','Ib','Ic')
hold on
plot(k1_opt(O),min(Imax_opt),'s','color',[0 .45 .74],'MarkerSize',25,'MarkerFaceColor',[0 .45 .74])

plot(k1(J),min(Imax),'o','color',[.85 .33 .1],'LineWidth',2,'MarkerSize',15)

                    title(['P=', num2str(P(p)), '  pu    Q=', num2str(Q(q)), '  pu    Vp=', num2str(Vp(vp)), '  pu    Vn=', num2str(Vn(vn)), '  pu      k_q=', num2str(k2(k)),'   pu      k_p_,_o_p_t=  ', num2str(k1_opt(O(1))), '         I_m_a_x_,_o_p_t=  ', num2str(min(Imax_opt)), '   pu'])
                    
                    xlabel('k_p');
                    ylabel('I_m_a_x (pu)');
 
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
                        
                        plot(k1_intsec_IaIb,sqrt(Ia_intsec),'s','color',[0 .45 .74],'MarkerSize',25)

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

                        plot(k1_intsec_IaIc,sqrt(Ia_intsec),'s','color',[0 .45 .74],'MarkerSize',25)

                        end
                        

                        end
                    end
                    
                        i=i+1;
                    
                end
            end
        end
    end
% end

X1;


                        
clear all
clc
P=0.1:.1:.5;
Q=.12:.1:.52;
n=0:0.01:.9;

for p=1:5
    for q=1:5
        for i=1:91
            k2(i)=(Q(q)*(2-n(i))-sqrt(3)*n(i)*P(p))/(2*Q(q)*(1-n(i)^2));
            k1(i)=(P(p)+sqrt(3)*Q(q)-sqrt(3)*Q(q)*(1+n(i))*k2(i))/(P(p)*(1+n(i)));
           
            
        end
         plot(n,k2)
         hold on
            plot(n,k1,'r')
            ylim([-3 3])
    end
end



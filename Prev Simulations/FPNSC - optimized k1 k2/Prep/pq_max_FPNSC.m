
n=0.5:0.05:1;
P=0.5:0.05:1;

for k=1:11
    for m=1:11
        
    Q=sqrt(1-P(k)^2); k1=0:0.05:1; k2=0:0.05:1;

for i=1:21
    for j=1:21
        p_max(i,j)=sqrt(P(k)^2*(-k1(i)*n(m)-(1-k1(i))/n(m))^2+Q^2*(k2(j)*n(m)-(1-k2(j))/n(m))^2);
        q_max(i,j)=sqrt(P(k)^2*(-k1(i)*n(m)+(1-k1(i))/n(m))^2+Q^2*(-k2(j)*n(m)-(1-k2(j))/n(m))^2);
    end
end
a=min(min(p_max))
K(k,m,3)=min(min(p_max));
[r,c]=find(p_max==min(min(p_max)))
if r > 0 & c > 0
K(k,m,1)=r(1);
K(k,m,2)=c(1);
end
% figure 
surf(k1,k2,.5*(p_max+q_max))
hold on
% surf(k1,k2,q_max)
    end
end


function [c,ceq] = ga_con1(x)

x1=x(1);
x2=x(2);
x3=x(3);

c=[x1+2*x1^2+x2+2*x2^2+x3-10;
   x1+x1^2+x2+x2^2-x3-50;
   2*x1+x1^2+2*x2+x3-40];
ceq=[x1^2+x3-2];

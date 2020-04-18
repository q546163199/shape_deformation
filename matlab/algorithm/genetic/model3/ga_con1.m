function [c,ceq] = ga_con1(x)

x1=x(1);
x2=x(2);

c=[1.5+x1*x2+x1-x2;
   10-x1*x2];
ceq=[];

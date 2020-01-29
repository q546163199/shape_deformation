function [F] = RK_sub(tau,Y,t)
%%
p1 = 2.9;p2 =0.76;p3 = 0.87;p4 = 3.04;p5 = 0.87;g=9.8;
q = [Y(1);Y(2)];dq = [Y(3);Y(4)];
q1 = q(1);q2 = q(2);dq1 = dq(1); dq2 = dq(2);
%%
M = [p1 + p2 + 2*p3*cos(q2), p2 + p3*cos(q2);
     p2 + p3*cos(q2),        p2];
C = [-p3 * dq2 * sin(q2), -p3*(dq1+dq2)*sin(q2);
     p3*dq1*sin(q2),0];
G = [p4*g*cos(q1) + p5*g*cos(q1+q2);
     p5*g*cos(q1+q2)];
Fd = [0.2*sign(dq1);
      0.2*sign(dq2)];
taud = [0.1*sin(t);
        0.1*sin(t)];
%%
F1 = dq;
F2 = M\(tau - C*dq - G - Fd - taud);
F =[F1' F2']';
end
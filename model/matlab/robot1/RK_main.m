function [q,dq,ddq] = RK_main(tau,Y,h,t)

Y0 = Y;
q0 = [Y0(1);Y0(2)];dq0 = [Y0(3);Y0(4)];
tau0 = tau;

K1 = RK_sub(tau0,Y0,t);
K2 = RK_sub(tau0 + h/2,Y0 + h*K1/2,t);
K3 = RK_sub(tau0 + h/2,Y0 + h*K2/2,t);
K4 = RK_sub(tau0 + h  ,Y0 + h*K3,t);

temp = h/6*(K1 + 2*K2 + 2*K3 + K4);
q = q0 + temp(1:2);
dq = dq0 + temp(3:4);
ddq = (dq - dq0) / h;
end
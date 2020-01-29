function [q,dq,ddq] = RK_main(q,dq,tau,h,t)

q0 = q;
dq0 = dq;
tau0 = tau;

K1 = RK_sub(tau0,q0,dq0,t);
K2 = RK_sub(tau0 + h/2,q0 + h*K1(1:2)/2,dq0 + h*K1(3:4)/2,t);
K3 = RK_sub(tau0 + h/2,q0 + h*K2(1:2)/2,dq0 + h*K2(3:4)/2,t);
K4 = RK_sub(tau0 + h  ,q0 + h*K3(1:2)  ,dq0 + h*K3(3:4),t);

temp = h/6*(K1 + 2*K2 + 2*K3 + K4);
q = q0 + temp(1:2);
dq = dq0 + temp(3:4);
ddq = (dq - dq0) / h;
end
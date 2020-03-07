function [y,dy] = RK_main(x,y,h)

x0 = x;
y0 = y;

K1 = RK_sub(x0,y0);
K2 = RK_sub(x0 + h/2,y0 + h*K1/2);
K3 = RK_sub(x0 + h/2,y0 + h*K2/2);
K4 = RK_sub(x0 + h  ,y0 + h*K3);

y = y0 + h/6*(K1 + 2*K2 + 2*K3 + K4);
dy = (y - y0) / h;
end
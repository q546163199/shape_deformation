function[c,ceq] = nlinconfun(a)
% Equality constraints
global N Lx Ly Theta1 Theta2 L n
lx = 0;
ly = 0;
for k = 1 : N
    phi = a(1) + a(2) * L * k / N;
    for i = 1 : n
        phi = phi + a(2 * i + 1) * sin(2 * pi * i * k / N) + a(2 * i + 2) * cos(2 * pi * i * k / N);
    end
    lx = lx + cos(phi) * L / N;
    ly = ly + sin(phi) * L / N;
end
theta1 = a(1);
theta2 = a(1) + a(2) * L;
for i = 1 : n
    theta1 = theta1 + a(2 * i + 2);
    theta2 = theta2 + a(2 * i + 2);
end
c = [];
ceq(1) = lx - Lx;
ceq(2) = ly - Ly;
ceq(3) = theta1 - Theta1;
ceq(4) = theta2 - Theta2;
end
function f = cable_cost(a)
% Opimization function
global L n

f = a(2)^2 * L;
for i = 1 : n
    f = f + a(2 * i + 1)^2 * (2 * pi * i / L)^2 * L / 2 + a(2 * i + 2)^2 * (2 * pi * i / L)^2 * L / 2;
end
end
function f = fun011(x)
m = [1 4 3 5 9 12 6 20 17 8];
n = [2 10 8 18 1 4 5 10 8 9];

for i=1:10
    f(i) = abs(x(1) - m(i)) + abs(x(2) - n(i));
end
end
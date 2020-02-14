function f = fun(A)
load('data','x','y')
N = size(x,2);
f = 0;
for i=1:N
    cost = norm(y(:,i) - A*x(:,i))^2;
    f = f + cost;
end
f = f/N;
end
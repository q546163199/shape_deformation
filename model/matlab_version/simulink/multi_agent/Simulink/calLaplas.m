function L=calLaplas(A)

order = length(A);
for i=1:order
    d(i) = 0;
end

for i=1:order
    for j=1:order
        d(i) = d(i) + A(i,j);
    end
end

D = diag(d);
L = D - A;
end
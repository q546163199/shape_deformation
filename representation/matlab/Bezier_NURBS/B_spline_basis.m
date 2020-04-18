function B = B_spline_basis(i,k,t)
%%
F = 0;
%%
for j=1:(k-i+1)
    F_temp = (-1)^(j-1) * nchoosek(k+1,j-1)*(t+k-i-j+1)^k;
    F = F + F_temp;
end
B = F/factorial(k);
end
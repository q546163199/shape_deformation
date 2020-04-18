function [s,G,shape_est_NURBS] = NURBS_curve_2D(shape,length,n)
%%
L = size(shape,1);
c = zeros(2*L,1);
G_temp = [];
G = [];
%% calculate c
for i=1:L
    c(2*i-1) = shape(i,1);
    c(2*i) = shape(i,2);
end
%%
omega = rand(L,1) * 1;
k = n + 1;
for i=1:L
    t(i) = i/L * length;
    for j=1:k
        a1(j) = omega(j) * B_spline_basis(j-1,n,t(i));
    end
    a1_sum = sum(a1);
    a2 = diag(diag(repmat(a1_sum,k,k)));
    a2 = inv(a2);
    P = a1 * a2;
    G_temp = blkdiag(P,P);
    G = [G;G_temp];
end
%% calculate s
s = (G'*G)\G'*c;
%% calculate estimated shape
shape_temp = G * s;
for i=1:L
    shape_est_NURBS(i,1) = shape_temp(2*i-1);
    shape_est_NURBS(i,2) = shape_temp(2*i);
end
error = norm(shape(:,1:2) - shape_est_NURBS(:,1:2),2);
end
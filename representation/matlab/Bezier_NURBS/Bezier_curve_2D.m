function [s,G,shape_est_Bezier] = Bezier_curve_2D(shape,length,N)
% N = the order of harmonics
L = size(shape,1);
c = zeros(2*L,1);
G_temp = [];
G = [];
P = N + 1;
%% calculate c
for i=1:L
    c(2*i-1) = shape(i,1);
    c(2*i) = shape(i,2);
end
%% calculate G
for i=1:L
    t(i) = i/L * length;
    for j=1:P
        G_temp(1,j) = nchoosek(N,j-1)*(1-t(i))^(N+1-j)*t(i)^(j-1);
    end
    G_temp = blkdiag(G_temp,G_temp);
    G = [G;G_temp];
    G_temp = [];
end
%% calculate s
s = (G'*G)\G'*c;
%% calculate estimated shape
shape_temp = G * s;
for i=1:L
    shape_est_Bezier(i,1) = shape_temp(2*i-1);
    shape_est_Bezier(i,2) = shape_temp(2*i);
end
error = norm(shape(:,1:2) - shape_est_Bezier(:,1:2),2);
end

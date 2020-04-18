function [s,G,shape_est_Fourier] = Fourier_curve_2D(shape,length,N)
% N = the order of harmonics
L = size(shape,1);P = 4*N + 2;
c = zeros(2*L,1);
G_temp = [];
G = [];
%% calculate c
for i=1:L
    c(2*i-1) = shape(i,1);
    c(2*i) = shape(i,2);
end
%% calculate G
for i=1:L
    rho(i) = i/L * length;
    for j=1:N
        F_temp = [cos(j*rho(i)) sin(j*rho(i)) 0 0;0 0 cos(j*rho(i)) sin(j*rho(i))];
        G_temp = [G_temp F_temp];
    end
    G_temp = [G_temp eye(2)];
    G = [G;G_temp];
    G_temp = [];
end
%% calculate s
s = (G'*G)\G'*c;
%% calculate estimated shape
shape_temp = G * s;
for i=1:L
    shape_est_Fourier(i,1) = shape_temp(2*i-1);
    shape_est_Fourier(i,2) = shape_temp(2*i);
end
error = norm(shape(:,1:2) - shape_est_Fourier(:,1:2),2);
%% calculate the norm2 of error between real shape and estiamted shape
% fprintf('norm-2 of error between real shape and Fourier shape each time is: %f\n',error)
end

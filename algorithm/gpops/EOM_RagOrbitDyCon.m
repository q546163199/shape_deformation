function dX = EOM_RagOrbitDyCon(X)
global Para;

%% Define all states

GM  = Para.GM;
N   = Para.N;                                                              %% Define Navigation Ratio
M_r = Para.M_r;                                                            %% Velocity Control Gains
M_v = Para.M_v;

r    =  X(1:2);
v    =  X(3:4);
r_m  =  X(5:6);
v_m  =  X(7:8);

v_t = v + v_m;
r_t = r + r_m;
k_t = 1/norm(r_t);

%% Define acceleration

T_si = r/norm(r);
a = T_si(1);
b = T_si(2);
N_si = [-b;a];

T_t = v_t/norm(v_t);
a = T_t(1);
b = T_t(2);
N_t = [-b;a];    
    
T_m = v_m/norm(v_m);
a = T_m(1);
b = T_m(2);
N_m = [-b;a]; 

d_r   = T_si'*(v_t - v_m);
d_the = N_si'*(v_t - v_m)/norm(r);

a_t = -GM*r_t/(norm(r_t)^3);

denom = N_m'*N_si;                                                         %% Define the Denominator of the Curvature

a_v = (M_r*norm(r) + M_v*d_r)/denom;                                       %% Define the acceleration along v_m
    
k = (norm(v_t)/norm(v_m))^2*k_t*N_t'*N_si/denom - (1/norm(v_m))^2*N*d_r*d_the/denom - (1/norm(v_m))^3*a_v*norm(v_t)*T_t'*N_si/denom;
                                                                           % Define Curvature
a_m = norm(v_m)^2*k*N_m + T_m*a_v;
a_c = a_m + GM*r_m/(norm(r_m)^3);

%% EOM
dr   = v_t - v_m;
dv   = a_t - a_m;
dr_m = v_m;
dv_m = a_m;
d_c  = abs(a_c(1)) + abs(a_c(2));

dX = [dr;dv;dr_m;dv_m;d_c;k;norm(a_c)];
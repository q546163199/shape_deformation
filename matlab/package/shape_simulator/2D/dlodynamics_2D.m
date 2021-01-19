function [dloData, para_a, DLOangle] = dlodynamics_2D(x1, y1, x2, y2, langle, rangle, cable_length, init, format)
%% global
global L n N Lx Ly Theta1 Theta2
L = cable_length;
n = 4;
N = 100;
Lx = x2 - x1;       
Ly = y2 - y1;
Theta1 = langle;
Theta2 = rangle;

if isempty(init)
    init = zeros(2 * 4 +2, 1);
end

% format = 1 rod simulation and format = 2 area simulation
if isempty(format)
    format = 1;
end


A = [];
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
% options = optimset('LargeScale','off','display','iter');

[x,fval] = fmincon(@cable_cost,init,A,b,Aeq,beq,lb,ub,@nlinconfun);

para_a = x;
px = x1;
py = y1;
DLO = [px,py];  % This gives the position left end
DLOangle = 0;   % This gives the left angle
numOfData = 99;
for k = 1 : numOfData
    phi = para_a(1) + para_a(2) * L * k / numOfData;
    for i = 1 : n
        phi = phi + para_a(2 * i + 1) * sin(2 * pi * i * k / numOfData) + para_a(2 * i + 2) * cos(2 * pi * i * k / numOfData);
    end
    px = px + cos(phi) * L / numOfData;
    py = py + sin(phi) * L / numOfData;
    DLO = [DLO;px, py];
    DLOangle = [DLOangle; phi];
end

if format == 1
    dloData = DLO;
else
    radius = 0.015;
    for i=2:99
        if DLOangle(i) > 0
            theta = -(pi/2 - DLOangle(i));
            upper(i,1) = DLO(i,1) - radius * cos(theta);
            upper(i,2) = DLO(i,2) - radius * sin(theta);
        
            lower(i,1) = DLO(i,1) + radius * cos(theta);
            lower(i,2) = DLO(i,2) + radius * sin(theta);
        else
            theta = pi/2 + DLOangle(i);
            upper(i,1) = DLO(i,1) + radius * cos(theta);
            upper(i,2) = DLO(i,2) + radius * sin(theta);
            
            lower(i,1) = DLO(i,1) - radius * cos(theta);
            lower(i,2) = DLO(i,2) - radius * sin(theta);
        end
    end
    lower = flipud(lower);
    contour = [DLO(1,:);upper(2:99,:);DLO(100,:);lower(1:98,:);DLO(1,:)];
    dloData = contour;
end
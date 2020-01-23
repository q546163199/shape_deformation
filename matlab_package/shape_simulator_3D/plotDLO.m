function [p_dat, PHI_dat, T_dat] = plotDLO(param)

%
% Draw the DLO in 3D
%
% param: vector of serie parameters
%

global s0 ds s1 L

T = eye(4,4);
p_dat = [];
PHI_dat = [];
T_dat = [];

for s = s0:ds:s1
    p = CalcPosition(s,param);
    PHI = CalcOrientation(s,param);
    T = RotAxeAngle('z',PHI(3))*RotAxeAngle('y',PHI(2))*RotAxeAngle('x',PHI(1));
    T(1:3,4) = p;
    p_dat = [p_dat p];
    PHI_dat = [PHI_dat PHI];
    T_dat = [T_dat T];
end

p_dat = p_dat';
PHI_dat = PHI_dat';

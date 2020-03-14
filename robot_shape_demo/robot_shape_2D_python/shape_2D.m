function [shape, para_temp] = shape_2D(xleft, yleft, xright, yright, theta1, theta2, cable_length, init)
addpath('/home/qjm/ShapeDeformationProj/casadi-linux-matlabR2014b-v3.5.1')
switch nargin
    case 7
        init = zeros(2 * 4 +2, 1);
end

[shape, para_temp, ~] = dlodynamics_2D(xleft, yleft, xright, yright, theta1, theta2, cable_length, init);

end
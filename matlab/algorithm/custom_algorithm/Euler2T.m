function T = Euler2T(angle)
x = angle(1);
y = angle(2);
z = angle(3);
%% Å·À­½Ç×ªÐý×ª¾ØÕó Z-Y-X

Rx = [1 0       0      0; 
      0 cos(x) -sin(x) 0;
      0 sin(x)  cos(x) 0;
      0 0       0      1];
Ry = [ cos(y)  0 sin(y) 0;
       0       1      0 0;
      -sin(y)  0 cos(y) 0;
       0       0 0      1];
Rz = [cos(z) -sin(z) 0 0;
      sin(z)  cos(z) 0 0;
      0       0      1 0;
      0       0      0 1];
T = Rz * Ry * Rx;
end

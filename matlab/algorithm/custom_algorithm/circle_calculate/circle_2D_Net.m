function [R,centre] = circle_2D_Net(p1,p2,p3)

x1 = p1.x;
y1 = p1.y;
x2 = p2.x;
y2 = p2.y;
x3 = p3.x;
y3 = p3.y;
e = 2 * (x2 - x1);
f = 2 * (y2 - y1);
g = x2*x2 - x1*x1 + y2*y2 - y1*y1;
a = 2 * (x3 - x2);
b = 2 * (y3 - y2);
c = x3*x3 - x2*x2 + y3*y3 - y2*y2;
X = (g*b - c*f) / (e*b - a*f);
Y = (a*g - c*e) / (a*f - b*e);

centre.x = X;
centre.y = Y;
R = sqrt((X-x1)*(X-x1)+(Y-y1)*(Y-y1));
end

 
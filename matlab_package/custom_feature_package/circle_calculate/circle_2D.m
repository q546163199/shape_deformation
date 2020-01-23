function [R,centre] = circle_2D(p1,p2,p3)

x(1) = p1.x;
y(1) = p1.y;
x(2) = p2.x;
y(2) = p2.y;
x(3) = p3.x;
y(3) = p3.y;

u = (y(2) - y(1)) / (x(2) - x(1));
v = (y(3) - y(2)) / (x(3) - x(2));
w = 0.5 * (y(1) + y(2)) + 0.5 * (x(1) + x(2)) / ((y(2) - y(1)) / (x(2) - x(1)));
k = 0.5 * (y(2) + y(3)) + 0.5 * (x(2) + x(3)) / ((y(3) - y(2)) / (x(3) - x(2)));

cx = (k - w) / (1 / v - 1 / u);
cy = (w - k) / u / (1 / v - 1 / u) + w;
r = sqrt((y(1) - cy)^2 + (x(1) - cx)^2);

centre.x = cx;
centre.y = cy;
R = r;

end
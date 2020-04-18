function [R,centre] = circle_3D(p1,p2,p3,p4)

x1 = p1.x;
y1 = p1.y;
z1 = p1.z;
x2 = p2.x;
y2 = p2.y;
z2 = p2.z;
x3 = p3.x;
y3 = p3.y;
z3 = p3.z;
x4 = p4.x;
y4 = p4.y;
z4 = p4.z;

a11=2*(x2-x1); a12=2*(y2-y1); a13=2*(z2-z1);
a21=2*(x3-x2); a22=2*(y3-y2); a23=2*(z3-z2);
a31=2*(x4-x3); a32=2*(y4-y3); a33=2*(z4-z3);

b1=x2*x2-x1*x1+y2*y2-y1*y1+z2*z2-z1*z1;
b2=x3*x3-x2*x2+y3*y3-y2*y2+z3*z3-z2*z2;
b3=x4*x4-x3*x3+y4*y4-y3*y3+z4*z4-z3*z3;

d=a11*a22*a33+a12*a23*a31+a13*a21*a32-a11*a23*a32-a12*a21*a33-a13*a22*a31;

d1=b1*a22*a33+a12*a23*b3+a13*b2*a32-b1*a23*a32-a12*b2*a33-a13*a22*b3;
d2=a11*b2*a33+b1*a23*a31+a13*a21*b3-a11*a23*b3-b1*a21*a33-a13*b2*a31;
d3=a11*a22*b3+a12*b2*a31+b1*a21*a32-a11*b2*a32-a12*a21*b3-b1*a22*a31;

centre.x = d1/d;
centre.y = d2/d;
centre.z = d3/d;

R = sqrt((x1 - centre.x)^2 + (y1 - centre.y)^2 + (z1 - centre.z)^2);
end
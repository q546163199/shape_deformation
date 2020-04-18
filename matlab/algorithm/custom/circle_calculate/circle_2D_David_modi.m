function [R,centre,zeta] = circle_2D_David_modi(p1,p2,p3)

s1 = [p1.x p1.y];
s2 = [p2.x p2.y];
s3 = [p3.x p3.y];

sim = s1(1) * (s2(2) - s3(2)) + s2(1) * (s3(2) - s1(2)) + s3(1) * (s1(2) - s2(2));
cen = 1/2/sim * [s2(2) - s3(2) s3(2) - s1(2) s1(2) - s2(2);s3(1) - s2(1) s1(1) - s3(1) s2(1) - s1(1)] *[norm(s1)^2 norm(s2)^2 norm(s3)^2]';
zeta = 1/2 * sqrt((s1(1) - s3(1))^2 + (s1(2) - s3(2))^2) / sqrt((s1(1) - cen(1))^2 + (s1(2) - cen(2))^2);

centre.x = cen(1);
centre.y = cen(2);
R = sqrt((s1(1) - cen(1))^2 + (s1(2) - cen(2))^2);
end
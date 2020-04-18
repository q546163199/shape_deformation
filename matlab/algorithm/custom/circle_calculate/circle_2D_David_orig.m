function [R,centre] = circle_2D_David_orig(p1,p2,p3)

centre.x = 1/(2*(p1.x*(p2.y-p3.y)+p2.x*(p3.y-p1.y)+p3.x*(p1.y-p2.y)))*((p2.y-p3.y)*(p1.x*p1.x+p1.y*p1.y)+(p3.y-p1.y)*(p2.x*p2.x+p2.y*p2.y)+(p1.y-p2.y)*(p3.x*p3.x+p3.y*p3.y));
centre.y = 1/(2*(p1.x*(p2.y-p3.y)+p2.x*(p3.y-p1.y)+p3.x*(p1.y-p2.y)))*((p3.x-p2.x)*(p1.x*p1.x+p1.y*p1.y)+(p1.x-p3.x)*(p2.x*p2.x+p2.y*p2.y)+(p2.x-p1.x)*(p3.x*p3.x+p3.y*p3.y));
R = sqrt( (p1.x-centre.x)*(p1.x-centre.x) + (p1.y-centre.y)*(p1.y-centre.y) );

end
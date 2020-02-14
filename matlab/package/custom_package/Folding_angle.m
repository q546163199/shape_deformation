function [angle] = Folding_angle(p1,p2,p3)

s1 = [p1.x p1.y p1.z];
s2 = [p2.x p2.y p2.z];
s3 = [p3.x p3.y p3.z];

angle = acos(dot(s1-s2,s3-s2)/ norm(s1-s2)/ norm(s3-s2));
end


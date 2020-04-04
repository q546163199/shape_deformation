function angle = T2Euler(T)
%% Ðý×ª¾ØÕó×ªÅ·À­½Ç
R = T;
x = atan2(R(3,2),R(3,3));
y = atan2(-R(3,1),sqrt(R(3,2)^2+R(3,3)^2));
z = atan2(R(2,1),R(1,1));
angle = [x y z];

end
function modified = point_cloud_fill(original,fill_num,max_radius,mode_select)
%%
length = size(original,1);
modified = original;
%% 2D fill
if mode_select == 1
    for i=1:length
        basex = original(i,1);
        basey = original(i,2);
        for j=1:fill_num
            theta = rand * 360;
            radius = rand * max_radius;
            x = basex + radius*cosd(theta);
            y = basey + radius*sind(theta);
            modified(length + fill_num*(i-1) + j,1) = x;
            modified(length + fill_num*(i-1) + j,2) = y;
        end
    end
end
%% 3D fill
if mode_select == 2
    for i=1:length
        basex = original(i,1);
        basey = original(i,2);
        basez = original(i,3);
        for j=1:fill_num
            psi = rand * 360;
            theta = rand * 180;
            radius = rand * max_radius;
            x = basex + radius*sind(theta)*cosd(psi);
            y = basey + radius*sind(theta)*sind(psi);
            z = basez + radius*cosd(theta);
            modified(length + fill_num*(i-1) + j,1) = x;
            modified(length + fill_num*(i-1) + j,2) = y;
            modified(length + fill_num*(i-1) + j,3) = z;
        end
    end
end
%%
if mode_select ~= 1 && mode_select ~=2
    fprintf('Mode wrong, please try again\n')
end
end
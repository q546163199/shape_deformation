function modified = point_cloud_fill(original,fill_num,max_radius,mode_select)
%%
total_num = size(original,1);
modified = original;
%% 2D fill method 1
if mode_select == 1.1
    for i=1:total_num
        basex = original(i,1);
        basey = original(i,2);
        for j=1:fill_num
            theta = rand * 360;
            radius = rand * max_radius;
            x = basex + radius*cosd(theta);
            y = basey + radius*sind(theta);
            modified(total_num + fill_num*(i-1) + j,1) = x;
            modified(total_num + fill_num*(i-1) + j,2) = y;
        end
    end
    modified(:,3) = zeros(size(modified,1),1);
end
%% 2D fill method 2
if mode_select == 1.2
    theta = 1:10:360;
    radius = 0:max_radius/5:max_radius;
    for i=1:total_num
        basex = original(i,1);
        basey = original(i,2);
        for j=1:length(theta)
            for k=1:length(radius)
                x = basex + radius(k)*cosd(theta(j));
                y = basey + radius(k)*sind(theta(j));
                modified(total_num + length(theta)*length(radius)*(i-1) + length(radius)*(j-1) + k,1) = x;
                modified(total_num + length(theta)*length(radius)*(i-1) + length(radius)*(j-1) + k,2) = y;
            end
        end
    end
    modified(:,3) = zeros(size(modified,1),1);
end
%% 3D fill moethod 1
if mode_select == 2.1
    for i=1:total_num
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
            modified(total_num + fill_num*(i-1) + j,1) = x;
            modified(total_num + fill_num*(i-1) + j,2) = y;
            modified(total_num + fill_num*(i-1) + j,3) = z;
        end
    end
end
%% 3D fill method 2
if mode_select == 2.2
    psi = 1:40:360;
    theta = 1:30:180;
    for i=1:total_num
        basex = original(i,1);
        basey = original(i,2);
        basez = original(i,3);
        for j=1:length(psi)
            for k=1:length(theta)
                x = basex + max_radius*sind(theta(k))*cosd(psi(j));
                y = basey + max_radius*sind(theta(k))*sind(psi(j));
                z = basez + max_radius*cosd(theta(k));
                modified(total_num + length(psi)*length(theta)*(i-1) + length(theta)*(j-1) + k,1) = x;
                modified(total_num + length(psi)*length(theta)*(i-1) + length(theta)*(j-1) + k,2) = y;
                modified(total_num + length(psi)*length(theta)*(i-1) + length(theta)*(j-1) + k,3) = z;
            end
        end
    end
end
%%
if mode_select ~= 1.1 && mode_select ~= 1.2 && mode_select ~= 2.1 && mode_select ~= 2.2
    fprintf('Mode wrong, please try again\n')
end
end
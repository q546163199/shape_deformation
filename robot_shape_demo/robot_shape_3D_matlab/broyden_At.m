clc;clear;close all
path_set
%%
load('data','xt','yt','shape_real_save','G');
%%
rowNum = size(yt,1);
%% Broyden rule 
[At,ut,dt] = Broyden(xt,yt,0.1,1);
%% calculate y_est,namely the estimation of coefficients of Fourier
yt_est(1,:) = yt(1,:);
for i=1:(rowNum-1) 
    yt_est(i+1,:) = yt_est(i,:) + (At*ut(i+1,:)')';
end
%% calculate shape_est_At, use the estimated coefficient to get the shape of cable
for i=1:rowNum
    temp = G * yt_est(i,:)';
    for j=1:51
        shape_est_At(j,1,i) = temp(3*j - 2);
        shape_est_At(j,2,i) = temp(3*j - 1);
        shape_est_At(j,3,i) = temp(3*j - 0);
    end
    shape_error(i,:) = norm(shape_real_save(:,:,i) - shape_est_At(:,:,i),2);
    %% plot figure
    subplot(1,2,1)
    plot3(shape_real_save(:,1,i),shape_real_save(:,2,i),shape_real_save(:,3,i),'r-.','linewidth',2);hold on
    plot3(shape_est_At(:,1,i),shape_est_At(:,2,i),shape_est_At(:,3,i),'k-','linewidth',2);hold off
    grid on
    daspect([1 1 1])
    axis([-1 4 -1 4 -3 3])
    subplot(1,2,2)
    plot(shape_error(1:i),'k-*','linewidth',2);hold on
    grid on
    drawnow
    pause(0.01)
end
%% figure comparison(three shapes for each motion,each time)
save(['At'],'At')
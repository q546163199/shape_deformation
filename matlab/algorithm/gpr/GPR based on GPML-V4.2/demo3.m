clc;clear;close all
addpath(genpath(pwd))
%%
load('./data/data_3.mat')
%% GPR using gpml-matlab-v4.1
% 初始化超参数结构
meanfunc = []; % empty: don't use a mean function
covfunc = @covSEiso; % Squared Exponental covariance function
likfunc = @likGauss; % Gaussian likelihood
hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
% 优化超参数结构
hyp2 = minimize(hyp, @gp, -20, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
% GPR建模（ymu为预测值的均值，ys为预测值的方差）
[ymu, ys] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xt);
%% 可视化结果
xs = (1:size(xt,1))';
% 变量1
% 95%的置信度边界（3σ准则）
figure
f1 = [ymu(:,1) + 2*sqrt(ys(:,1)); 
      flip(ymu(:,1) - 2*sqrt(ys(:,1)),1)];
fill([xs; flip(xs,1)], f1, [7 7 7]/8)
hold on
% 实际数据
plot(yt(:,1 ),'r:o','MarkerSize',2)
% 预测数据
plot(ymu(:,1) ,'b:o','MarkerSize',2)
xlabel('样本点')
ylabel('幅值')
legend('95%置信度边界','原始数据','预测数据')
title('变量1的预测结果')
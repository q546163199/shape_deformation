clc;clear;close all
addpath(genpath(pwd))
%% 多输入多输出
load('./data/data_2.mat')
%{
x :   training inputs
y :   training targets
xt:   testing inputs
yt:   testing targets
%}
%% case1
% 设定均值函数、协方差函数以及似然函数,以meanConst、covRQiso和likGauss为例
% 超参数初始化
% 优化超参数
% 利用优化后的超参数进行GPR建模
% yfit为预测值的均值，ys为预测值的方差
meanfunc = @meanConst;
covfunc = @covRQiso; 
likfunc = @likGauss; 
hyp = struct('mean', 3, 'cov', [2 2 2], 'lik', -1);
hyp2 = minimize(hyp, @gp, -5, @infGaussLik, meanfunc, covfunc, likfunc,x, y);
[yfit, ys] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc,x, y, xt);
%% 可视化结果
% 第一个输出
plotResult(yt(:,1), yfit(:,1))
% 第二个输出
plotResult(yt(:,2), yfit(:,2))
%% case2
% 设定均值函数、协方差函数以及似然函数
% 以covSEiso和likGauss为例
% meanfunc = [];
% covfunc = @covSEiso; 
% likfunc = @likGauss; 
% % 超参数初始化
% hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
clc;clear;close all
addpath(genpath(pwd))
%% �����뵥���
load('./data/data_1.mat')
%{
x :   training inputs
y :   training targets
xt:   testing inputs
yt:   testing targets
%}
%% case1
% �趨��ֵ������Э������Լ���Ȼ����,��meanConst��covRQiso��likGaussΪ��
% ��������ʼ��
% �Ż�������
% �����Ż���ĳ���������GPR��ģ
% yfitΪԤ��ֵ�ľ�ֵ��ysΪԤ��ֵ�ķ���
meanfunc = @meanConst;
covfunc = @covRQiso; 
likfunc = @likGauss; 
hyp = struct('mean', 3, 'cov', [0 0 0], 'lik', -1);
hyp2 = minimize(hyp, @gp, -20, @infGaussLik, meanfunc, covfunc, likfunc,x, y);
[yfit, ys] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc,x, y, xt);
%% ���ӻ����
plotResult(yt, yfit)
%% case2
% �趨��ֵ������Э������Լ���Ȼ����
% ��covSEiso��likGaussΪ��
% meanfunc = [];
% covfunc = @covSEiso; 
% likfunc = @likGauss; 
% % ��������ʼ��
% hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
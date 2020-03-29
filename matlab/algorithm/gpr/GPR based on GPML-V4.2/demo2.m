clc;clear;close all
addpath(genpath(pwd))
%% ����������
load('./data/data_2.mat')
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
hyp = struct('mean', 3, 'cov', [2 2 2], 'lik', -1);
hyp2 = minimize(hyp, @gp, -5, @infGaussLik, meanfunc, covfunc, likfunc,x, y);
[yfit, ys] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc,x, y, xt);
%% ���ӻ����
% ��һ�����
plotResult(yt(:,1), yfit(:,1))
% �ڶ������
plotResult(yt(:,2), yfit(:,2))
%% case2
% �趨��ֵ������Э������Լ���Ȼ����
% ��covSEiso��likGaussΪ��
% meanfunc = [];
% covfunc = @covSEiso; 
% likfunc = @likGauss; 
% % ��������ʼ��
% hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
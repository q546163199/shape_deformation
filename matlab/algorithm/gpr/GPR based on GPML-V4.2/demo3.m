clc;clear;close all
addpath(genpath(pwd))
%%
load('./data/data_3.mat')
%% GPR using gpml-matlab-v4.1
% ��ʼ���������ṹ
meanfunc = []; % empty: don't use a mean function
covfunc = @covSEiso; % Squared Exponental covariance function
likfunc = @likGauss; % Gaussian likelihood
hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
% �Ż��������ṹ
hyp2 = minimize(hyp, @gp, -20, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
% GPR��ģ��ymuΪԤ��ֵ�ľ�ֵ��ysΪԤ��ֵ�ķ��
[ymu, ys] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xt);
%% ���ӻ����
xs = (1:size(xt,1))';
% ����1
% 95%�����Ŷȱ߽磨3��׼��
figure
f1 = [ymu(:,1) + 2*sqrt(ys(:,1)); 
      flip(ymu(:,1) - 2*sqrt(ys(:,1)),1)];
fill([xs; flip(xs,1)], f1, [7 7 7]/8)
hold on
% ʵ������
plot(yt(:,1 ),'r:o','MarkerSize',2)
% Ԥ������
plot(ymu(:,1) ,'b:o','MarkerSize',2)
xlabel('������')
ylabel('��ֵ')
legend('95%���Ŷȱ߽�','ԭʼ����','Ԥ������')
title('����1��Ԥ����')
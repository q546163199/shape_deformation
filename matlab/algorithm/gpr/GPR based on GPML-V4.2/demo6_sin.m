clc;clear;close all
%%
x = (rand(100,1) - 0.5) * 10;
y = sin(x) + 0.1*gpml_randn(0.9, 100, 1);
xt = linspace(-5,5,50)';
yt = sin(xt)';
%% GPR
meanfunc = [];                    % empty: don't use a mean function
covfunc = @covSEiso;              % Squared Exponental covariance function
likfunc = @likGauss;              % Gaussian likelihood
hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
[yfit, ys] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xt);
%%
f = [yfit + 2*sqrt(ys); flip(yfit - 2*sqrt(ys),1)];
fill([xt; flip(xt,1)], f, [7 7 7]/8);hold on
plot(x,y,'o','linewidth',2);hold on
plot(xt,yt,'b-x','linewidth',2);hold on
plot(xt,yfit,'r--*','linewidth',1);
legend('95% confidential','Train data','True f(x)','Mean')
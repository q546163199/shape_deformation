clc;clear;close all
x = gpml_randn(0.8, 30, 1);                 % 20 training inputs
y = sin(3*x) + 0.1*gpml_randn(0.9, 30, 1);  % 20 noisy training targets
xt = linspace(-3, 3, 61)';                  % 61 test inputs 
%%
meanfunc = [];                    % empty: don't use a mean function
covfunc = @covSEiso;              % Squared Exponental covariance function
likfunc = @likGauss;              % Gaussian likelihood
hyp = struct('mean', [], 'cov', [0 0], 'lik', -1);
hyp2 = minimize(hyp, @gp, -100, @infGaussLik, meanfunc, covfunc, likfunc, x, y);
[yfit, ys] = gp(hyp2, @infGaussLik, meanfunc, covfunc, likfunc, x, y, xt);
%%
f = [yfit + 2*sqrt(ys); flip(yfit - 2*sqrt(ys),1)];
fill([xt; flip(xt,1)], f, [7 7 7]/8);hold on
plot(x, y,'+');hold on
plot(xt,yfit)

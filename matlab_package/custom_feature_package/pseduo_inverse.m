clc;clear;close all

a = rand(4,3) * 10;

inva = inv(a'*a)*a' - pinv(a)


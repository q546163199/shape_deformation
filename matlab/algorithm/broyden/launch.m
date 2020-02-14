clc;clear;close all
%%
N = 300;
A = rand(3,4) * 2;
for i=1:N
   xt(i,:) = rand(1,4); 
   yt(i,:) = (A * xt(i,:)')';
end
%%
At = Broyden(xt,yt,0.2,1);
A - At


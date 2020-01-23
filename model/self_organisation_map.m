clc;clear;close all

w = [0.2 0.8;
     0.6 0.4;
     0.5 0.7;
     0.9 0.3];
x = [1 1 0 0;
     0 0 0 1;
     1 0 0 0;
     0 0 1 1];
%%
a = 0.6;
D = zeros(2,1);
for n=1:99
    for k=1:4
        for j=1:2
            for i=1:4
                temp = (x(k,i) - w(i,j))^2;
                D(j) = D(j) + temp;
            end
        end
        [~,index] = min(D);
        D = zeros(2,1);
        for i=1:4
            w(i,index) = w(i,index) + a*(x(k,i) - w(i,index));
        end     
    end
    a = a/2;  
end 
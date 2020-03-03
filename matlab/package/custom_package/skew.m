function y = skew(x)

if isrow(x) || iscolumn(x)
    if size(x) ~= 3
        fprintf('Input wrong vectors, please try again\n')
        return
    end
else
    fprintf('Input wrong vectors, please try again\n')
    return
end

x1 = x(1);
x2 = x(2);
x3 = x(3);

y = [0 -x3 x2;
     x3 0 -x1;
     -x2 x1 0];
end
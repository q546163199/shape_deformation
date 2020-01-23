function y = sigmoid(x,condition)

switch condition
    case 1
        y = 1./(1+exp(-x));
    case 2
        y = (1-exp(-x))./(1+exp(-x));
end

end
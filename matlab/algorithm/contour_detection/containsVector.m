function y = containsVector(small,big)

l1 = length(small);
l2 = length(big);

 

y = 0;
for i = 1:(l2 - l1 + 1)
    if big(i:i + l1-1) == small
        y = 1;
        break;
    end
end
end


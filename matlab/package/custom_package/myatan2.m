function y = myatan2(sin,cos)

if sin>0 && cos>0
    y = atand(abs(sin/cos));
elseif sin>0 && cos<0
    y = 180 - atand(abs(sin/cos));
elseif sin<0 && cos<0
    y = 180 + atand(abs(sin/cos));
    y = y - 360;
elseif sin<0 && cos>0
    y = -atand(abs(sin/cos));
end

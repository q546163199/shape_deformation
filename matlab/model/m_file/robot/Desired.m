function [qd,dqd,ddqd] = Desired(t)

qd = [sin(t);
      cos(t)];

dqd = [cos(t);
       -sin(t)];

ddqd = [-sin(t);
        -cos(t)];
end
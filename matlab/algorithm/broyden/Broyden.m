function [At,dx,dy] = Broyden(x,y,gamma,choice)
%% 
N = size(x,1);
%%
dx = diff(x);
dx = [zeros(1,size(x,2)) + 0.01;dx];
dy = diff(y);
dy = [zeros(1,size(y,2)) + 0.01;dy];
At0 = rand(size(y,2),size(x,2));
%%
switch choice
    case 1
        %% R1       
        for i=1:N
            At = At0 + gamma * (dy(i,:)' - At0 * dx(i,:)') * dx(i,:)/(dx(i,:) * dx(i,:)');
            At0 = At;
        end
    case 2
        %% SR1
        for i=1:N
            At = At0 + (dy(i,:)' - At0 * dx(i,:)') * (dy(i,:)' - At0 * dx(i,:)')' *...
                 pinv(dx(i,:)' * (dy(i,:)' - At0 * dx(i,:)')');
            At0 = At;
        end
    case 3
        %% BFGS
        for i=1:N
            At = At0 - At0 * dx(i,:)' * dx(i,:) * At0' * pinv(dx(i,:)' * dx(i,:) * At0') + dy(i,:)' * dy(i,:) * pinv(dx(i,:)' * dy(i,:));
            At0 = At;
        end
    case 4
        %% DFP
        for i=1:N
            At = At0 + ((dy(i,:)' - At0 * dx(i,:)')*dy(i,:) + dy(i,:)' * (dy(i,:)' - At0 * dx(i,:)')') * pinv(dx(i,:)' * dy(i,:))...
                 - ((dy(i,:)' - At0 * dx(i,:)') * dx(i,:)) * (dy(i,:) * dy(i,:)') / (norm(dx(i,:)' * dy(i,:)) + 0.01);
            At0 = At;
        end
    case 5
        %% PSB
        for i=1:N
            At = At0 + ((dy(i,:)' - At0 * dx(i,:)')*dx(i,:) * 1) / (dx(i,:) * dx(i,:)')...
                - ((dy(i,:)' - At0 * dx(i,:)') * dx(i,:) * dx(i,:)' * dx(i,:)) / (dx(i,:) * dx(i,:)');
            At0 = At;
        end
        
end
end
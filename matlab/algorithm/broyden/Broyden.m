function [At,ut,dt] = Broyden(xt,yt,gamma,choice)
%% 
N = size(xt,1);
%%
ut = diff(xt);
ut = [zeros(1,size(xt,2)) + 0.01;ut];
dt = diff(yt);
dt = [zeros(1,size(yt,2)) + 0.01;dt];
At0 = rand(size(yt,2),size(xt,2));
%%
switch choice
    case 1
        %% NORMAL       
        for i=1:N
            At = At0 + gamma * (dt(i,:)' - At0 * ut(i,:)') * ut(i,:)/(ut(i,:) * ut(i,:)');
            At0 = At;
        end
    case 2
        %% SR1
        for i=1:N
            At = At0 + (dt(i,:)' - At0 * ut(i,:)') * (dt(i,:)' - At0 * ut(i,:)')' *...
                 pinv(ut(i,:)' * (dt(i,:)' - At0 * ut(i,:)')');
            At0 = At;
        end
    case 3
        %% BFGS
        for i=1:N
            At = At0 - At0 * ut(i,:)' * ut(i,:) * At0' * pinv(ut(i,:)' * ut(i,:) * At0') + dt(i,:)' * dt(i,:) * pinv(ut(i,:)' * dt(i,:));
            At0 = At;
        end
    case 4
        %% DFP
        for i=1:N
            At = At0 + ((dt(i,:)' - At0 * ut(i,:)')*dt(i,:) + dt(i,:)' * (dt(i,:)' - At0 * ut(i,:)')') * pinv(ut(i,:)' * dt(i,:))...
                 - ((dt(i,:)' - At0 * ut(i,:)') * ut(i,:)) * (dt(i,:) * dt(i,:)') / norm(ut(i,:)' * dt(i,:));
        end
    case 5
        %% PSB
        for i=1:N
            At = At0 + ((dt(i,:)' - At0 * ut(i,:)')*ut(i,:) * 2) / (ut(i,:) * ut(i,:)')...
                - ((dt(i,:)' - At0 * ut(i,:)') * ut(i,:) * ut(i,:)' * ut(i,:)) / (ut(i,:) * ut(i,:)');
        end
        
end
end
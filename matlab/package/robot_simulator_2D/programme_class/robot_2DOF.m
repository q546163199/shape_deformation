classdef robot_2DOF
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        link1_length;
        link2_length;
        biasx;
        biasy;
        elbow_case; %up = 1 and down = 2
    end
    
    methods
        function obj = robot_2DOF(link1,link2,biasx,biasy,elbow_case)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.link1_length = link1;
            obj.link2_length = link2;
            obj.biasx = biasx;
            obj.biasy = biasy;
            obj.elbow_case = elbow_case;
        end
    
        function [p1,p2] = fkine(obj,q)
           %% initial parameter
            l1 = obj.link1_length;
            l2 = obj.link2_length;
            q1 = q(1);
            q2 = q(2);
            bias.x = obj.biasx;
            bias.y = obj.biasy;
           %%
            p1.x = l1 * cos(q1) + bias.x;
            p1.y = l1 * sin(q1) + bias.y;
            p2.x = l1 * cos(q1) + l2 * cos(q1 + q2) + bias.x;
            p2.y = l1 * sin(q1) + l2 * sin(q1 + q2) + bias.y;
        end
        
        function isField = isField(obj,p2)
           %% initial parameter
            l1 = obj.link1_length;
            l2 = obj.link2_length;
            bias.x = obj.biasx;
            bias.y = obj.biasy;
           %%
            x = p2.x - bias.x;
            y = p2.y - bias.y;
            judge = (x^2 + y^2 -l1^2 -l2^2)/(2*l1*l2);
            if abs(judge) > 1
                isField = false;
            else
                isField = true;
            end
        end
        
        function q = ikine(obj,p2)
           %% initial parameter
            l1 = obj.link1_length;
            l2 = obj.link2_length;
            bias.x = obj.biasx;
            bias.y = obj.biasy;
           %%
            x = p2.x - bias.x;
            y = p2.y - bias.y;
            isField = obj.isField(p2);
            if ~isField
                q = [];
                fprintf('The position is not in the workspace, pleast try it again\n')
                return;
            end 
      
           %%
            c2 = (x^2 + y^2 -l1^2 -l2^2)/(2*l1*l2);
            switch obj.elbow_case
                case 1
                    s2 = -sqrt(1-c2^2);
                case 2
                    s2 = sqrt(1-c2^2);
            end
            q2 = atan2(s2,c2);
            k1 = l1 + l2 * c2;
            k2 = l2 * s2;
            q1 = atan2(y,x) - atan2(k2,k1);
            q = [q1;q2];       
        end
        
        function handle = plot(obj,q)
           %% initial parameter
            l1 = obj.link1_length;
            l2 = obj.link2_length;
            bias.x = obj.biasx;
            bias.y = obj.biasy;
           %%
           [p1,p2] = obj.fkine(q);
           %% plot figure
           handle = plot([bias.x p1.x p2.x],[bias.y p1.y p2.y],'k-*','linewidth',2);
           %% axis limitation
           axis_limit = l1 + l2 + max(bias.x,bias.y);
           axis([-0.2 axis_limit -0.2 axis_limit])
           daspect([1 1 1])
        end
        
        function circle(obj,radius,bias)
            n = 100;
            theta = linspace(0,2*pi,n);
            for i=1:n
                traj(i,1) = radius * cos(theta(i)) + bias.x;
                traj(i,2) = radius * sin(theta(i)) + bias.y;
            end
            plot(traj(:,1),traj(:,2),'--','linewidth',2)
        end
        
        function handle = rectangle(obj,p1x,p1y,p2x,p2y)
            %%
            % ---------- p2
            % |          |
            % |          |
            %p1 ---------
            %%
            p1.x = p1x;p1.y = p1y;p2.x = p2x;p2.y = p2y;
            %%
            handle = plot([p1.x p2.x p2.x p1.x p1.x],[p1.y p1.y p2.y p2.y p1.y],'k-','linewidth',2);
        end
        
        function handle = workspace(obj)
            maxlength = obj.link1_length + obj.link2_length + sqrt(obj.biasx^2 + obj.biasy^2);
            N = 200;
            theta = linspace(0,2*pi,N);
            for i=1:N
                x(i) = maxlength * cos(theta(i));
                y(i) = maxlength * sin(theta(i));
            end
            handle = plot(x,y,'--b','linewidth',2);
        end
        
    end
end


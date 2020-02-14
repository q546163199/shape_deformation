classdef robot_6DOF
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        biasx;
        biasy;
        biasz;
        d1 =  89.2/250;
        d4 = 109.3/250;
        d5 = 94.75/250;
        d6 =  82.5/250;
        a2 =  -425/250;
        a3 =  -392/250;
        alpha1 = pi/2;
        alpha4 = pi/2;
        alpha5 = -pi/2;
    end
    
    methods
        function obj = robot_6DOF(biasx,biasy,biasz)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj.biasx = biasx;
            obj.biasy = biasy;
            obj.biasz = biasz;
        end
    
        function [T6,T5,T4,T3,T2,T1,T0] = fkine(obj,q)
           %% initial parameter
            q1 = q(1);q2 = q(2);q3 = q(3);q4 = q(4);q5 = q(5);q6 = q(6);          
            bias.x = obj.biasx;
            bias.y = obj.biasy;
            bias.z = obj.biasz;
           %%
            A0 = [1 0 0 bias.x;
                  0 1 0 bias.y;
                  0 0 1 bias.z;
                  0 0 0 1];
            A1 = [cos(q1) 0  sin(q1) 0;
                  sin(q1) 0 -cos(q1) 0;
                  0       1        0 obj.d1;
                  0       0        0 1];
            A2 = [cos(q2) -sin(q2) 0 obj.a2*cos(q2);
                  sin(q2)  cos(q2) 0 obj.a2*sin(q2);
                  0        0       1 0;
                  0        0       0 1];
            A3 = [cos(q3) -sin(q3) 0 obj.a3*cos(q3);
                  sin(q3)  cos(q3) 0 obj.a3*sin(q3);
                  0        0       1 0;
                  0        0       0 1];
            A4 = [cos(q4) 0  sin(q4) 0;
                  sin(q4) 0 -cos(q4) 0;
                  0       1  0       obj.d4;
                  0       0  0       1];
            A5 = [cos(q5) 0 -sin(q5) 0;
                  sin(q5) 0  cos(q5) 0;
                  0      -1  0       obj.d5;
                  0       0  0       1];
            A6 = [cos(q6) -sin(q6) 0 0;
                  sin(q6)  cos(q6) 0 0;
                  0        0       1 obj.d6;
                  0        0       0 1];
            T6 = A0*A1*A2*A3*A4*A5*A6;
            T5 = A0*A1*A2*A3*A4*A5;
            T4 = A0*A1*A2*A3*A4;
            T3 = A0*A1*A2*A3;
            T2 = A0*A1*A2;
            T1 = A0*A1;
            T0 = A0; 
        end
            
        function q = ikine(obj,T)
            a = [0,obj.a2,obj.a3,0,0,0];
            d = [obj.d1,0,0,obj.d4,obj.d5,obj.d6];
            alpha = [pi/2,0,0,pi/2,-pi/2,0];
            nx = T(1,1);ny = T(2,1);nz = T(3,1);
            ox = T(1,2);oy = T(2,2);oz = T(3,2);
            ax = T(1,3);ay = T(2,3);az = T(3,3);
            px = T(1,4) - obj.biasx;
            py = T(2,4) - obj.biasy;
            pz = T(3,4) - obj.biasz;
    
            %求解关节角1
            m = d(6)*ay-py;  
            n = ax*d(6)-px; 
            theta1(1,1) = atan2(m,n)-atan2(d(4),sqrt(m^2+n^2-(d(4))^2));
            theta1(1,2) = atan2(m,n)-atan2(d(4),-sqrt(m^2+n^2-(d(4))^2));
  
            %求解关节角5
            theta5(1,1:2) = acos(ax*sin(theta1)-ay*cos(theta1));
            theta5(2,1:2) = -acos(ax*sin(theta1)-ay*cos(theta1));      

            %求解关节角6
            mm = nx*sin(theta1)-ny*cos(theta1); 
            nn = ox*sin(theta1)-oy*cos(theta1);
            theta6 = atan2(mm,nn)-atan2(sin(theta5),0);

            %求解关节角3
            mmm = d(5)*(sin(theta6).*(nx*cos(theta1)+ny*sin(theta1))+cos(theta6).*(ox*cos(theta1)+oy*sin(theta1))) ...
                  -d(6)*(ax*cos(theta1)+ay*sin(theta1))+px*cos(theta1)+py*sin(theta1);
            nnn = pz-d(1)-az*d(6)+d(5)*(oz*cos(theta6)+nz*sin(theta6));
            theta3(1:2,:) =  acos((mmm.^2+nnn.^2-(a(2))^2-(a(3))^2)/(2*a(2)*a(3)));
            theta3(3:4,:) = -acos((mmm.^2+nnn.^2-(a(2))^2-(a(3))^2)/(2*a(2)*a(3)));

            %求解关节角2
            mmm_s2(1:2,:) = mmm;
            mmm_s2(3:4,:) = mmm;
            nnn_s2(1:2,:) = nnn;
            nnn_s2(3:4,:) = nnn;
            s2 = ((a(3)*cos(theta3)+a(2)).*nnn_s2-a(3)*sin(theta3).*mmm_s2)./ ...
                ((a(2))^2+(a(3))^2+2*a(2)*a(3)*cos(theta3));
            c2 = (mmm_s2+a(3)*sin(theta3).*s2)./(a(3)*cos(theta3)+a(2));
            theta2 = atan2(s2,c2);   
    
            %整理关节角1 5 6 3 2
            theta(1:4,1) = theta1(1,1);theta(5:8,1)=theta1(1,2);
            theta(:,2) = [theta2(1,1),theta2(3,1),theta2(2,1),theta2(4,1),theta2(1,2),theta2(3,2),theta2(2,2),theta2(4,2)]';
            theta(:,3) = [theta3(1,1),theta3(3,1),theta3(2,1),theta3(4,1),theta3(1,2),theta3(3,2),theta3(2,2),theta3(4,2)]';
            theta(1:2,5) = theta5(1,1);theta(3:4,5)=theta5(2,1);
            theta(5:6,5) = theta5(1,2);theta(7:8,5)=theta5(2,2);
            theta(1:2,6) = theta6(1,1);theta(3:4,6)=theta6(2,1);
            theta(5:6,6) = theta6(1,2);theta(7:8,6)=theta6(2,2); 
    
            %求解关节角4
            theta(:,4) = atan2(-sin(theta(:,6)).*(nx*cos(theta(:,1))+ny*sin(theta(:,1)))-cos(theta(:,6)).* ...
                        (ox*cos(theta(:,1))+oy*sin(theta(:,1))),oz*cos(theta(:,6))+nz*sin(theta(:,6)))-theta(:,2)-theta(:,3);  
            q = theta;
        end
        
        function handle = plot(obj,q)
        %% initial parameter
            [T6,T5,T4,T3,T2,T1,T0] = fkine(obj,q);
           %% plot figure
            handle = plot3([T0(1,4) T1(1,4) T2(1,4) T3(1,4) T4(1,4) T5(1,4) T6(1,4)],...
                           [T0(2,4) T1(2,4) T2(2,4) T3(2,4) T4(2,4) T5(2,4) T6(2,4)],...
                           [T0(3,4) T1(3,4) T2(3,4) T3(3,4) T4(3,4) T5(3,4) T6(3,4)],'k-*','linewidth',2);
%             xlabel('x','fontsize',15)
%             ylabel('y','fontsize',15)
%             zlabel('z','fontsize',15)
           %% axis limitation
            axis([-5 5 -5 5 -5 5])
%             axis([0 5 0 5 0 5])
            daspect([1 1 1])
        end
        
        function [traj,handle] = circle(obj,r)
            bias.x = obj.biasx;
            bias.y = obj.biasy;
            bias.z = obj.biasz;
            N = 10;
            theta = linspace(0,pi,N);
            phi = linspace(0,2*pi,N);
            for i=1:N
                for j=1:N
                    x(N*(i-1) + j) = r * sin(theta(i))*cos(phi(j)) + bias.x;
                    y(N*(i-1) + j) = r * sin(theta(i))*sin(phi(j)) + bias.y;
                    z(N*(i-1) + j) = r * cos(theta(i)) + bias.z;
                    traj(N*(i-1) + j,:) = [x(N*(i-1) + j) y(N*(i-1) + j) z(N*(i-1) + j)];
                end
            end
            handle = plot3(x,y,z,'k*','linewidth',1);
        end
        
        function [qt,qdt,qddt] = jtraj(obj, q0, q1, tv, qd0, qd1)
            if length(tv) > 1
                tscal = max(tv);
                t = tv(:)/tscal;
            else
                tscal = 1;
                t = (0:(tv-1))'/(tv-1); % normalized time from 0 -> 1
            end

            q0 = q0(:);
            q1 = q1(:);

            if nargin == 4
                qd0 = zeros(size(q0));
                qd1 = qd0;
            elseif nargin == 6
                qd0 = qd0(:);
                qd1 = qd1(:);
            else
                error('incorrect number of arguments')
            end

            % compute the polynomial coefficients
            A = 6*(q1 - q0) - 3*(qd1+qd0)*tscal;
            B = -15*(q1 - q0) + (8*qd0 + 7*qd1)*tscal;
            C = 10*(q1 - q0) - (6*qd0 + 4*qd1)*tscal;
            E = qd0*tscal; % as the t vector has been normalized
            F = q0;

            tt = [t.^5 t.^4 t.^3 t.^2 t ones(size(t))];
            c = [A B C zeros(size(A)) E F]';

            qt = tt*c;

            % compute optional velocity
            if nargout >= 2
                c = [ zeros(size(A)) 5*A 4*B 3*C  zeros(size(A)) E ]';
                qdt = tt*c/tscal;
            end

            % compute optional acceleration
            if nargout == 3
                c = [ zeros(size(A))  zeros(size(A)) 20*A 12*B 6*C  zeros(size(A))]';
                qddt = tt*c/tscal^2;
            end
        end
        
    end
end


clc;clear;
%%----------------------------------------------------------------------%
global Para;

%% Constants & Parameters

Para.GM = 398600440000000;                                                 %% m^3/s^2
T_s = 0.05;                                                                %% Sample Time
tf  = 6500;                                                                %% Maximum Time
Final_distance = 3;                                                        %% Final Distance (when the relative disatance smaller than Final_distance, simulation will be stopped) 

Time = [];
Rm   = [];
Rt   = [];
Rsi  = [];
Km   = [];
Ac   = [];
Cost = [];
Err  = [];
X    = [];
Y    = [];


%% Step 1: Initial Conditions

Para.N = 2.5;                                                              %% Define Navigation Ratio

Para.M_r =  0.00000015;                                                    %% Velocity Control Gains
Para.M_v =  0.00044190;

InitialCondition = 2;                                                      %% Select Initial Position: 1 Robot-1£¬2 Robot-2£¬3 Robot-3, 4 Robot-4

switch InitialCondition
    case 1
        r_m_0 = [6.8706e6;7.1952e4];                                       %% Initial Robot Postion, (Robot-1)
        v_m_0 = [-79.76;7616.15];                                          %% Initial Robot Velocity, (Robot-1)
    case 2
        r_m_0 = [6.8706e6;-7.1952e4];                                      %% Initial Robot Postion, (Robot-2)
        v_m_0 = [79.76;7616.15];                                           %% Initial Robot Velocity, (Robot-2)
    case 3
        r_m_0 = [6.8090e6;-7.1307e4];                                      %% Initial Robot Postion, (Robot-3)
        v_m_0 = [80.12;7650.52];                                           %% Initial Robot Velocity, (Robot-3)
    case 4
        r_m_0 = [6.8090e6;7.1307e4];                                       %% Initial Robot Postion, (Robot-4)
        v_m_0 = [-80.12;7650.52];                                          %% Initial Robot Velocity, (Robot-4)
end

r_t_0   = [6.8402e6;0];                                                    %% Initial Target Postion     
v_t_0   = [0;7633.69];                                                     %% Initial Target Velocity

r_0     = r_t_0 - r_m_0;                                                   %% Initial LOS
v_0     = v_t_0 - v_m_0;
omega   = sqrt(Para.GM/norm(r_t_0)^3);

cost    = 0;
X_0     = [r_0;v_0;r_m_0;v_m_0;cost];

%% Step 2: Intercept

t  = 0;
km = 0;
ac = 0;

for i = 1:(1/T_s)*tf
    
    if norm(r_0) >= Final_distance; 
        
    t = i*T_s;
        
    RVM  = EOM_RagOrbitDyCon(X_0);
    r_0   = r_0   + T_s*RVM(1:2);
    v_0   = v_0   + T_s*RVM(3:4);
    r_m_0 = r_m_0 + T_s*RVM(5:6);
    v_m_0 = v_m_0 + T_s*RVM(7:8);
    cost  = cost  + T_s*RVM(9); 
    km    = RVM(10);
    ac    = RVM(11);
    X_0   = [r_0;v_0;r_m_0;v_m_0;cost];

    r_t_0 = r_0 + r_m_0;
    v_t_0 = v_0 + v_m_0;

    DX  = r_m_0(1) - r_t_0(1);
    DY  = r_m_0(2) - r_t_0(2);
    xx = cos(omega*t)*DX  + sin(omega*t)*DY;
    yy = -sin(omega*t)*DX + cos(omega*t)*DY;
    
    Time(i,:) = t;
    Rt(i,:)   = r_t_0;
    Rm(i,:)   = r_m_0;
    Rsi(i,:)  = norm(r_0);
    Km(i,:)   = km;
    Ac(i,:)   = ac;
    Cost(i,:) = cost;
    Err(i,:)  = norm(v_t_0 - v_m_0);
    X(i,:)    = xx;
    Y(i,:)    = yy;
    
    else
        break
    end
end

tf   = Time(end)
cost = Cost(end)
velocity_error = Err(end)

%% save and plot

save caseDG.mat Rt Rm Rsi Km Ac Cost Err X Y Time
   
figure('position',[600 100 600 400]); 
plot(Rt(:,1),Rt(:,2),'r','Linewidth',1.5);
hold on;
plot(Rm(:,1),Rm(:,2),'b','Linewidth',1.5);
legend('Target','Robot');
xlabel('Y/m');
ylabel('X/m');

figure('position',[600 100 600 400]); 
plot(Time,Cost,'b','Linewidth',1.5);
ylabel('Cost','fontsize',12,'fontname','Times New Roman');
xlabel('t/s','fontsize',12,'fontname','Times New Roman');

figure('position',[600 100 600 400]); 
plot(Time,Rsi,'b','Linewidth',1.5);
ylabel('r_s_i/m','fontsize',12,'fontname','Times New Roman');
xlabel('t/s','fontsize',12,'fontname','Times New Roman');

figure('position',[600 100 600 400]); 
plot(Time,Km,'b','Linewidth',1.5);
ylabel('k_m','fontsize',12,'fontname','Times New Roman');
xlabel('t/s','fontsize',12,'fontname','Times New Roman');

figure('position',[600 100 600 400]); 
plot(Time,Ac,'b','Linewidth',1.5);
ylabel('a_c/ m/s^2','fontsize',12,'fontname','Times New Roman');
xlabel('t/s','fontsize',12,'fontname','Times New Roman');

figure('position',[600 100 600 400]); 
plot(Time,Err,'b','Linewidth',1.5);
ylabel('Velocity error / m/s^-^1','fontsize',12,'fontname','Times New Roman');
xlabel('t/s','fontsize',12,'fontname','Times New Roman');

figure('position',[600 100 600 400]); 
plot(Y,X,'b','Linewidth',1.5);
xlabel('Y_t/m');
ylabel('X_t/m');

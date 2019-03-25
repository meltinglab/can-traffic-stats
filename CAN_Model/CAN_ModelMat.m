clc
clear

%Simulation Settings
FrameLenght = 110;
SimTime = 0.2;       % [s]
CLK = 0.000002;      % F = 500 [KHz]

%CanNode_Sender Timing Setting
NodeTiming = 0.01;   % [s]
timingCanNode_Sender = NodeTiming / CLK;  %[numOfCLKCycles / NodeReadyToSend]

%%
%%%% USER INTERFACE %%%%%%%%%%%%%%%%
% run('Interface.m')
% 
% ID = IDTx;
% ID_Rx = matrix(1,:);
% 
% NodesID = matrix(2:end, :);
%%
%%%% SCRIPT %%%%%%%%%%%%%%%%%%%%%%%%
ID =    [1,1,1,1,1,0,0,1,1,1,1];
ID_Rx = [1,1,1,1,0,0,1,1,1,1,1];

NodesID = [ 0,0,1,1,0,1,1,0,0,1,1
    0,0,1,1,0,1,1,0,0,1,0
    0,0,1,0,0,1,1,0,1,1,0
    0,0,1,1,1,1,1,0,0,1,0
    1,1,0,1,1,1,1,1,1,1,0
    1,1,0,1,1,1,1,1,1,0,1
    1,1,0,1,1,1,1,1,0,1,1
    1,1,0,1,1,1,1,0,1,1,1
    1,1,0,1,1,1,0,1,1,1,1
    1,1,0,1,1,1,0,1,1,1,0
    0,0,0,0,1,0,1,0,1,0,1
    1,1,0,1,1,1,1,0,0,0,1
    0,0,0,0,0,0,1,1,1,1,1
    0,0,0,0,0,0,0,1,1,1,1
    0,0,0,0,0,0,0,0,0,1,1
    0,0,0,0,0,0,0,0,0,1,1
    0,0,0,0,0,0,0,0,0,1,0
    0,0,0,0,0,0,1,1,1,1,1];
%%
% Timing Analysis
NumOfFrame_Max = SimTime / (CLK * FrameLenght);
BusLoadRespTime = [0, 10, 20, 30, 40, 50, 55, 60, 65, 70, 75, 80, 85, 90];

for i = 1 : length(BusLoadRespTime)
    NumOfFrames = BusLoadRespTime(i) / 100 * NumOfFrame_Max;
    RTS_Inc = round(SimTime / CLK / NumOfFrames);
    sim('CAN_Model_v8.slx');
    RespTime(i, :) = delayCounter(TxTimings, RxTimings, CLK);
    maxRespTime(i,:) = max(RespTime(i, :));
    minRespTime(i,:) = min(RespTime(i, :));
    meanRespTime(i,:) = mean(RespTime(i, :));
    
    Delay(i,:) = delayCounter(RTS_rising, RTS_falling, CLK);
    maxDelay(i,:) = max(Delay(i, :));
    minDelay(i,:) = min(Delay(i, :));
    meanDelay(i,:) = mean(Delay(i, :));
    
    jitterMatrix(i,:) = jitterCounter(TxTimings, CLK);
end

%%%%%%%%%%%PLOT%%%%%%
figure(1);
plot(BusLoadRespTime, meanRespTime)
title('Mean Response Time')
xlabel('Bus Load [%]')
ylabel('RespTime [s]')

figure(2);
plot(BusLoadRespTime, meanDelay)
title('Mean Delay')
xlabel('Bus Load [%]')
ylabel('RespTime [s]')



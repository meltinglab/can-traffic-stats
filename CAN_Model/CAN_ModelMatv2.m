
clc
clear

FrameLenght = 110;
SimTime = 0.2;
CLK = 0.000002;

NodeTiming = 0.01;
time = NodeTiming / CLK;

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
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
% Con questa config dopo l'85% Bus Load non si ha più risposta!% 
% ID =    [1,1,1,1,1,1,1,1,1,0,0];
% ID_Rx = [1,1,1,1,1,1,1,1,0,0,1];
% BusLoadV = [50, 55, 60, 80, 85, 90, 95];                     %
% Molto bella la Media
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
%           [ 0,0,1,1,0,1,1,0,0,1,1
%             0,0,1,1,0,1,1,0,0,1,0
%             0,0,1,0,0,1,1,0,1,1,0
%             0,0,1,1,1,1,1,0,0,1,0
%             1,1,0,1,1,1,1,1,1,1,0
%             1,1,0,1,1,1,1,1,1,0,1
%             1,1,0,1,1,1,1,1,0,1,1
%             1,1,0,1,1,1,1,0,1,1,1
%             1,1,0,1,1,1,0,1,1,1,1
%             1,1,0,1,1,1,0,1,1,1,0
%             0,0,0,0,1,0,1,0,1,0,1
%             1,1,0,1,1,1,1,0,0,0,1
%             0,0,0,0,0,0,1,1,1,1,1
%             0,0,0,0,0,0,0,1,1,1,1
%             0,0,0,0,0,0,0,0,0,1,1
%             0,0,0,0,0,0,0,0,0,1,1
%             0,0,0,0,0,0,0,0,0,1,0
%             0,0,0,0,0,0,1,1,1,1,1]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


%         [ 0,0,1,1,0,1,1,0,0,1,1
%             0,0,1,1,0,1,1,0,0,1,0
%             0,0,1,0,0,1,1,0,1,1,0
%             0,0,1,1,1,1,1,0,0,1,0
%             1,1,1,1,1,1,1,1,1,1,0
%             1,1,1,1,1,1,1,1,1,0,1
%             1,1,1,1,1,1,1,1,0,1,1
%             1,1,1,1,1,1,1,0,1,1,1
%             1,1,1,1,1,1,0,1,1,1,1
%             1,1,1,1,1,1,0,1,1,1,0
%             0,0,0,0,1,0,1,0,1,0,1
%             1,1,1,1,1,1,1,0,0,0,1
%             0,0,0,0,0,0,1,1,1,1,1
%             0,0,0,0,0,0,0,1,1,1,1
%             0,0,0,0,0,0,0,0,0,1,1
%             0,0,0,0,0,0,0,0,0,1,1
%             0,0,0,0,0,0,0,0,0,1,0
%             0,0,0,0,0,0,1,1,1,1,1]


NumOfFrame_Max = SimTime / (CLK * FrameLenght);

BusLoadInserted = 50;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res1 = delayCounter(TxTimings, RxTimings, CLK);
Del1 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(1) = max(Del1);
minV(1) = min(Del1);
meanV(1) = mean(Del1);

BusLoadInserted = 55;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res2 = delayCounter(TxTimings, RxTimings, CLK);
Del2 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(2) = max(Del2);
minV(2) = min(Del2);
meanV(2) = mean(Del2);

BusLoadInserted = 60;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res3 = delayCounter(TxTimings, RxTimings, CLK);
Del3 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(3) = max(Del3);
minV(3) = min(Del3);
meanV(3) = mean(Del3);

BusLoadInserted = 65;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res4 = delayCounter(TxTimings, RxTimings, CLK);
Del4 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(4) = max(Del4);
minV(4) = min(Del4);
meanV(4) = mean(Del4);

BusLoadInserted = 70;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res5 = delayCounter(TxTimings, RxTimings, CLK);
Del5 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(5) = max(Del5);
minV(5) = min(Del5);
meanV(5) = mean(Del5);

BusLoadInserted = 75;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res6 = delayCounter(TxTimings, RxTimings, CLK);
Del6 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(6) = max(Del6);
minV(6) = min(Del6);
meanV(6) = mean(Del6);

BusLoadInserted = 80;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res7 = delayCounter(TxTimings, RxTimings, CLK);
Del7 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(7) = max(Del7);
minV(7) = min(Del7);
meanV(7) = mean(Del7);

BusLoadInserted = 85;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res8 = delayCounter(TxTimings, RxTimings, CLK);
Del8 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(8) = max(Del8);
minV(8) = min(Del8);
meanV(8) = mean(Del8);

BusLoadInserted = 90;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v9.slx');
Res9 = delayCounter(TxTimings, RxTimings, CLK);
Del9 = delayCounter(RTS_rising, RTS_falling, CLK);
maxV(9) = max(Del9);
minV(9) = min(Del9);
meanV(9) = mean(Del9);

% BusLoadInserted = 95;
% NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
% RTS_Inc = round(SimTime / CLK / NumOfFrames);
% sim('CAN_Model_v9.slx');
% Res10 = delayCounter(TxTimings, RxTimings, CLK);
% Del10 = delayCounter(RTS_rising, RTS_falling, CLK);
% maxV(10) = max(Del10);
% minV(10) = min(Del10);
% meanV(10) = mean(Del10);
% 
% BusLoadInserted = 100;
% NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
% RTS_Inc = round(SimTime / CLK / NumOfFrames);
% sim('CAN_Model_v9.slx');
% Res11 = delayCounter(TxTimings, RxTimings, CLK);
% Del11 = delayCounter(RTS_rising, RTS_falling, CLK);
% maxV(11) = max(Del11);
% minV(11) = min(Del11);
% meanV(11) = mean(Del11);

%%%%%%%%%%%PLOT%%%%%%
BusLoadV = [50, 55, 60, 65, 70, 75, 80, 85, 90];
figure(1);
plot(BusLoadV, maxV)
figure(2);
plot(BusLoadV, minV)
figure(3);
plot(BusLoadV, meanV)




clc
clear

FrameLenght = 110;
SimTime = 0.2;
CLK = 0.000002;

NodeTiming = 0.01;
time = NodeTiming / CLK;

ID =    [0,0,0,0,0,0,0,0,0,0,0];
ID_Rx = [0,0,0,0,0,0,0,0,0,0,1];

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
sim('CAN_Model_v8.slx');
Res1 = delayCounter(TxTimings, RxTimings, CLK);
maxV(1) = max(Res1);
minV(1) = min(Res1);
meanV(1) = mean(Res1);

BusLoadInserted = 55;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res2 = delayCounter(TxTimings, RxTimings, CLK);
maxV(2) = max(Res2);
minV(2) = min(Res2);
meanV(2) = mean(Res2);

BusLoadInserted = 60;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res3 = delayCounter(TxTimings, RxTimings, CLK);
maxV(3) = max(Res3);
minV(3) = min(Res3);
meanV(3) = mean(Res3);

BusLoadInserted = 80;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res4 = delayCounter(TxTimings, RxTimings, CLK);
maxV(4) = max(Res4);
minV(4) = min(Res4);
meanV(4) = mean(Res4);

BusLoadInserted = 85;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res5 = delayCounter(TxTimings, RxTimings, CLK);
maxV(5) = max(Res5);
minV(5) = min(Res5);
meanV(5) = mean(Res5);

BusLoadInserted = 90;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res6 = delayCounter(TxTimings, RxTimings, CLK);
maxV(6) = max(Res6);
minV(6) = min(Res6);
meanV(6) = mean(Res6);

usLoadInserted = 95;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res7 = delayCounter(TxTimings, RxTimings, CLK);
maxV(7) = max(Res7);
minV(7) = min(Res7);
meanV(7) = mean(Res7);

%%%%%%%%%%%PLOT%%%%%%
BusLoadV = [50, 55, 60, 80, 85, 90, 95];
figure(1);
plot(BusLoadV, maxV)
figure(2);
plot(BusLoadV, minV)
figure(3);
plot(BusLoadV, meanV)



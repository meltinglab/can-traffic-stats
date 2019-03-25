
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

BusLoadInserted = 65;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res4 = delayCounter(TxTimings, RxTimings, CLK);
maxV(4) = max(Res4);
minV(4) = min(Res4);
meanV(4) = mean(Res4);

BusLoadInserted = 70;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res5 = delayCounter(TxTimings, RxTimings, CLK);
maxV(5) = max(Res5);
minV(5) = min(Res5);
meanV(5) = mean(Res5);

BusLoadInserted = 75;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res6 = delayCounter(TxTimings, RxTimings, CLK);
maxV(6) = max(Res6);
minV(6) = min(Res6);
meanV(6) = mean(Res6);

BusLoadInserted = 80;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res7 = delayCounter(TxTimings, RxTimings, CLK);
maxV(7) = max(Res7);
minV(7) = min(Res7);
meanV(7) = mean(Res7);

BusLoadInserted = 85;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res8 = delayCounter(TxTimings, RxTimings, CLK);
maxV(8) = max(Res8);
minV(8) = min(Res8);
meanV(8) = mean(Res8);

BusLoadInserted = 90;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res9 = delayCounter(TxTimings, RxTimings, CLK);
maxV(9) = max(Res9);
minV(9) = min(Res9);
meanV(9) = mean(Res9);

BusLoadInserted = 95;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res10 = delayCounter(TxTimings, RxTimings, CLK);
maxV(10) = max(Res10);
minV(10) = min(Res10);
meanV(10) = mean(Res10);

BusLoadInserted = 100;
NumOfFrames = BusLoadInserted / 100 * NumOfFrame_Max;
RTS_Inc = round(SimTime / CLK / NumOfFrames);
sim('CAN_Model_v8.slx');
Res11 = delayCounter(TxTimings, RxTimings, CLK);
maxV(11) = max(Res11);
minV(11) = min(Res11);
meanV(11) = mean(Res11);

%%%%%%%%%%%PLOT%%%%%%
BusLoadV = [50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100];
figure(1);
plot(BusLoadV, maxV)
figure(2);
plot(BusLoadV, minV)
figure(3);
plot(BusLoadV, meanV)



% clear all
% clc

%% Step 1
answer1 = inputdlg({'Insert the Tx ID [11 bits]:'}, '?');
IDTx = str2num(answer1{1}); % Transmitter ID array
prTx = bin2dec(answer1{1}); % To know if the node has high or low priority

%% Step 2
answer2 = questdlg('Do you want to insert the other IDs as well?', '?', 'Yes', ...
    'No, thank you', 'No, thank you');
switch answer2 % Handle answer2
    case 'Yes'
        warndlg('You will not be able to insert more than 20 other nodes IDs!');
        will = 1;
    case 'No, thank you'
        will = 0;
end

%% Step 3 - insert IDs manually
if will==1
    answer3 = inputdlg({'How many more nodes IDs do you want to insert? [Number]'}, '?');
    numID = str2double(answer3{1});
    if (numID==0)
        will = 0;
    elseif (numID>20)
        errordlg('The number must be less than 20 for graphic purpuses! Restart!');
    else
        tag = 'Node1 ID [11 bits]: ';
        if (numID>1)&&(numID<21)
            if (numID<10)
                for i1=2:numID
                    newTag = ['Node' num2str(i1) ' ID [11 bits]: '];
                    tag = vertcat(tag, newTag);
                end
            end
            if (numID>9)
                for i2=2:9
                    newTag = ['Node' num2str(i2) ' ID [11 bits]: '];
                    tag = vertcat(tag, newTag);
                end
                for i2=10:numID
                    newTag = ['Node' num2str(i2) ' ID [11 bits]:'];
                    tag = vertcat(tag, newTag);
                end
            end
            prompt = cellstr(tag);
            answer4 = inputdlg(prompt);
            matrixID = zeros(numID, 11);
            for i3=1:numID
                matrixID(i3,:) = str2num(answer4{i3});
            end
            matrix = matrixID;
        end
    end
end

%% Step 4 - random IDs with priority
if will==0
    answer5 = inputdlg({'How many more nodes does the network have? [Number]', ...
        'How many of which with a higher priority than Tx? [Number]'}, '?');
    numNodes = str2double(answer5{1});
    numHiPr = str2double(answer5{2});
    check1 = prTx-numHiPr; % Not to have a number smaller than 2^0
    if numNodes==0
        errordlg('CAN protocol must have at least two communicating nodes! Restart!')
    elseif numHiPr>numNodes
        errordlg('The number of high priority nodes you entered is not consistent! Restart!')
    elseif (check1<0)&&(prTx>=0)
        errordlg('It is not possibe to have so many higher priority nodes! Restart!')
    else
        matrixHi = zeros(numHiPr, 1);
        matrixHiBin = zeros(numHiPr, 11);
        if numHiPr~=0
            for i4=1:numHiPr
                rowHi = randi([0, prTx-1]);
                matrixHi(i4,:) = rowHi;
            end
            for i5=1:numHiPr
                matrixTemp1 = dec2bin(matrixPrInt(i5,1),11);
                b = blanks(1); % A blank space to add in between char elements
                matrixTemp2 = [matrixTemp1(1) b matrixTemp1(2) b matrixTemp1(3) b ...
                    matrixTemp1(4) b matrixTemp1(5) b matrixTemp1(6) b matrixTemp1(7) b...
                    matrixTemp1(8) b matrixTemp1(9) b matrixTemp1(10) b matrixTemp1(11)];
                matrixHiBin(i5,:) = str2num(matrixTemp2);
            end
        end
        numRows = numNodes-numHiPr;
        matrixRand = zeros(numRows, 11);
        if numRows~=0
            for i6=1:numRows
                row = randi([0, 1], 1, 11);
                matrixRand(i6,:) = row;
            end
        end
        matrix = [matrixHiBin; matrixRand];
        matrix = matrix(randperm(size(matrix, 1)), :); % To randomly swap rows
    end
end

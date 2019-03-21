clear all
clc

%% Step 1
answer1 = inputdlg({'Insert your ID [11 bits]:'}, '?');
IDTx = str2num(answer1{1}); % Transmitter ID array
prTx = bin2dec(answer1{1}); % To know if the node has high or low priority

%% Step 2
answer2 = inputdlg({'How many more nodes does the network have? [Number]'}, '?');
numNodes = str2double(answer2{1});
if numNodes==0
    errordlg('CAN protocol must have at least two communicating nodes! Restart!');
else
    %% Step 3
    answer3 = questdlg('Do you want to insert the other IDs as well?', '?', 'Yes', ...
        'No, thank you', 'No, thank you');
    switch answer3 % Handle answer3
        case 'Yes'
            warndlg('You will not be able to insert more than 20 other nodes IDs!');
            will = 1;
        case 'No, thank you'
            will = 0;
    end
    
    %% Step 4 - insert IDs manually
    if will==1
        answer4 = inputdlg({'How many more nodes IDs do you want to insert? [Number]'}, '?');
        numID = str2double(answer4{1});
        if (numID==0)
            will = 0; % IDs will be generated randomly
        elseif (numID>numNodes)
            errordlg('The number must be less than the total number of nodes! Restart!');
        elseif (numID>20)
            errordlg('The number must be less than 20! Restart!');
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
                answer5 = inputdlg(prompt);
                matrixID = zeros(numID, 11);
                for i3=1:numID
                    matrixID(i3,:) = str2num(answer5{i3});
                end
                numRows = numNodes-numID;
                matrixRand = zeros(numRows, 11);
                for i4=1:numRows
                    row = randi([0, 1], 1, 11);
                    matrixRand(i4,:) = row;
                end
                matrix = [matrixID; matrixRand];
                matrix = matrix(randperm(size(matrix, 1)), :); % To randomly swap rows
                answer7 = inputdlg({'Set the busload. [%]'}, '?');
                load = str2double(answer7{1});
            end
        end
    end
    
    %% Step 4 - random IDs with priority
    if will==0
        answer6 = inputdlg({'How many nodes with higher priority?', ...
            'How many nodes with lower priority?'}, '?');
        numHiPr = str2double(answer6{1});
        numLoPr = str2double(answer6{2});
        check1 = prTx-numHiPr; % Not to have a number smaller than 2^0
        check2 = prTx+numLoPr; % Not to have a number larger than 2^11
        check3 = numHiPr+numLoPr; % Not to have more nodes than what you wanted
        if (check3>numNodes)
            errordlg('The number of nodes you entered is not consistent! Restart!');
        elseif (check1<0)&&(prTx>=0)
            errordlg('It is not possibe to have so many higher priority nodes! Restart!');
        elseif (check2>2047)&&(prTx<=2047)
            errordlg('It is not possible to have so many lower priority nodes! Restart!');
        else
            matrixHi = zeros(numHiPr, 1);
            matrixLo = zeros(numLoPr, 1);
            if numHiPr~=0
                for i5=1:numHiPr
                    rowHi = randi([0, prTx-1]);
                    matrixHi(i5,:) = rowHi;
                end
            end
            if numLoPr~=0
                for i6=1:numLoPr
                    rowLo = randi([prTx+1, 2047]);
                    matrixLo(i6,:) = rowLo;
                end
            end
            matrixPrInt = [matrixHi; matrixLo];
            lenMat = length(matrixPrInt);
            matrixPrBin = zeros(lenMat, 11);
            for i7=1:lenMat
                matrixTemp1 = dec2bin(matrixPrInt(i7,1),11);
                b = blanks(1); % A blank space to add in between char elements
                matrixTemp2 = [matrixTemp1(1) b matrixTemp1(2) b matrixTemp1(3) b ...
                    matrixTemp1(4) b matrixTemp1(5) b matrixTemp1(6) b matrixTemp1(7) b...
                    matrixTemp1(8) b matrixTemp1(9) b matrixTemp1(10) b matrixTemp1(11)];
                matrixPrBin(i7,:) = str2num(matrixTemp2);
            end
            numRows = numNodes-lenMat;
            matrixRand = zeros(numRows, 11);
            for i8=1:numRows
                row = randi([0, 1], 1, 11);
                matrixRand(i8,:) = row;
            end
            matrix = [matrixPrBin; matrixRand];
            matrix = matrix(randperm(size(matrix, 1)), :); % To randomly swap rows
            answer7 = inputdlg({'Set the busload. [%]'}, '?');
            load = str2double(answer7{1});
        end
    end
end

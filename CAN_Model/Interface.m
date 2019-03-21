clear all
clc

%% Step 1
answer1 = inputdlg({'How many nodes does the network have? [Number]'}, 'Step 1');

nodesNum = str2double(answer1{1}); % Handle answer

%% Step 2
answer2 = inputdlg({'Insert your ID [11 bits]:'}, 'Step 2');

IDTx = str2num(answer2{1}); % Transmitter ID

%% Step 3
answer3 = questdlg('Do you want to write the other IDs?', 'Step 3', 'Yes','No, thank you','No, thank you');

switch answer3 % Handle answer
    case 'Yes' 
         warndlg('You will not be able to manually insert more than 20 other nodes IDs!', 'Step 3');
         will = 1;
    case 'No, thank you'
        will = 0;
end

%% Step 4 - insert IDs manually
if will==1
    answer4 = inputdlg({'How many more nodes IDs do you want to write? [Number]'}, 'Step 4');
    nodesID = str2double(answer4{1});
    if (nodesID==0)
        errordlg('The number must be greater than 0! Restart!', 'Step4');
    end
    array = 'Node1 ID [11 bits]: ';
    if (nodesID>1) && (nodesID<21)
        if (nodesID<10)
            for i=2:nodesID
                new = ['Node' num2str(i) ' ID [11 bits]: '];
                array = vertcat(array, new);
            end
        end
        if (nodesID>9)
            for i=2:9
                new = ['Node' num2str(i) ' ID [11 bits]: '];
                array = vertcat(array, new);
            end
            for i=10:nodesID
                new = ['Node' num2str(i) ' ID [11 bits]:'];
                array = vertcat(array, new);
            end
        end
        prompt = cellstr(array);
        answer5 = inputdlg(prompt, 'Step 4');
        matrixID = zeros(nodesID, 11);
        for j=1:nodesID
            matrixID(j,:) = str2num(answer5{j});
        end
        numRows = nodesNum-nodesID-1;
        matrixRand = zeros(numRows, 11);
        for k=1:numRows
            row = randi([0, 1], 1, 11);
            matrixRand(k,:) = row;
        end
        matrix = [matrixID; matrixRand];
    end
    if (nodesID>20)
        errordlg('The number must be less than 20! Restart!', 'Step4');
    end
end

%% Step 4 - random IDs
if will== 0
    matrixRand = zeros(nodesNum-1, 11);
    for l=1:nodesNum-1
        row = randi([0, 1], 1, 11);
        matrixRand(l,:) = row;
    end
end

%% 


%% Final IDs

% % ID1 = str2num(y{j})
% % ID2 = str2num(y{j})

function xinshuai2KEEL 
    clc;
    dataSetName = {
        'monthxsdata';
        'yearxsdata';
        'xsdata'
       } ;
%     dirctory = './matData/Processed/' ;
    dirctory = './matData/XinShuai/' ;
    segmentNum = 5;
    for dataId = 1:size(dataSetName)
        fileName = dataSetName{dataId};
        dataDir = strcat(dirctory,fileName);
        load(dataDir);
        
        n = strcat('=' , fileName);
        fromeName = strcat(n , ';');
        toName = 'dataSet';
        eval([toName fromeName]);
       
        cellData = cell(1,2);
        cellData{1,1} =  dataSet(index1,:);
        cellData{1,2} =  dataSet(index2,:);
    
        Segment = samples2Pieces(cellData , segmentNum)';

        Data = cell(segmentNum,2);
        for i = 1:segmentNum
            testSet = Segment(:, mod(3+i, segmentNum) + 1);
            trainSet = Segment;
            trainSet(:, mod(3+i, segmentNum) + 1) = [];
            [train, test] = mergeTrainAndTest(trainSet, testSet);

            Data{i, 1} = train;
            Data{i, 2} = test;
        end

        saveDirctiry = './formatKEEL/';
        name = strcat(fileName, '.mat');
        fileDir = strcat(saveDirctiry, name);

        fromName = strcat('=Data', ';');
        toName = 'data';
        eval([toName fromName]);
        save(fileDir,'data');
    end
end

function [train, test] = mergeTrainAndTest(trainSet, testSet)
    [totalClass, section] = size(trainSet);
    test=[];
    train=[];
    for i = 1:totalClass
        test = [test; testSet{i, 1}];
    end
    for i = 1:totalClass
        col_train = [];
        for j = 1:section
            col_train = [col_train; trainSet{i, j}];
        end
        train = [train; col_train(:, 1:end)];
    end
end


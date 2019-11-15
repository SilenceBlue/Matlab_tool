function mat2KEEL 
    clc;
    dataSetName = {
%         'embeddingData16_1_10';
        'xsdata';
       } ;
    dirctory = './matData/XinShuai/' ;
%     dirctory = './matData/Processed/' ;
    segmentNum = 5;
    for dataId = 1:size(dataSetName)
        fileName = dataSetName{dataId};
        dataDir = strcat(dirctory,fileName);
        structData = load(dataDir);
       

        %%%%% 划分age大于18的数据集 %%%%%%%
        xsdata = structData.xsdata;
        index1 = structData.index1;
        load ./index.mat;
        index2 = index;
        ind = [index1, index];
        matData = xsdata(ind,:);
        %%%%% 划分age大于18的数据集 %%%%%%%
        
%         matData = cell2mat(struct2cell(structData));
        class = unique(matData(:,end));
        numClass = length(class);
        cellData = cell(1,numClass);
        for i = 1:numClass
            cellData{i} = matData(find(matData(:,end)==class(i)),:);
        end
    
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
    % 
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


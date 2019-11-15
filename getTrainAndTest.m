function [train, test] = getTrainAndTest(trainSet, testSet)
% input: 
%       trainSet is numClass*section cell
%       testSet is numClass*1 cell 
% return:
%       train is 1*numClass cell
%       test is mat data
    [totalClass, section] = size(trainSet);
    test=[];
    for i = 1:totalClass
        test = [test; testSet{i, 1}];
    end
    for i = 1:totalClass
        col_train = [];
        for j = 1:section
            col_train = [col_train; trainSet{i, j}];
        end
        train{1, i} = col_train(:, 1:end);
    end
end
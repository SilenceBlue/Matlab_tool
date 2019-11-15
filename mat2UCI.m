function mat2UCI
    clc;
    dataSetName = {
%         'autos';
%         'contraceptive';
%         'balance';
%         'ecoli';
%         'dermatology';
%         'glass';
%         'new-thyroid';
%         'pageblocks';
%         'penbased';
%         'shuttle';
%         'thyroid';
%         'wine';
%         'yeast';

%     'ColonCancer'
%     'mappedPCA';
%     'mappedLPP';
%     'mappedLLE';
%     'mappedNPE';

%     'USPSmat';
%        'a1_s1';
%         '20NewsgroupsMat';
        'PIE_20Mat';
       } ;
%     dirctory = './matData/ColonCancer/' ;
%     dirctory = './matData/MultiClassMatData/' ;
%     dirctory = './matData/jixieData/' ;
    dirctory = './matData/' ;
    for dataId = 1:size(dataSetName)
        fileName = dataSetName{dataId};
        dataDir = strcat(dirctory,fileName);
        structData = load(dataDir);

    %     structData = load('.\matData\a1.mat');
        matData = cell2mat(struct2cell(structData));
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         matData(:,end) = matData(:,end)+1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        class = unique(matData(:,end));
        numClass = length(class);
        cellData = cell(1,numClass);
        for i = 1:numClass
            cellData{i} = matData(find(matData(:,end)==class(i)),:);
        end
        saveDirctiry = './formatUCI/';
    %     fieldName = fieldnames(structData);
        name = strcat(fileName, '.mat');
        fileDir = strcat(saveDirctiry, name);
    % 
        fromName = strcat('=cellData', ';');
        toName = 'data';
        eval([toName fromName]);

        save(fileDir,'data');
    %     strSave = strcat('save(',fileDir,',''',fileName,''')',';');
    %     eval(strSave);
    end


end


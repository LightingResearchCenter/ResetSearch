function [dataPathArray,logPathArray] = getDataSets(folderPathArray)
%GETDATASETS Summary of this function goes here
%   Detailed explanation goes here

nDir = numel(folderPathArray);
dataPathCell = cell(nDir,1);
logPathCell = cell(nDir,1);

for iDir = 1:nDir
    thisDir = folderPathArray{iDir};
    [dataPathCell{iDir},logPathCell{iDir}] = findFiles(thisDir);
end

% Expand cells
dataPathArray = vertcat(dataPathCell{:});
logPathArray = vertcat(logPathCell{:});

end


function [dataPathArray,logPathArray] = findFiles(thisDir)
    listing = dir(thisDir);
    nameArray = {listing.name}';
    
    % Find log info files invarious formats
    logtxt = regexp(nameArray,'.*LOG\.txt$');
    headerbin = regexp(nameArray,'.*header\.bin$');
    headertxt = regexp(nameArray,'.*header\.txt$');
    
    logtxtIdx = ~cellfun(@isempty,logtxt);
    headerbinIdx = ~cellfun(@isempty,headerbin);
    headertxtIdx = ~cellfun(@isempty,headertxt);
    
    logtxtNameArray = nameArray(logtxtIdx);
    headerbinNameArray = nameArray(headerbinIdx);
    headertxtNameArray = nameArray(headertxtIdx);
    
    % Make data file names from log info file names
    data1NameArray = regexprep(logtxtNameArray,'(.*)LOG(\.txt)$','$1DATA$2');
    data2NameArray = regexprep(headerbinNameArray,'(.*)header(\.bin)$','$1data$2');
    data3NameArray = regexprep(headertxtNameArray,'(.*)header(\.txt)$','$1data$2');
    
    % Combine name arrays
    logNameArray = [logtxtNameArray;headerbinNameArray;headertxtNameArray];
    dataNameArray = [data1NameArray;data2NameArray;data3NameArray];
    
    % Construct file paths
    logPathArray = fullfile(thisDir,logNameArray);
    dataPathArray = fullfile(thisDir,dataNameArray);
    
    % Check if files actually exist
    A = cellfun(@exist,dataPathArray,repmat({'file'},size(dataPathArray)));
    idx = A == 2; % file exists if A = 2
    dataPathArray = dataPathArray(idx);
    logPathArray = logPathArray(idx);
    
    if numel(dataPathArray) == 1
        dataPathArray = {dataPathArray};
        logPathArray = {logPathArray};
    end
    
end
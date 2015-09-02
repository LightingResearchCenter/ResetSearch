function resetInventory = searchFiles(dataPathArray,logPathArray)
%SEARCHFILES Summary of this function goes here
%   Detailed explanation goes here

% Count the number of data set paths
nSet = numel(dataPathArray);

% Initialize variables
nResets         = zeros(nSet,1);
nUnwritten      = zeros(nSet,1);
nReadings       = zeros(nSet,1);
status          = cell(nSet,1);
sn              = zeros(nSet,1);
start_datenum	= zeros(nSet,1);
interval_sec	= zeros(nSet,1);
downloaded      = false(nSet,1);
battery_mV      = zeros(nSet,1);

skipped         = false(nSet,1);

for iSet = 1:nSet
    thisData = dataPathArray{iSet};
    thisLog  = logPathArray{iSet};
    
    try
    [~,nResets(iSet),nUnwritten(iSet),nReadings(iSet)] = readData(thisData);
    [status{iSet},sn(iSet),start_datenum(iSet),interval_sec(iSet),...
        downloaded(iSet),battery_mV(iSet)] = readLog(thisLog);
    catch err
        skipped(iSet) = true;
    end
end

% Calculate duration of use in days
duration_days = interval_sec.*nReadings/(60*60*24);

% Bundle reset counts and meta data as a table
resetInventory = table(nResets,nUnwritten,nReadings,status,sn,...
    start_datenum,interval_sec,downloaded,battery_mV,duration_days);

% Delete skipped entries
resetInventory(skipped,:) = [];

% Convert status from string to categorical
resetInventory.status = categorical(resetInventory.status,...
    {'0','2','4'},{'stand by','start new log','continue log'});

end


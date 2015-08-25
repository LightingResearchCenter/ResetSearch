close all
clear
clc

logPath = 'test-LOG.txt';
dataPath = 'test-DATA.txt';

[status,sn,start_datenum,interval_sec,downloaded,battery_mV] = readLog(logPath);

[uncalibrated,nResets,nUnwritten,nReadings] = readData(dataPath);

resetInventory = searchFiles({dataPath},{logPath});

display(resetInventory);
close all
clear
clc

logPath = 'test-LOG.txt';
dataPath = 'test-DATA.txt';

[status,id,startTime,logInt,downloaded,battery_mV] = readLog(logPath);

[uncalibrated,nResets,nUnwritten,nReadings] = readData(dataPath);
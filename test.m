close all
clear
clc

logPath = 'test-Log.txt';

[status,id,startTime,logInt,downloaded,battery_mV] = readLog(logPath);
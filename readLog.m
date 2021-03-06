function [status,sn,start_datenum,interval_sec,downloaded,battery_mV] = readLog(filePath)
%READLOG Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(filePath);

line1 = fgetl(fid);
line2 = fgetl(fid);
line3 = fgetl(fid);
line4 = fgetl(fid);
line5 = fgetl(fid);
line6 = fgetl(fid);
line7 = fgetl(fid);

fclose(fid);

% Determine Daysimeter Status
status = line1;

% Determine Daysimeter ID
sn = str2double(line2);

% Determine Start Date/Time
start_datenum = datenum(line3,'mm-dd-yy HH:MM');

% Determine Logging Interval
interval_sec = str2double(line4); % in seconds

% Determine Download Flag
downloaded = strcmp(line6,'0'); % True if download occured

% Determine Battery Voltage
battery_mV = str2double(line7);

end


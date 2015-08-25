function [status,id,startTime,logInt,downloaded,battery_mV] = readLog(filePath)
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
switch line1
    case '0'
        status = 'stand by';
    case '2'
        status = 'start new log';
    case '4'
        status = 'continue log';
    otherwise
        status = 'status code not recognized';
end

% Determine Daysimeter ID
id = str2double(line2);

% Determine Start Date/Time
startTime = datenum(line3,'mm-dd-yy HH:MM');

% Determine Logging Interval
logInt = str2double(line4); % in seconds

% Determine Download Flag
downloaded = strcmp(line6,'0'); % True if download occured

% Determine Battery Voltage
battery_mV = str2double(line7);

end


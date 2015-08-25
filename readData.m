function [uncalibrated,nResets,nUnwritten,nReadings] = readData(filePath)
%READDATA Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(filePath,'r','b');
D = fread(fid,inf,'uint16');
fclose(fid);

nD = numel(D);
R = D(1:4:nD);
G = D(2:4:nD);
B = D(3:4:nD);
A = D(4:4:nD);

% Find resets (value = 65278)
resetFlag = R == 65278;
nResets = sum(resetFlag);

% Find unwritten (value = 65535)
unwrittenFlag = R == 65535;
nUnwritten = sum(unwrittenFlag);

% Remove resets and unwritten
q = ~(resetFlag | unwrittenFlag);
R = R(q);
G = G(q);
B = B(q);
A = A(q);

% Count remaining readings
nReadings = numel(R);

% Bundle uncalibrated data
uncalibrated = struct('R',R,'G',G,'B',B,'A',A);

end


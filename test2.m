close all
clear
clc
tic
%%
folderPathArray = defineFolders;

[dataPathArray,logPathArray] = getDataSets(folderPathArray);

resetInventory = searchFiles(dataPathArray,logPathArray);

%%
under200 = resetInventory.nResets < 200 & resetInventory.nResets > 0;
figure(1)

%%
subplot(2,3,1)
plot(resetInventory.battery_mV(under200),resetInventory.nResets(under200),'.')
xlabel('Voltage at download (mV)')
ylabel('Number of Resets')
title('Resets vs. Voltage')

%%
subplot(2,3,2)
plot(resetInventory.sn(under200),resetInventory.nResets(under200),'.')
xlabel('Daysimeter Serial Number')
ylabel('Number of Resets')
title('Resets vs. Serial Number')

%%
ax = subplot(2,3,3);
plot(resetInventory.interval_sec(under200),resetInventory.nResets(under200),'.')
ax.XTick = 0:30:210;
ax.XLim = [0,210];
xlabel('Logging Interval (sec)')
ylabel('Number of Resets')
title('Resets vs. Logging Interval')

%%
subplot(2,3,4)
plot(resetInventory.start_datenum(under200),resetInventory.nResets(under200),'.')
datetick('x')
xlabel('Start Date')
ylabel('Number of Resets')
title('Resets vs. Start Date')

%%
subplot(2,3,5)
plot(resetInventory.duration_days(under200),resetInventory.nResets(under200),'.')
xlabel('Logging Duration (days)')
ylabel('Number of Resets')
title('Resets vs. Logging Duration')

%%
subplot(2,3,6)
hadResets = resetInventory.nResets > 0;
histogram(resetInventory.sn(hadResets),'BinMethod','integers')
xlabel('Daysimeter Serial Number')
ylabel('Number of Files')
title('Frequency Files with Resets')

sn = resetInventory.sn(hadResets);
nResets = resetInventory.nResets(hadResets);
uniqueSn = unique(sn);
lifetimeResets = zeros(size(uniqueSn));
for iSn = 1:numel(uniqueSn)
    idx = sn == uniqueSn(iSn);
    lifetimeResets(iSn) = sum(nResets(idx));
end

toc
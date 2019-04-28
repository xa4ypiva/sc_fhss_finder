function [fig] = PlotDetectionInfo(detections, numFigure)

bands = [[struct([detections.band]).min]; [struct([detections.band]).max]];
freqs = (bands(1,:) + bands(2,:)) / 2;
times = [detections.time];
durs = [detections.duration];
tDiff = diff(times);
% tDiff = diff(tDiff);
Fd2 = times(3:end) - times(1:end-2);
Fd3 = times(4:end) - times(1:end-3);

med1 = median(tDiff)
mean1 = mean(tDiff)
med2 = median(Fd2)
mean2 = mean(Fd2)
med3 = median(Fd3)
mean3 = mean(Fd3)

fig = figure(numFigure);
set(gcf, 'color', 'w');

subplot(2,3,[1,4]);
% plot(freqsHz, times, '.');
ImageDetections(detections, 3125, 1e-3);
grid on;
title('Detections');
xlabel('freq, Hz');
ylabel('time, s');

subplot(2,3,2);
plot(freqs);
grid on;
title('Central Freqs');
xlabel('detections');
ylabel('freq, Hz');

subplot(2,3,3);
plot(bands(2,:) - bands(1,:));
grid on;
title('Bands');
xlabel('detections');
ylabel('freq, Hz');

subplot(2,3,5);
plot(times);
grid on;
title('Detection Times');
xlabel('detections');
ylabel('time, s');

% subplot(2,3,6);
% plot(durs);
% grid on;
% title('Durations');
% xlabel('detections');
% ylabel('time, s');

subplot(2,3,6);
plot(tDiff);
hold on;
% plot(tDiff2S);
plot(Fd2);
hold on;
plot(Fd3);
grid on;
title('Time Difference');
xlabel('detection pairs');
ylabel('time, s');

end


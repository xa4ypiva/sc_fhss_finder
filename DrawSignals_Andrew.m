function [] = DrawSignals(spec, signals, startFreq, stepFreq, timeStep)
if(nargin < 3)
    startFreq = 0;
    stepFreq = 1;
    timeStep = 1;
end
%image(10*log10(abs(spec)), 'CDataMapping','scaled');
sizeSpec   = size(spec);
x = startFreq + (0:(sizeSpec(1)-1)) * stepFreq;
y = timeStep * (0:(sizeSpec(2)-1));
specDetect = 20*log10(spec);
for i = 1:length(signals)
    startFreq = max([1 (signals(i).freq-signals(i).band/2)]);
    stopFreq  = min([sizeSpec(1) (signals(i).freq+signals(i).band/2)]);
    startTime = max([1 signals(i).time]);
    stopTime  = min([sizeSpec(2) (signals(i).time+signals(i).dur-1)]);
    specDetect(fix(startFreq):fix(stopFreq), fix(startTime):fix(stopTime)) = 0;
end
figure;
image(y, x, specDetect, 'CDataMapping','scaled');
end




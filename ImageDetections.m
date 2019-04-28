function [] = ImageDetections(detections, freqStepHz, timeStepS)

bandsHz = [[struct([detections.bandHz]).min]; [struct([detections.bandHz]).max]];
timesS = [detections.timeS];
dursS = [detections.durationS];

f = floor(min(bandsHz(1,:)) / freqStepHz) : floor(max(bandsHz(2,:)) / freqStepHz);
t = floor(min(timesS) / timeStepS) : floor(max(timesS + dursS) / timeStepS);
spec = zeros(length(t), length(f));
for i = 1 : length(detections)
    fStartIdx = floor(bandsHz(1, i) / freqStepHz) - f(1) + 1;
    fEndIdx = floor(bandsHz(2, i) / freqStepHz) - f(1) + 1;
    tStartIdx = floor(timesS(i) / timeStepS) - t(1) + 1;
    tEndIdx = floor((timesS(i) + dursS(i)) / timeStepS) - t(1) + 1;
    if (isempty(tStartIdx) || isempty(tEndIdx))
        a = 1;
    end
    spec(tStartIdx:tEndIdx, fStartIdx:fEndIdx) = 1;
end
imagesc([f(1), f(end)] * freqStepHz, [t(end), t(1)] * timeStepS, spec);

end




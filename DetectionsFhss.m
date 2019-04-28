function [detections] = DetectionsFhss(packetsNum, tPacketS, bandPacketHz, fCentralHz, bandFullHz, tOffsetS, tErrStdS, fErrStdHz)
% detections = DetectionsFhss(packetsNum, tPacketS, bandPacketHz, fCentralHz, bandFullHz, tOffsetS, tErrStdS, fErrStdHz)

bandsNum = bandFullHz / bandPacketHz;
freqsHz = randi([-bandsNum/2, bandsNum/2-1], 1, packetsNum) * bandPacketHz + fCentralHz;
bandsHz = freqsHz + [-bandPacketHz/2 + randn(1, packetsNum) * fErrStdHz; ...
                  +bandPacketHz/2 + randn(1, packetsNum) * fErrStdHz];
timesS = (tOffsetS + (0 : packetsNum-1) * tPacketS + randn(1, packetsNum) * tErrStdS);
timesS(timesS < tOffsetS) = tOffsetS;
durationsS = (tPacketS + randn(1, packetsNum) * tErrStdS);

for i = 1 : packetsNum
    detections(i).band.min = bandsHz(1,i);
    detections(i).band.max = bandsHz(2,i);
    detections(i).time = timesS(i);
    detections(i).dur = durationsS(i);
end

end


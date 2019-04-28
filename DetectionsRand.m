function [detections] = DetectionsRand(packetsNum, fCentralHz, bandFullHz, tOffsetS, tErrStdS, fErrStdHz)
% detections = DetectionsRand(packetsNum, fCentralHz, bandFullHz, tOffsetS, tErrStdS, fErrStdHz)

for i = 1 : packetsNum
    freqHz = randi([-bandFullHz/2, bandFullHz/2]) + fCentralHz;
    bandPacketHz = randi([0, bandFullHz/100]);
    bandErrHz = randi([0, fErrStdHz]);
    bandHz = freqHz + [-(bandPacketHz + bandErrHz) / 2; (bandPacketHz + bandErrHz) / 2];
    if (bandHz(1) < freqHz - bandFullHz/2)
        bandHz(1) = freqHz - bandFullHz/2;
    end
    if (bandHz(2) > freqHz + bandFullHz/2)
        bandHz(2) = freqHz + bandFullHz/2;
    end
    tPacketS = rand() * 10e-2;
    timeS = (tOffsetS + randi([1, packetsNum]) * tPacketS + randn() * tErrStdS);
    if (timeS < tOffsetS)
        timeS = tOffsetS;
    end
    
    durationS = (tPacketS + randn() * tErrStdS);
    
    detections(i).band.min = bandHz(1);
    detections(i).band.max = bandHz(2);
    detections(i).time = timeS;
    detections(i).dur = durationS;
end

end


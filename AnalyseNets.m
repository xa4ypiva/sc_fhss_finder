function [netsOut] = AnalyseNets(netsIn)

netsOut = netsIn;

for i = 1 : length(netsIn)
    dets = netsIn(i).detections;
    bands = [[struct([dets.band]).min]; [struct([dets.band]).max]];
    freqs = (bands(1,:) + bands(2,:)) / 2;
    netsOut(i).packetsNum = length(dets);
    netsOut(i).pBand = mean(bands(2,:) - bands(1,:));
    netsOut(i).pDur = mean([dets.dur]);
    netsOut(i).fCentral = mean(freqs);
    netsOut(i).band = max(freqs) - min(freqs);
    netsOut(i).dur = dets(end).time + dets(end).dur - dets(1).time;
end

end


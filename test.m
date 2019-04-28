addpath(genpath('../matlab_utils'));
clear;
close all;
rng(0, 'twister');

fsHz = 20e6;
fCentralHz = 60e6;

tStepS = 1/625;
fStepHz = 3125;

tPacketS = 9e-3;
tPacket = floor(tPacketS / tStepS);
bandPacketHz = 25e3;
bandPacket = ceil(bandPacketHz / fStepHz);

packetsNumFhss = [100, 200, 90, 120];
tPacketFhssS = [tPacketS, tPacketS, tPacketS, 2*tPacketS];
bandPacketFhssHz = [bandPacketHz, bandPacketHz, bandPacketHz, bandPacketHz / 2];
tOffsetS = [0, ...
    1.5*packetsNumFhss(1) * tPacketFhssS(1), ...
    1.5*packetsNumFhss(1) * tPacketFhssS(1) + 0.75*packetsNumFhss(2) * tPacketFhssS(2) + tPacketFhssS(2) * 0.3, ...
    1.5*packetsNumFhss(1) * tPacketFhssS(1) + 0.75*packetsNumFhss(2) * tPacketFhssS(2) + 1.5*packetsNumFhss(3) * tPacketFhssS(3)];
fCentralFhssHz = [fCentralHz, fCentralHz - fsHz/4, fCentralHz + fsHz/8, fCentralHz + fsHz/4];
bandFhssSignalHz = [2e6, 2e6, 2e6, 1e6];

packetsNum = 100;
tErrStdS = 1e-6;
fErrStdHz = 1e2;

pos = 0;
for i = 1 : length(packetsNumFhss)
    detsFhss(pos + 1:pos+packetsNumFhss(i)) = DetectionsFhss(packetsNumFhss(i), tPacketFhssS(i), bandPacketFhssHz(i), ...
        fCentralFhssHz(i), bandFhssSignalHz(i), tOffsetS(i), tErrStdS, fErrStdHz);
    pos = pos + packetsNumFhss(i);
end

detsRand = DetectionsRand(packetsNum * 2, fCentralHz, fsHz, tOffsetS(1), tErrStdS, fErrStdHz);
detsFhss(randi([1, length(detsFhss)], 1, floor(length(detsFhss) / 8))) = [];
detections = [detsFhss, detsRand];

detections = SortByField(detections, 2);
detections = DecimateDetParams(detections, fStepHz, tStepS);

%%
fTol = ceil(10*fErrStdHz/fStepHz);
tTol = ceil(10*tErrStdS/tStepS);
[nets, detsEqual] = FindFhss(detections, 16, fTol, tTol);
%%
nets = AnalyseNets(nets);
return;
%%
PlotDetectionInfo(detections, 1);

figure(2);
imagesc(detsEqual);
%%
PlotDetectionInfo(nets(1).detections, 3);
%%
PlotDetectionInfo(nets(2).detections, 4);
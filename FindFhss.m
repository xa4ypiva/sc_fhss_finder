function [nets, detsEqual] = FindFhss(detections, detSeqNum, tolBandHz, tolDurationS)

nets = [];
detsEqual = zeros(length(detections), length(detections)-1);

for i = 1 : length(detections)
    detections(i).fhssId = [];
end

fhssIdCurr = 1;
for i = length(detections) : -1 : 2
    detsEqual(i, i : end) = -1;
    
    if (~isempty(detections(i).fhssId))
        for j = i-1 : -1 : 1
            if (detections(j).fhssId == detections(i).fhssId)
                detsEqual(i, j) = 1.5;
            end
        end
        continue;
    end
    
    for j = i-1 : -1 : 1
        detsEqual(i, j) = IsBandDurationEqual(detections(i), detections(j), tolBandHz, tolDurationS);
    end
    
    detsEqCurr = detsEqual(i, 1 : i-1);
    detsEqualNum = sum(detsEqCurr(detsEqCurr == 1));
    if (detsEqualNum >= detSeqNum)
        detections(i).fhssId = fhssIdCurr;
        [detections(detsEqual(i,:) == 1).fhssId] = deal(fhssIdCurr);
        fhssIdCurr = fhssIdCurr + 1;
    end
end

for i = 1 : length(detections)
    detCurr = detections(i);
    if (~isempty(detCurr.fhssId))
        idCurr = detCurr.fhssId;
        nets(idCurr).id = idCurr;
        if (~isfield(nets(idCurr), 'detsNum') || isempty(nets(idCurr).detsNum))
            nets(idCurr).detsNum = 0;
        end
        nets(idCurr).detsNum = nets(idCurr).detsNum + 1;
        nets(idCurr).detections(nets(idCurr).detsNum) = detCurr;
    end
end

end


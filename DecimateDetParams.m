function [detections] = DecimateDetParams(detections, fStepHz, tStepS)
%   Detailed explanation goes here

for i = 1 : length(detections)
    detections(i).band.min = floor(detections(i).band.min / fStepHz);
    detections(i).band.max = floor(detections(i).band.max / fStepHz);
    detections(i).time = floor(detections(i).time / tStepS);
    detections(i).dur = floor(detections(i).dur / tStepS);
end

end


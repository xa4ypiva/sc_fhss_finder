function [res] = IsBandDurationEqual(detections1, detections2, tolBand, tolDur)

bands1 = [struct([detections1.band]).max] - [struct([detections1.band]).min];
bands2 = [struct([detections2.band]).max] - [struct([detections2.band]).min];
durs1 = [detections1.dur];
durs2 = [detections2.dur];

res = IsEqual(bands1, bands2, tolBand) && IsEqual(durs1, durs2, tolDur);

end


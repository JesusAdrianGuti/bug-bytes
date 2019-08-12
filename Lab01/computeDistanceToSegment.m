function [dist] = computeDistanceToSegment(qX, qY, x1, y1, x2, y2)
%computeDistanceToSegment Summary of this function goes here
% Finds distance to shortest a line segment described by two end point 1
% and 2.

% Point Q
pointq = [ qX , qY ];

% Line between its two end points 
pt1 = [x1 y1];
pt2 = [x2 y2];
segment = pt1 - pt2;
segmentlength = norm( segment ); 

% distance from point Q to line segment start
vector1 = pointq - pt1;
dist1 = norm(vector1);

% distance from point Q to line segment end
vector2 = pointq - pt2;
dist2 = norm(vector2);

% check to see if point is in same line as segment 
if dot(segment, pointq-pt1) * dot(segment, pointq-pt2) = 0
    mat = [ pt1,    1;
            pt2,    1;
            pointq, 1; ];
    dist = det(mat) / segmentlength;
    
else
    % or the min distance is closest to each end point
    dist = min( dist1,dist2);

end

function [dist] = computeDistancePointToLine(qX, qY, x1, y1, x2, y2)
% Finds the distance between a point and a line 

% Point Q
pointq = [ qX , qY ];
% Line described by its two points in line 
pt1 = [  x1, y1 ];
pt2 = [ x2, y2 ];    

% find "vector coordinates of line"
[a,b,c] = computeLineThroughtTwoPoints( x1, y1, x2, y2);

% find "vector coordinates of line from point to line(point 1)
[x, y, z] = computeLineThroughtTwoPoints( pointq(1), pointq(2), x1, y1);

%two vectors
line = [a b];
ptline = [x y];

% dot product between line and line from ptQ to point on line
dist = dot(line,ptline);

end


















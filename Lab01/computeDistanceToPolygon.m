function [dist] = computeDistanceToPolygon(qX,qY,P)
%  computeDistanceToPolygon( int Xcoord, int Ycoord, Vector listOfPolygonVertices) 
%
% This function finds the shortestditance between a point and a polygon 
% vertex or point on segments

% Point to find distance from
point = [qX qY];

% we will find all the distance to each segment of the polygon
for i = 1 : length(P) - 1
    % Starting poinf of segment i
    startX = P(i,1);
    startY = P(i,2);
    % end point of segment i
    endX   = P(i+1,1); 
    endY   = P(i+1,2);
    % List of distances to segments 1 to i;
    [distances] = computeDistancetoSegment( point(1), point(2), startX,startY,endX,endY);
end

% the closest distance to the polygon is give by the shortest ditance in P
dist = min(distances);
end


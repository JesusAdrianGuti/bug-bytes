function [uX,uY] = computeTangentVectorToPolygon(qX,qY,P)
%  computeTangentVectorToPolygon( int Xcoord, int Ycoord, Vector listOfPolygonVertices) 
%
%  Function will give a unit vector tangent to the polygon sides;

% Initialize
tolerance = 0.01;
minimunDist = -9999;
Segment = [0, 0;0, 0];


dist = 0; % meausured
for i = 1:length(P) - 1
    % we will use segemnt instaed of polygon so that we can keep track of
    % which segment is being used, since POlygon will only give distance
    dist = computeDistanceToSegmen( qX,qY,P(i,1), P(i,2),P(i+1,1), P(i+1,2) );
    
    if( dist < minimunDist || minimunDist < 0 )
        minimunDist = dist;
        % keep track of end points
        % will need these to compute tan vector
        Segment(1,:) = P(i,:);
        Segment(2,:) = P(i+1,:);
    end
end

% once more for final segment from P(end) to P(1);
dist = getDistancePointToSegment( q, P(end,:), P(1,:) );
if( dist < minimunDist || minimunDist < 0 )
    minimunDist = dist;
    Segment(1,:) = P(end,:);    
    Segment(2,:) = P(1,:);
end
    
pt1 = Segment(1,:);
pt2 = Segment(2,:);

% get characteristics of line described by point1 and point2
[a, b, c] = computeLineThroughTwoPoints( pt1(1,1),pt1(1,2), pt2(1,1), pt2(1,2));
intercept = c;

% case 1 : If orthogonal projection of q is on segment, use slope of segment
% case 2: Tangent U to circle around closest point1 or pt2.

ptX = (b^2 * qX - a * b * qY -a * c)/sqrt(a^2 + b^2);
ptY= ( (-a * b * qX) + a^2 * qY -b * c ) /sqrt(a^2 + b^2);

%check if true or not
boolX = ptX >= min(pt1(1),pt2(1)) && ptX <= max(pt1(1),pt2(1));
boolY = ptY >= min(pt1(2),pt2(2)) && ptY <= max(pt1(2),pt2(2));

u_x = 1;
u_y = 1;
closePt = [0 0];

if( (boolX && boolY) )   
	u_x = pt2(1) - pt1(1);
	u_y = pt2(2) - pt1(2);
else
	% q is closest to a vertex
    
    %find which vertex
	closePt = pt1;
	if( sqrt((pt1(1) - q(1))^2 + (pt1(2) - q(2))^2) > minimunDist + tolerance )
		closePt = pt2;
    end
	u_x = (closePt(2) - q(2));
	u_y = -(closePt(1) - q(1));
    
    if( u_x^2 + u_y^2 < tolerance^2 )

        for h = 1:length(P)
            if( P(h,:) == closePt )
                closePt = P(1+mod(h,length(P)),:);
                u_x = closePt(1) - pX;
                u_y = closePt(2) - pY;
                break;
            end
        end
    end
    
end

% Need to scale to get unit vector U
scale = sqrt(u_x^2 + u_y^2);

% tangent vector u
uX= u_x / scale;
uY= u_y / scale;
end


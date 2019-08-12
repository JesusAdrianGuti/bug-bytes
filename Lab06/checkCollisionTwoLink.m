function [ boolCollision] = checkCollisionTwoLink(L1,L2,W,alpha,beta,x0,y0,r)
% returns 1 if the two link manipulator (defined by L1,L2,W,alpha,beta)
% collides with the obstacle (defined by x0,y0,r).
% return 0 if no collision



% Link 1 vertices
% described in a counter clockwise fashion
link1(1,:) = [0, -W];
link1(2,:) = [L1,-W];
link1(3,:) = [L1, W];
link1(4,:) = [0,W];

% Link 2 vertices
% described in a counter clockwise fashion
% then translate the vector to the end of link 1
link2(1,:) = [0,-W];
link2(2,:) = [L2, -W];
link2(3,:) = [L2, W];
link2(4,:) = [0,W];

%Rotation matrix by alpha 
RMalpha = [ cos(alpha), -sin(alpha);
           sin(alpha), cos(alpha)];

RMbeta = [ cos(beta+alpha), -sin(beta+alpha);
           sin(beta+alpha), cos(beta+alpha)];

       
% Rotate Link 1 & Link 2 by angle alpha
RotLink1 = RMalpha * link1';
RotLink2 = RMbeta * link2';

% Translate 2
n= 4;
vector = ( RotLink1(:,2) + RotLink1(:,3) ) / 2;
for i = 1:n 
    finalLink2(i,:) = RotLink2(:,i) + vector; 
end

mid = ( finalLink2(2,:) + finalLink2(3,:) ) / 2;

% After building polygons for links in their rotated positions
% build obstacke polygon

theta = 0: pi/20 : 2 * pi;
xObs = r * cos(theta) + x0;
yObs = r * sin(theta) +y0;

obstcale(1,:) = xObs;
obstacle(2,:) = yObs;


% now check for colliosions between the links and the obstacle

% check for link 1
boolCollision = doTwoConvexPolygonIntersect(Link1,obstacle);
%check for link 2
boolCollision =  doTwoConvexPolygonIntersect(Link2,obstacle);


% after checking for collision
% Return 1 if collision occurs
% Return 0 if NO collision

return boolCollision;
end


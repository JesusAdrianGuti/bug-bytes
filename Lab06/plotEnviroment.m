function[] = plotEnviroment(L1,L2,W,alpha,beta,x0,y0,r)
% Function plots 2-link manipulator defined by L1,L2,W,alpha & beta
% plots circular obstacle defined by origin (x0,y0) and radius r

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

% Rotate link 2
n= 4;
vector = ( RotLink1(:,2) + RotLink1(:,3) ) / 2;
for i = 1:n 
    finalLink2(i,:) = RotLink2(:,i) + vector; 
end

mid = ( finalLink2(2,:) + finalLink2(3,:) ) / 2;



hold on
x = 0:pi/15:2*pi;
xcoor = r* cos(x);
ycoor = r* sin(x);
patch(xcoor,ycoor,'blue');

patch( RotLink1(1,:), RotLink1(2,:),'red');
patch( finalLink2(:,1), finalLink2(:,2),'green');
xlim([-2 10])
ylim([-2 10])

xcoor2 = r* cos(x)+ vector(1);
ycoor2 = r* sin(x)+ vector(2);
patch(xcoor2,ycoor2,'blue');

xcoor3 = r* cos(x) + mid(1);
ycoor3 = r* sin(x) + mid(2);
patch(xcoor3,ycoor3,'blue');

%plotting circle obstacle

xObs = r * cos(x) + x0;
yObs = r * sin(x) +y0;
patch(xObs,yObs,'m');


hold off


end


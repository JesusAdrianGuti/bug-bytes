function [ aVal , bVal, cVal ] = computeLineThroughTwoPoints(x1,y1,x2,y2)

% Input two distinct points and the fucntion will output a,b,c defining line ax + by + c = 0 
% thats passes thru both point specified

pt1 = [ x1 y1 ];
pt2 = [ x2 y2 ];

% if slope is infinte
if (  (  pt1(1) - pt2(1) )  ==  0  )
  aVal = 0;
  bVal = 1;
  cVal = 0;
 return;
 
         
else       
% From two points find slope of line
slope = ( ( pt1(2) - pt2(2)) / ( pt1(1) - pt2(1)) ); 

% Plug in slope and point1 to get b
% b = y - m*x
% intercept = pt2(2) - ( slope * pt2(1) );

% (y - y1 ) = m ( x - x1)
% y - y1 = m*x - m*x1
% -m*x + y -(m*x1 + y1) = 0
% ax + by + c = 0

a = -(slope);
b = 1;
c = - ( (slope * pt1(1)) + pt1(2) );

% normalize
aVal = a / ( sqrt( a^2 + b^2) );
bVal =  b / ( sqrt( a^2 + b^2) );
cVal = c;

end

end


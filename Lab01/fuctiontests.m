clear all
clc

% Jesus Gutierrez
% ME 145 Robotics Plannig


[ a b c ] = computeLineThroughTwoPoints(0,0,1,1); 
a_sol = sqrt(2) ;
b_sol = sqrt(2) ;

l = computeDistancePointToLine(0,0, 1,1,1,0);
l_sol = 1;

s = computeDistanceToSegment(0,0,1,1,1,-2);
s_sol = srqt(2);

P =[2,0; 
    2,1;
    3,1;
    3,0;];
p = computeDistanceToPolygon(0,0,P);
p_sol = 2;



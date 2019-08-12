function [path, string] = computebug1(startPoint,goalPoint,obstacleList, stepSize)
% Implementation of bug one algorithm
% =================================================
% while not at goal
%   move towards goal
%   if encounter an obstacle 
%       store min_dist_goal = curr position  
%       while go around obstacle 
%           keep track of distance to goal 
%        if curr_distance < min_dist_stored
%               store point & min_dist
%           end
%       end
%   end
%  Move to point of min_dist
%  end
% =================================================
% Outputs 
% seqeunce list of path from start to goal and string message 





% initialize path entry
path = [startPoint];

% current position
curr_pos = startPoint;

% while not at goal
while abs( norm(curr_pose - goalPoint) ) > stepSize
    
    

















path = 
stringf = 'Success'
% or
path = []
string = ' FAILURE: PATH DOES NOT EXIST '
end


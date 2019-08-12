function path= computeBug1Path( startPoint, goalPoint, obstacleList )
% Computes the path a Bug would follow until it hits an obstacle.
% Function requires start and goal point as well as a cell array of
% polygonal obstacles and returns an ordered list of all of the points 
% visited by the bug along its path. Note that each polygon is 
% defined by a n x 2 array of counterclockwise points.



% tolerances
circumStartTolerance=0.02;
Tolerance=50;
stepSize = 0.02;

% Initialize the path variable 
path = startPoint;

% loop until goal reached or no path exists
while( true )
    
    distToGoal = dist( path(end,:), goalPoint );
    % Has bug reached goal location?
    if( distToGoal < stepSize )
        break
    end
    
    distToClosestObstacle = distToGoal + stepSize;
    closestPolygon = [];
    
    % Loop through each polygonal obstacle in the list to find the closest
    % one to the Bug's current position.
    for i = 1:length(obstacleList)
        distToObstacle = computeDistancePointToPolygon(path(end,:), obstacleList{i});
        if( distToObstacle < distToClosestObstacle )
            distToClosestObstacle = distToObstacle;
            closestPolygon = obstacleList{i};
        end
    end
    
    % Is bug inside polygon?
    if( length(closestPolygon) > 0 && inpolygon(path(end,1), path(end,2), closestPolygon(:,1), closestPolygon(:,2)) )
        disp('Error - bug entered polygon')
        break
    end
    
    % Limit the length of a step the Bug will take based on proximity to
    % obstacles, goal so that it does not over shoot and enter an obstacle
    % or pass the goal location.
    stepSize = min( [stepSize, distToClosestObstacle/5, distToGoal] );
    
    % Has bug hit an obstacle?
    if( distToClosestObstacle < stepSize )
        
        %---- circumnavigation ----%
        pathAround=[nextPos];
        circumStart=nextPos;
        closestPoint=nextPos;
        while(1)
            
            
            [uX, uY] = computeTangentVectorToPolygon(pathAround(end,:), closestPolygon);
            step = stepSize*[uX uY];
            nextPos=pathAround(end,:) + step;
            pathAround=[pathAround;nextPos];
            
            % check for closest point
            if dist(nextPos, goalPoint) < dist(closestPoint,goalPoint)
                closestPoint=nextPos;
                minDistGoalIndex=size(pathAround,1);
            end
                           
            % check if we have looped all the way around object
            if( (size(pathAround,1) > Tolerance) && (abs( norm(nextPos - circumStart) ) < circumStartTolerance) )
                break; % if we are back to beginging point where we encountered object
            end        % stop looping around
        end 
        
        % Update Path
        path=[path ; pathAround(1:end,:) ; pathAround(1:minDistGoalIndex,:)];
        checkLength1=computeDistancePointToPolygon(path(end,:),closestPolygon);
        
        % check if one can move towards goal from closest point on polygon
        uX = (goalPoint(1) - path(end,1))/distToGoal;
        uY = (goalPoint(2) - path(end,2))/distToGoal;
        step = stepSize*[uX, uY];
        stepFromPolygon = path(end,:) + step;
        d2=computeDistancePointToPolygon(stepFromPolygon,closestPolygon);
        if (checkLength1 > d2)
            disp('No path from start to goal exists');
            return;
        end
        %---- end circumnavigation ----%
        
    else
        % Step towards goal along unit vector u between current point and goal
        uX = (goalPoint(1) - path(end,1))/distToGoal;
        uY = (goalPoint(2) - path(end,2))/distToGoal;

        % Add new step to end of the path
        step = stepSize*[uX, uY];
        nextPos = path(end,:) + step;
        path = [path; nextPos];
    end
    
      
end
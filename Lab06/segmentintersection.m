function dotwoconvexpolygonsintersect(P1,P2)

P1(end+1,:) = P1(1,:);
P2(end+1,:) = P2(1,:);

hold
plot(P1(:,1),P1(:,2),'b')
plot(P2(:,1),P2(:,2),'r')

intersection = inf;
for i = 1:length(P1)-1
    for j = 1:length(P2)-1
        intersection(i,j) = segmentintersection(P1(i,:),P1(i+1,:),P2(j,:),P2(j+1,:));
    end
end

findintersection = find(intersection > 0);
if isempty(findintersection) == 0
    ans = 1
    return
end
inside2 = 0;
inside1 = 0;
if isempty(findintersection) == 1
    for i = 1:length(P1)-1
        inside2(i) = ispointinconvexpolygon(P1(i,:),P2);
    end
    for i = 1:length(P2)-1
        inside1(i) = ispointinconvexpolygon(P2(i,:),P1);
    end
    inside1check = find(inside1 == 1);
    inside2check = find(inside2 == 1);
    if isempty(inside1check) == 0
        ans = 1
        return
    end
    if isempty(inside2check) == 0
        ans = 1
        return
    end
    
    ans = 0
    return
end


end
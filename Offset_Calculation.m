function [ x,y ] = Offset_Calculation(a)
% POI Locator
t = 0.5;
b= -10;
POI = [ 0 5; 0 -5; 5 0; -5 0];
x = zeros([4 15]);
y = zeros([4 15]);

for i = 1:4
    for j=1:2
        Initial_position=(b-a)*rand(i,j)+a;
    end
end

%% Getting distances for POIS

% Drone 1
for i = 1:4 
    for j = 1:2
        dist1(i,j) = POI(i,j)-Initial_position(1,j);
    end
end  

for j=1:4
    dist11(j,1) = sqrt((dist1(j,1)^2)+(dist1(j,2)^2));
    
end

% Drone 2
for i = 1:4 
    for j = 1:2
        dist2(i,j) = POI(i,j)-Initial_position(2,j);
    end
end

for j=1:4
    dist22(j,1) = sqrt((dist2(j,1)^2)+(dist2(j,2)^2));
end

% Drone 3 
for i = 1:4 
    for j = 1:2
        dist3(i,j) = POI(i,j)-Initial_position(3,j);
    end
end

for j=1:4
    dist33(j,1) = sqrt((dist3(j,1)^2)+(dist3(j,2)^2));
end

% Drone 4
for i = 1:4 
    for j = 1:2
        dist4(i,j) = POI(i,j)-Initial_position(4,j);
    end
end

for j=1:4
    dist44(j,1) = sqrt((dist4(j,1)^2)+(dist4(j,2)^2));
end



%% Finding the shortest distance.

    
    distance_array(:,1) = dist11(:,1);   
    distance_array(:,2) = dist22(:,1);
    distance_array(:,3) = dist33(:,1); 
    distance_array(:,4) = dist44(:,1);

    distance_array;

%% Finding minimums and Location positions


[d,i1] = min(distance_array(1,:));

    for i=1:4
        distance_array(i,i1) = 100;
    end
    
[d2,i2] = min(distance_array(2,:));

    for i=1:4
        distance_array(i,i2) = 100;
    end
 
[d3,i3] = min(distance_array(3,:));

    for i=1:4
        distance_array(i,i3) = 100;
    end
    
[d4,i4] = min(distance_array(4,:));
    
    for i=1:4
        distance_array(i,i4) = 100;
    end

i1
i2
i3
i4

position = Initial_position

%% Moving selected drone to (0,5)
    
i=1;
    while abs(position(i1,1)-POI(1,1)) > 0.01
        x(1,i) = position(i1,1);
        V1x = POI(1,1)-position(i1,1);
        position(i1,1) = position(i1,1) + V1x*t;
        i=i+1;
       
    end
i=1; 
    while abs(position(i1,2)-POI(1,2)) > 0.01
        y(1,i) = position(i1,2);
        V1y = POI(1,2)-position(i1,2);
        position(i1,2) = position(i1,2) + V1y*t;
        i=i+1;
    end

%% Moving selected drone to (0,-5)
i=1;
    while abs(position(i2,1)-POI(2,1)) > 0.01
        x(2,i) = position(i2,1);
        V2x = POI(2,1)-position(i2,1);
        position(i2,1) = position(i2,1) + V2x*t;
        i=i+1;
    end
i=1;
    while abs(position(i2,2)-POI(2,2)) > 0.01
        y(2,i) = position(i2,2);
        V2y = POI(2,2)-position(i2,2);
        position(i2,2) = position(i2,2) + V2y*t;
        i=i+1;
      
    end
%% Moving selected drone to (5,0)    
i=1;
    while abs(position(i3,1)-POI(3,1)) > 0.01
        x(3,i) = position(i3,1);
        V3x = POI(3,1)-position(i3,1);
        position(i3,1) = position(i3,1) + V3x*t;
        i=i+1;
       
    end
 i=1;   
    while abs(position(i3,2)-POI(3,2)) > 0.01
        y(3,i) = position(i3,2);
        V3y = POI(3,2)-position(i3,2);
        position(i3,2) = position(i3,2) + V3y*t;
        i=i+1;
       
    end
    
%% Moving Selected drone to (-5,0)
i=1; 
    while abs(position(i4,1)-POI(4,1)) > 0.01
        x(4,i) = position(i4,1);
        V4x = POI(4,1)-position(i4,1);
        position(i4,1) = position(i4,1) + V4x*t;
        i=i+1;
      
    end
i=1;    
    while abs(position(i4,2)-POI(4,2)) > 0.01
        y(4,i) = position(i4,2);
        V4y = POI(4,2)-position(i4,2);
        position(i4,2) = position(i4,2) + V4y*t;
        i=i+1;
    end
  
for i = 1:4
    for j= 1:15
        if x(i,j) == 0;
            x(i,j) = x(i,j-1);
        end 
    end
end

for i = 1:4
    for j= 1:15
        if y(i,j) == 0;
            y(i,j) = y(i,j-1);
        end 
    end
end
    


   % plot(x(1,:),y(1,:),'-b')
    %hold on
    %plot(x(2,:),y(2,:),'-b')
    %hold on
    %plot(x(3,:),y(3,:),'-b')
    %hold on
    %plot(x(4,:),y(4,:),'-b')
    %hold on 

for i = 1:15
 
    %plot(x(1,i),y(1,i),'ro',x(1,i),y(1,i),'-b')
    %hold on
    %plot(x(2,i),y(2,i),'ro',x(2,:),y(2,i),'-b')
    %hold on
    %plot(x(3,i),y(3,i),'ro',x(3,i),y(3,i),'-b')
    %hold on
    %plot(x(4,i),y(4,i),'ro',x(4,i),y(4,i),'-b')
    %hold on
    %pause(0.5)
    
end
x
y


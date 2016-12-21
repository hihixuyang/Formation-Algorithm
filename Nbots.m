function [ X ] = Nbots( n )

%% Initializing Desired formation

POI = zeros([n 2]); % Points of Intrest
X = zeros([n 2]); % Initializing Tabledata

R1 = 0.15*n; % Inner Circle radius
R2 = 0.3*n; % Outer Circle radius

d = zeros([n 1]); 
I = zeros([n 1]); % Index of All The Selcted Point of Interst location in POI 

%% Creating 4 rings of radiun 3q, s.t q = [0x4] with evenly spaced offsets on each ring

POI(1,1) = 0;
POI(1,2) = 0;

for t = 2:7
    POI(t,1) = 3*cos(t*((2*pi)/3));
    POI(t,2) = 3*sin(t*((2*pi)/3));
end

for t = 8:16
    POI(t,1) = 6*cos(t*((2*pi)/9));
    POI(t,2) = 6*sin(t*((2*pi)/9));
end

for t = 17:34
    POI(t,1) = 9*cos(t*((2*pi)/18));
    POI(t,2) = 9*sin(t*((2*pi)/18));
end

for t = 35:n
    POI(t,1) = 12*cos(t*((2*pi)/25));
    POI(t,2) = 12*sin(t*((2*pi)/25));
end

%% Creating 2 Evenly distributed Concentric rings of radius R1 and R2 (OLD FORMATION)

%for t = 1:(n/2)
 %   POI(t,1) = R1*cos(t*((2*pi)/(n/2)));
  % POI(t,2) = R1*sin(t*((2*pi)/(n/2)));
%end

%for t = ((n/2)+1):n
 %   POI(t,1) = R2*cos(t*((2*pi)/(n/2)));
  %  POI(t,2) = R2*sin(t*((2*pi)/(n/2)));
%end



figure(1);
plot(POI(:,1),POI(:,2),'ro');
title('Formation Shape')
xlabel('X (m)')
ylabel('Y (m)')


%% Initializing Locations
a=10;
b=-10;

for i = 1:n
    for j=1:2
        Pos=(b-a)*rand(i,j)+a;
    end
end
%plot(Pos(:,1),Pos(:,2),'ro')

%% Getting Distances
distance = zeros(n);
for j = 1:n
    for i = 1:n
        distance(i,j) = sqrt(((Pos(j,1)-POI(i,1))^2)+(((Pos(j,2)-POI(i,2))^2)));
    end
end

%% Finding and selecting A minimum

for i = 1:n
    [d(i,1), I(i,1)] = min(distance(:,i));
    distance(I(i,1),:) = 1000000;
end


%% Creating Tabledata With Offset As Output Variable X
for i = 1:n
    X(i,4) = POI(I(i,1),1);
    X(i,5) = POI(I(i,1),2);
    X(i,1) = Pos(i,1);
    X(i,2) = Pos(i,2);
    X(i,3) = 0;
    X(i,6) = I(i,1);
end





















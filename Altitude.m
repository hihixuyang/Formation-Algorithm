Target_Altitude = 10;
t = 0.1;
s=10;

    % Matrix of Disturbance values
a=8;
b=12;   
y = (b-a)*rand(10,1)+a;

    % Range of Disturbance Values
range = [min(y) max(y)];


    % Altitude Calculation
    for i= 1:s
        vertical_v = (Target_Altitude - (s,1));
        
        while vertical_v ~= 0
        vertical_v = (Target_Altitude - y(s,1));
        y(s,1) = y_disturbance(s,1) + (vertical_v*t);
        
        end   
    end
          


    


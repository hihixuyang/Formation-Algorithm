function [H] = collectiveavg( handle, evt, table, adj, H_handle, list, breakpt, switch_number, offset, network_size,n)
%This is the main function within the GUI: it uses the consensus algorithm
%as the dynamics for the agents.

%This makes the reset button value zero; pressing the reset button while
%the averaging algorithm is running will stop the averaging loop (below)
set(breakpt, 'data', [0]);


%Gets the table data, network's # of agents & adjacency matrix
table_data = get(table, 'data');
%dimension = str2double(get(network_size,'string'));
dimension = n;
A = get(adj, 'data');


%This checks whether the uses wants to introduce an offset or not
offset_check = get(offset, 'value');

%This finds the averages of the initial table data so that the consensus
%values can be compared to the desired (average) values in the second plot
%(i.e. plot_2_h)
avg_x = mean(table_data(:,1));
avg_y = mean(table_data(:,2));
avg = [avg_x avg_y];



%This makes a temporary offset vector of zeros.
offset_temp = zeros(2*dimension,1);

%This runs the entire consensus loop for the case of a switching graph.

if get(list,'value') == 3
    %This is the # of switching topologies that the uses defined in the GUI
    switch_num = str2double(get(switch_number,'string'));
    
    %----------------------------------------------------------------------
    %This stores the adjacency matrices for the switching graph topologies
    %that were defined by the user in the Workspace.
    B = [];
    for w = 1:switch_num
        B(((w-1)*dimension + 1):dimension*w, 1:dimension) = ...
            (evalin('base', sprintf('A%d', w)));
    end
    
    %Stores position data from table in GUI in a row vector in the form
    %[x_1 y_1 x_2 y_2 ... x_n y_n]. NOTE HOW TABLE DATA IS STORED.
    for a = 1:dimension
        for b = 1:2
            X(2*a + b - 2) = table_data(a,b);
        end
    end
    %Transposes row vector to column vector x = [x_1; y_1; ... x_n; y_n]
    x = transpose(X);
    
    %This stores the offset data in the following way: offset_vector = 
    %[x_off_1 y_off_1 x_off_2 y_off_2 ... x_off_n y_off_n]
    offset_vector = zeros(length(X),1);
    if offset_check == 1
        for a = 1:dimension
            for b = 4:5
                offset_vector(2*a + b - 2) = table_data(a,b);
            end
        end
    end
    %Tansposes the offset vector
    
    D_out = zeros(dimension);
    y = zeros(length(X),1);
    
    %----------------------------------------------------------------------
   
    %This stores the delay in updating for each agent in a vector of the
    %form tau = [delay_1 delay_1 ... delay_n delay_n]
    tau = zeros(length(X),1);
    for q = 1: (length(X)) / 2
        tau(2*q) = table_data(q,3);
        tau(2*q - 1) = table_data(q,3);
    end
    
    %H is the history matrix which gets populated by the x and y positions
    %of each agent in the form H(:,1) = [x_1; y_1; ... x_n; y_n]
    H = x;
    
    %initializing variables for the while loop: i and j are used for 
    j = 1;
    t = 2;
    diff = zeros(1,dimension);
    count = 1;
    Z = Nbots(dimension);
    
    while get(breakpt,'data') ~= [1]
        for q = 1:switch_num
            A = B(((q-1)*dimension + 1):dimension*q, :);
          
            
            for c = 1:dimension
                for d = 1:dimension
                    neighbor(d) = A(c,d);
                end
                diag(c) = sum(neighbor);
                D_out(c,c) = diag(c);
                neighbor = [];
            end
            
            L = D_out - A;
            I = eye(2);
            
            
            % This sets an appropriate delta such that the consensus algorithm 
            %converges (delta is the time step between each interval)
            for s = 1:dimension
                d(s) = L(s,s);
            end
            delta_t = 1 / (max(d) + 1);
            
            %This is a Kronecker product to ensure that the dimensions of
            %the Laplacian matrix are extended so that the x vector (which
            %stores both (x,y) coordinates of each agent) multiplied by the
            %Laplacian is of proper size for matrix multiplication.
            L_kron = kron(L,I);
            
            
            for i = 1:length(X)
                if tau(i) == 0
                    %This is the consensus algo for regular updating (no
                    %delays)
                    x(i) = H(i,(t-1)) - delta_t * L_kron(i,:) * (H(:,t-1) - offset_vector);
                    j = 1;
                elseif t > tau(i) + 1 && mod(t, tau(i) + 2 ) == 0
                    %This is the consensus algo for delays in updating
                    x(i) = H(i,(t-tau(i))) - delta_t * L_kron(i,:) * (H(:,t-1) - offset_vector);
                    j = 1;
                else
                    %This is the case when we have a stubborn agent and
                    %tau(i) is set to Inf.
                    x(i) = x(i);
                end
                
            end
            
    %----------------------------------------------------------------------        
 
    %----------------------------------------------------------------------
            
            %This increases the time step - this is used for plotting.
            t = t+1;
            for m = 1:dimension
                for n = 1:2
                    table_data(m,n) = x(2*m + n - 2);
                end
            end
            
            set(table,'data',table_data);
            
            %--------------------------------------------------------------
            %--------------------------------------------------------------
            %Plotting Section - Do Not Touch
            
            uip = uipanel('Position',[0.01 0.01 0.56 0.98]);
            
            for i = 1:dimension
                plot_h = subplot(2,1,1,'parent',uip);
                if table_data(i,3) == Inf
                    plot(plot_h, table_data(i,1),table_data(i,2),'c--o');
                    x_axis_unit = (max(table_data(:,1)) -  ...
                        min(table_data(:,1))) / 14;
                    y_axis_unit = (max(table_data(:,2)) - ...
                        min(table_data(:,2))) / 14;
                    text(table_data(i,1) - x_axis_unit,table_data(i,2) ...
                        - y_axis_unit, sprintf('%d', i), 'color', 'c', ...
                        'fontweight', 'bold');
                else
                    
                    plot(plot_h, table_data(i,1),table_data(i,2),'r--o');
                    x_axis_unit = (max(table_data(:,1)) - ...
                        min(table_data(:,1))) / 14;
                    y_axis_unit = (max(table_data(:,2)) - ...
                        min(table_data(:,2))) / 14;
                    text(table_data(i,1) - x_axis_unit,table_data(i,2) ...
                        - y_axis_unit, sprintf('%d', i), 'color', 'r', ...
                        'fontweight', 'bold');
                end
                axis([min(table_data(:,1)) - 1, max(table_data(:,1)) + ...
                    1, min(table_data(:,2)) - 1, max(table_data(:,2)) + 1])
                title('Agent Positions')
                xlabel('x-Position')
                ylabel('y-Position')
                hold on
            end
            
            for i = 1:dimension
                for j = 1:dimension
                    if A(i,j) == 1
                        arrow([table_data(i,1),table_data(i,2)],...
                            [table_data(j,1),table_data(j,2)], ...
                            'facecolor', 'b', 'edgecolor', 'b', 'length', 6);
                    end
                end
            end            
            
            
            for i = 1:2:2*dimension - 1
                z = count;
                diff(z,(i + 1) / 2) = pdist([x(i) x(i+1); avg]);
            end
            
            plot_2_h = subplot(2,1,2,'parent',uip);
            for i = 1:count
                plot(plot_2_h, linspace(0, count, count), diff);
                title('Distances from Average')
                xlabel('Time Steps')
                ylabel('Distance')
            end
            %--------------------------------------------------------------
            %--------------------------------------------------------------
            
            %This history matrix horizontally concatenates the newly 
            %calculated positions for the agents after undergoing consensus
            %algo for one time step
            H = horzcat(H,x);
            
            %This 
            set(H_handle,'data',H);
            
            %Increases count & puts pause so graphing can be observed in
            %GUI
            count = count + 1;
            pause(0.001);
            hold off
            
            if q == switch_num
                q = 1;
            end
        end
          
    end
else
    %this loop is for cyclic, path and custom graph types. Comments are
    %similar to the switching graph case and will not be repeated here.
    for a = 1:dimension
        for b = 1:2
            X(2*a + b - 2) = table_data(a,b);
        end
    end
    x = transpose(X);
    
    if offset_check == 1
        if get(list,'value') == 3 || get(list,'value') == 6
            for a = 1:dimension
                for b = 1:2
                    offset_vector(2*a + b - 2) = table_data(a,b+4);
                end
            end
        else
            for a = 1:dimension
                for b = 1:2
                    offset_vector(2*a + b - 2) = table_data(a,b+3);
                end
            end
        end
    else
        offset_vector = zeros(1, size(X,1));
    end
    
    offset_vector = transpose(offset_vector);
    
    D_out = zeros(dimension);
    
    for c = 1:dimension
        for d = 1:dimension
            neighbor(d) = A(c,d);
        end
        diag(c) = sum(neighbor);
        D_out(c,c) = diag(c);
        neighbor = [];
    end
    
    L = D_out - A;
    
    I = eye(2);
    y = zeros(length(X),1);
    
    %----------------------------------------------------------------------
	
    % This chooses appropriate delta such that the consensus algorithm 
    %converges
    
    for s = 1:dimension
        d(s) = L(s,s);
    end
    delta_t = 1 / (max(d) + 1);
    
    tau = zeros(length(X),1);
    for q = 1: (length(X)) / 2
        tau(2*q) = table_data(q,3);
        tau(2*q - 1) = table_data(q,3);
    end
    
    max_tau = max(tau);
    H = x;
    L_kron = kron(L,I);
    
    j = 1;
    t = 2;
    diff = zeros(1,dimension);
    count = 1;
    while get(breakpt,'data') ~= [1]
        for i = 1:length(X)
            if tau(i) == 0
                x(i) = H(i,(t-1)) - delta_t * L_kron(i,:) * (H(:,t-1) -...
                    offset_vector);
                j = 1;
            elseif t > tau(i) + 1 && mod(t, tau(i) + 2 ) == 0
                x(i) = H(i,(t-tau(i))) - delta_t * L_kron(i,:) * ...
                    (H(:,t-1) - offset_vector);
                j = 1;
            else
                x(i) = x(i);
            end
            
        end
        
    %----------------------------------------------------------------------        
    % Updating Adjacency matrix on every loop iteration based on a radius
    % of confidence
            for i=1:dimension
                for j = 1:dimension
                    if (sqrt(((table_data(i,1)-table_data(j,1))^2)+((table_data(i,2)-table_data(j,2))^2)))< 4.5
                        A(j,i) = 1;
                    else 
                        A(j,i) = 0;
                       
                    end 
                end
            end
            
            for i = 1:dimension
                for h = 1:dimension
                    if table_data(i,4) == 0
                       A(i,h) = 1;
                    end
                end
            end
            
                
                
                
            if (abs(table_data(:,1)) - abs(table_data(:,4))) < 0.1
                disp('formation achieved at time =');
                disp(0.01*t);
            end
            
    
    %----------------------------------------------------------------------
        
        t = t+1;
        for m = 1:dimension
            for n = 1:2
                table_data(m,n) = x(2*m + n - 2);
            end
        end
        
        set(table,'data',table_data);
        
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        %Plotting Section - Do Not Touch
        
        uip = uipanel('Position',[0.01 0.01 0.56 0.98]);
        
        for i = 1:dimension
            plot_h = subplot(2,1,1,'parent',uip);
            if table_data(i,3) == Inf
                plot(plot_h, table_data(i,1),table_data(i,2),'c--o');
                x_axis_unit = (max(table_data(:,1)) - min(table_data(:,1))) / 14;
                y_axis_unit = (max(table_data(:,2)) - min(table_data(:,2))) / 14;
                text(table_data(i,1) - x_axis_unit,table_data(i,2) - y_axis_unit, sprintf('%d', i), 'color', 'c', 'fontweight', 'bold');
            else
                
                plot(plot_h, table_data(i,1),table_data(i,2),'r--o');
                x_axis_unit = (max(table_data(:,1)) - min(table_data(:,1))) / 14;
                y_axis_unit = (max(table_data(:,2)) - min(table_data(:,2))) / 14;
                text(table_data(i,1) - x_axis_unit,table_data(i,2) - y_axis_unit, sprintf('%d', i), 'color', 'r', 'fontweight', 'bold');
            end
            axis([min(table_data(:,1)) - 1, max(table_data(:,1)) + 1, min(table_data(:,2)) - 1, max(table_data(:,2)) + 1])
            title('Agent Positions')
            xlabel('x-Position')
            ylabel('y-Position')
            hold on
        end
        
        for i = 1:dimension
            for j = 1:dimension
                if A(i,j) == 1
                    arrow([table_data(i,1),table_data(i,2)],[table_data(j,1),table_data(j,2)], 'facecolor', 'b', 'edgecolor', 'b', 'length', 6);
                end
            end
        end
        
        if get(list,'value') == 3
            if offset_check == 0
                radii = table_data(:,4);
            elseif offset_check == 1
                radii = table_data(:,6);
            end
            for i = 1:dimension
                viscircles(plot_h,[table_data(:,1), table_data(:,2)],radii,'EdgeColor', 'g', 'LineStyle', '--', 'LineWidth', 1);
            end
        end
        
        
        
        for i = 1:2:2*dimension - 1
            z = count;
            diff(z,(i + 1) / 2) = pdist([x(i) x(i+1); avg]);
        end
        
        plot_2_h = subplot(2,1,2,'parent',uip);
        for i = 1:count
            plot(plot_2_h, linspace(0, count, count), diff);
            title('Distances from Average')
            xlabel('Time Steps')
            ylabel('Distance')
        end
        
        %------------------------------------------------------------------
        %------------------------------------------------------------------
        
        %Again, horizontally concatenating the positions of the agents in
        %the history matrix.
        H = horzcat(H,x);
        
        set(H_handle,'data',H);
        count = count + 1;
        pause(0.01);
        hold off
        
    end
end

set(breakpt, 'data', [0]);

assignin('base','H', H);
assignin('base','offset_vector',offset_vector);
assignin('base','offset_temp',offset_temp);
end



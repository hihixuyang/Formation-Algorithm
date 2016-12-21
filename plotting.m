function plotting( handle, evt, table, adj, list,network_size)
%This function plots the table data on the upper plot before running the
%consensus algorithm.

table_data = get(table, 'data');
dim = str2double(get(network_size,'string'));
    

if get(list,'value') == 4
    A = evalin('base','A');
    set(adj,'data',A);
    
elseif get(list,'value') == 3
    A = [];
    A = (evalin('base', sprintf('A%d', 1)));
    set(adj,'data',A);
end


A = get(adj,'data');

if get(list,'value') == 1
    A = cyclegraph(dim);
    set(adj,'data',A);
end

uip = uipanel('Position',[0.01 0.01 0.56 0.98]);

for i = 1:dim
    plot_h = subplot(2,1,1,'parent',uip);
    %plotting for stubborn agents - they are plotted in a different color.
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

%Plots arrows to show directed connections between agents.
for i = 1:dim
    for j = 1:dim
        if A(i,j) == 1
            arrow([table_data(i,1),table_data(i,2)],[table_data(j,1),table_data(j,2)], 'facecolor', 'b', 'edgecolor', 'b', 'length', 6);
        end
    end
end

%Makes an empty plot which will track the distances from the average.
for i = 1:dim
    plot_2_h = subplot(2,1,2,'parent',uip);
    title('Distances from Average')
    xlabel('Time Steps')
    ylabel('Distance')
    hold on
end

hold off
end

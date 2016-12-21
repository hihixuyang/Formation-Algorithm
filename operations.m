function operations( handle, evt, adj, table, switch_num, switch_text, offset, I)
%This function checks which type of graph is chosen within the GUI and
%returns the adjacency matrix for cyclic and path graphs (by using the
%network size) or prompts you to enter in the adjacency matrix in the
%workspace. 


graph_type = get(handle,'value');
table_data = get(table,'data');
dim = size(table_data,1);
offset_check = get(offset, 'value');


A = zeros(dim);
if offset_check == 0
    if graph_type == 1
        A = cyclegraph(dim);
        table_data = table_data(1:dim, 1:3);
        set(switch_num, 'visible', 'off');
        set(switch_text, 'visible', 'off');
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay'});
        set(table, 'columnwidth', {50 50 50 50 100});
        set(table, 'columneditable', [true, true, true]);
        set(table, 'position', [0.66 0.41 0.33 0.38])
    elseif graph_type == 2
        A = pathgraph(dim);
        table_data = table_data(1:dim, 1:3);
        set(switch_num, 'visible', 'off');
        set(switch_text, 'visible', 'off');
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay'});
        set(table, 'columnwidth', {50 50 50 50 100});
        set(table, 'columneditable', [true, true, true]);
        set(table, 'position', [0.66 0.41 0.33 0.38])    
    elseif graph_type == 3
        disp('Please enter the # of graphs in the GUI and enter in the adjacency matrices for your graphs in the command window (ex. A1 = [...]; and A2 = [...];)')
        set(switch_num, 'visible', 'on');
        set(switch_text, 'visible', 'on');
        table_data = table_data(1:dim, 1:3);
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay'});
        set(table, 'columnwidth', {50 50 50 50 100});
        set(table, 'columneditable', [true, true, true]);
        set(table, 'position', [0.66 0.41 0.33 0.38])
    elseif graph_type == 4
        disp('Please enter the adjacency matrix for your graph: (ex. A = [...];)')
        table_data = table_data(1:dim, 1:3);
        set(switch_num, 'visible', 'off');
        set(switch_text, 'visible', 'off');
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay'});
        set(table, 'columnwidth', {50 50 50 50 100});
        set(table, 'columneditable', [true, true, true]);
        set(table, 'position', [0.66 0.41 0.33 0.38])
    end
    
elseif offset_check == 1
    if graph_type == 1
        A = cyclegraph(dim);
        table_data = table_data(1:dim, 1:5);
        set(switch_num, 'visible', 'off');
        set(switch_text, 'visible', 'off');
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay', 'offset x', 'offset y'});
        set(table, 'columnwidth', {50 50 50 50 50 50});
        set(table, 'columneditable', [true, true, true true true]);
        set(table, 'position', [0.66 0.41 0.33 0.38])
    elseif graph_type == 2
        A = pathgraph(dim);
        table_data = table_data(1:dim, 1:5);
        set(switch_num, 'visible', 'off');
        set(switch_text, 'visible', 'off');
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay', 'offset x', 'offset y'});
        set(table, 'columnwidth', {50 50 50 50 50 50});
        set(table, 'columneditable', [true, true, true true true]);    
    elseif graph_type == 3
        disp('Please enter the # of graphs in the GUI and enter in the adjacency matrices for your graphs in the command window (ex. A1 = [...]; and A2 = [...];)')
        set(switch_num, 'visible', 'on');
        set(switch_text, 'visible', 'on');
        table_data = table_data(1:dim, 1:5);
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay', 'offset x', 'offset y'});
        set(table, 'columnwidth', {50 50 50 50 50});
        set(table, 'columneditable', [true, true, true, true, true]);
        set(table, 'position', [0.66 0.41 0.33 0.38])    
    elseif graph_type == 4
        disp('Please enter the adjacency matrix for your graph: (ex. A = [...];)')
        table_data = table_data(1:dim, 1:5);
        set(switch_num, 'visible', 'off');
        set(switch_text, 'visible', 'off');
        set(table, 'data', table_data);
        set(table, 'columnname', {'x', 'y', 'delay', 'offset x', 'offset y'});
        set(table, 'columnwidth', {50 50 50 50 50});
        set(table, 'columneditable', [true, true, true, true, true]);
        set(table, 'position', [0.66 0.41 0.33 0.38])
    end
end

set(adj, 'data', A);

end


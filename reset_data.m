function reset_data( handle, evt, table, table_data, network_size, offset)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
tabledata = get(table_data, 'data');
data_size = size(get(table_data,'data'),1);
dim = str2double(get(network_size,'string'));
offset_check = get(offset, 'value');

if offset_check == 1
    if dim > data_size
        adj_tabledata = vertcat(tabledata(1:data_size,:),zeros(dim - data_size,5));
        set(table, 'data', adj_tabledata);
        set(table, 'columneditable', [true, true, true, true, true]);
    else
        set(table, 'data', tabledata(1:dim,:));
        
    end
elseif offset_check == 0
    if dim > data_size
        adj_tabledata = vertcat(tabledata(1:data_size,:),zeros(dim - data_size,3));
        set(table, 'data', adj_tabledata);
    else
        set(table, 'data', tabledata(1:dim,:));
        
        
    end
end
end


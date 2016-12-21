function dim_table( handle, evt, table, offset )
%This changes the size of editable table in the GUI (where data can
%be inputted) as function of which network size is inputted. Note that
%checking offset will extend the table data by one column so that offsets
%can be inputted.

row_dim = str2double(get(handle,'string'));
orig_data = get(table,'data');
orig_dim = size(orig_data, 1);
offset_check = get(offset, 'value');

if offset_check == 1
    if row_dim > orig_dim
        set(table,'data',vertcat(orig_data, zeros((row_dim - orig_dim),7)));
    elseif row_dim < orig_dim
        set(table,'data',orig_data(1:row_dim,:));
    end
elseif offset_check == 0
    if row_dim > orig_dim
        set(table,'data',vertcat(orig_data, zeros((row_dim - orig_dim),3)));
    elseif row_dim < orig_dim
        set(table,'data',orig_data(1:row_dim,:));
    end
end
end


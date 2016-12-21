function offset_input( handle, evt, tabledata, table )
%This function extends the table by one column when the offset checkbox is
%checked so that offset data can be inputted in the GUI.

orig_data = get(tabledata,'data');
orig_dim = size(get(table,'data'),1);

if get(handle,'value') == 1
    orig_data = horzcat(orig_data, zeros(orig_dim,2));
    set(table, 'columnname', {'x', 'y', 'delay', 'offset x', 'offset y'});
    set(table, 'columneditable', [true true true true true]);
    set(table, 'data', orig_data);
else
    orig_data = orig_data(1:orig_dim, 1:3);
    set(table, 'columnname', {'x', 'y', 'delay'});
    set(table, 'columneditable', [true true true]);
end

set(tabledata, 'data', orig_data);

end


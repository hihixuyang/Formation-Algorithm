clc; clear all; close all;
%create figure
figure_h = figure;


% Sets original size of network & time delay
dim = 8;

%--------------------------------------------------------------------------
% # of Nodes static text                    
uicontrol('Style','text',...
            'units','normalized',...
            'position',[0.86 0.925 0.07 0.06],...
            'String','# of Agents'); 

%--------------------------------------------------------------------------
% # of Graphs text appears when a "switching graph" is chosen from the
%graph list
switch_text_h = uicontrol('Style','text',...
            'visible', 'off',...
            'units','normalized',...
            'position',[0.58 0.87 0.2 0.03],...
            'String','# of Switching Graphs');

        
%--------------------------------------------------------------------------
% Makes handle for tabledata
a= 10;
b= -10;


tabledata = [((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 -10 0; ((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 10 0; ((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 0 10; ((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 0 -10; ((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 6 8; ((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 6 -8; ((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 -6 8; ((b-a)*rand(1,1)+a) ((b-a)*rand(1,1)+a) 0 -6 -8]; 
tabledata_h = uitable('visible', 'off',...
                        'data', tabledata);




%--------------------------------------------------------------------------
% Makes handle for break point (for reset button)
break_h = uitable('visible', 'off');

%--------------------------------------------------------------------------
% Makes handle for adjacency matrix, which stores data in a uitable that is
% invisible on the GUI.
A_h = uitable('visible', 'off');

%--------------------------------------------------------------------------
% Makes handle for history matrix. This data can be accessed in the
% workspace.
H_h = uitable('visible', 'off');

%--------------------------------------------------------------------------
% Make editable control for number of switch graphs, which becomes visible
% when a "switching graph" is chosen from the graph list.
switch_h = uicontrol('style', 'edit',...
                    'visible', 'off',...
                    'units', 'normalized',...
                    'position', [0.673 0.815 0.05 0.05]); 
                              
%--------------------------------------------------------------------------
% Make data table
table_h = uitable('units', 'normalized',...
                    'position', [0.66 0.41 0.33 0.38],...
                    'columnname', {'x', 'y', 'delay'},...
                    'columnwidth', {50 50 50 50},...
                    'columneditable', [true, true, true],...
                    'data', get(tabledata_h,'data'),...
                    'backgroundcolor', [0.7 0.8 0.9; 0.9 0.9608 0.4]);

%--------------------------------------------------------------------------
% Make editable control for number of switching graphs
offset_h = uicontrol('style', 'checkbox',...
                    'units', 'normalized',...
                    'string', 'Allow Offset',...
                    'position', [0.7 0.9 0.15 0.1],...
                    'callback', {@offset_input, tabledata_h, table_h}); 
                
%--------------------------------------------------------------------------
% Graph generator list
list_h = uicontrol('style', 'listbox',...
                'units','normalized',...
                'position', [0.79 0.82 0.2 0.08],...
                'string', {'Cycle Graph'; 'Path Graph'; 'Switching Graph'; 'Custom'},...
                'callback',{@operations, A_h, table_h, switch_h, switch_text_h, offset_h});

%--------------------------------------------------------------------------              
% Set network size, passes handle to dim_table.m function to make table
% size as desired.
network_size_h = uicontrol('style', 'edit',...
                        'units', 'normalized',...
                        'position', [0.94 0.93 0.05 0.05],...
                        'string', dim,...
                        'callback', {@dim_table,table_h,offset_h});                  

%--------------------------------------------------------------------------                    
% Plot nodes, passes handle to plotting.m function
plot_h = uicontrol('style', 'pushbutton',...
                'string', 'Plot Graph',...
                'units', 'normalized',...
                'position', [0.79 0.32 0.2 0.08],...
                'callback', {@plotting, table_h, A_h, list_h, network_size_h});
            
%--------------------------------------------------------------------------           
% Average nodes in discrete play mode, passes handle to collectiveavg.m fn
avg_h = uicontrol('style', 'pushbutton',...
        'string', 'Average',...
        'units', 'normalized',...
        'position', [0.79 0.24 0.2 0.08],...
        'callback', {@collectiveavg, table_h, A_h, H_h, list_h, break_h, switch_h, offset_h, network_size_h});

%--------------------------------------------------------------------------                    
% Reset button - resets to original tabledata value
reset_h = uicontrol('style', 'pushbutton',...
                'string', 'Reset',...
                'units', 'normalized',...
                'position', [0.79 0.08 0.2 0.08],...
                'callback', {@reset_data, table_h, tabledata_h, network_size_h, offset_h});

%--------------------------------------------------------------------------                    
% Stop button - resets to original tabledata value
stop_h = uicontrol('style', 'pushbutton',...
                'string', 'Stop',...
                'units', 'normalized',...
                'position', [0.79 0.16 0.2 0.08],...
                'callback', {@stop, break_h});                     


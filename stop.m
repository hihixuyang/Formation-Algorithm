function stop( handle, evt, breakpt )
%This sets the breakpoint as 1 so that the while loop within the
%collectiveavg.m will exit when the "stop" button is pressed in the GUI
%   Detailed explanation goes here

set(breakpt,'data', [1]);

end


function out = select_eeg(a, newTable)
%SELECT_EEG Summary of this function goes here
%   Detailed explanation goes here

arguments
    a
    newTable
end

%% Initiating
out = [];

%% Parsing Selection
new_name = newTable.Name{:};
% Determine if Class exists
if any(strcmpi('Class', newTable.Properties.VariableNames))
    new_class = newTable.Class{:};
else
    new_class = [];
end

%% Types
if strcmp(new_class, 'struct') 
    if numel(fields(a.Data.eeg.nest))==0
        a.Data.eeg.nest = struct('field_name', ".", 'base', string(new_name));
    else
        a.Data.eeg.nest.field_name = new_name;
    end
    % Re-run file selection
    a.Data.eeg.flag = a.Data.eeg.flag + "struct";
    return
else
    a.Data.eeg.flag = new_class;
end

% Load
out = a.Data.eeg.temp_load.(new_name);


end


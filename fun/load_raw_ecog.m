function load_raw_ecog(a, filepath, event)
%LOAD_RAW_ECOG Summary of this function goes here
%   Detailed explanation goes here

arguments
    a
    filepath    char
    event
end

% if source of click is for new load... 
if strcmp(event.Source.Text, 'Load Neural')
    % reset
    eeg = struct( ... 
            'temp_load', [], ...
            'nest', struct, ...
            'files', [], ...
            'flag', "", ...
            'last_val_load', [], ...
            'original', []);
    a.Data.eeg = eeg;
    a.byPCBButtonGroup.SelectedObject = a.AllButton;
    new_msg = sprintf(">>Loading new file");
    a.TextArea_3.Value = vertcat(a.TextArea_3.Value, new_msg);
end

% first time load
if isempty(a.Data.eeg.temp_load)
    info = matfile(filepath);

    % remove 'Properties' from matfile loading
    field_names = fields(info);
    if strcmp(field_names{1}, 'Properties')
        field_names = field_names(2:end);
    end

    % update
    a.Data.eeg.temp_load = info;    % still MatFile
end

% 2+ loads
if numel(fields(a.Data.eeg.nest))
    
    % update temp_load
    if isequal(class(a.Data.eeg.temp_load), 'matlab.io.MatFile')
        nest_name = a.Data.eeg.nest.base;
        a.Data.eeg.temp_load = a.Data.eeg.temp_load.(nest_name);
    end
    
    % info and field_names
    try
    if startsWith(a.Data.eeg.nest.field_name, '.')          % base struct
        % remove "." and update
        new_fieldname = a.Data.eeg.nest.field_name(2:end);
        a.Data.eeg.nest.field_name = new_fieldname;
        % set
        info = a.Data.eeg.temp_load;
    else                                                    % nested
        % update temp load
        nest_name = a.Data.eeg.nest.field_name;
        a.Data.eeg.temp_load = a.Data.eeg.temp_load.(nest_name);
        % set
        info = a.Data.eeg.temp_load;
    end
    catch
    error("Something wrong with nested structure load")
    end

    field_names = fields(info);

end

% check if proper load
if isempty(field_names)
    a.Data.eeg.flag = a.Data.eeg.flag + " No fields to load.";
    return
end

% create table
table_names = {'Name', 'Size', 'Class'};
out = cell2table(cell(0, numel(table_names)), 'VariableNames', table_names);
for i = 1:numel(field_names)
    name = field_names{i};
    field_class = class(info.(name));
    field_size = num2str(size(info.(name)));
    new_line = {name, field_size, field_class};
    out = [out; new_line];
end

% Update encoding
a.Data.eeg.files = out;
end


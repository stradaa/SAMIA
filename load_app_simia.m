function load_app_simia(app, lbls)
%LOAD_SIMIA Labels and Format
%
% Inputs:
%   lbls: cell (labels x 5)
%   pos3d: double (5 x 3 x frame)
%
% Outputs:
%  
%
% 4-9-2024 - Alex Estrada %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arguments
    app
    lbls         cell
end


try
    T = cell2table(lbls, "VariableNames", ...
                    {'Label', 'frame_0', 'frame_end', 'sec_0', 'sec_end'});

    app.TextArea_2.Value = '';
    msg = '>> Successfully loaded SIMIA labels';
    app.TextArea_2.Value = sprintf([repmat('%s\n', 1, numel(app.TextArea_2.Value)) '%s\n'], ...
                                      app.TextArea_2.Value{:}, msg);

    % Get info on simia label files
    unique_label = unique(T.Label);
    app.ListBox_2.Items = unique_label;

    for i = 1:length(unique_label)
        temp = T(strcmp(T.Label, unique_label{i}), :);
        temp_len = size(temp, 1);
        avg_reach_time = mean(temp.sec_end - temp.sec_0);
        longest_reach = max(temp.sec_end - temp.sec_0);
        shortest_reach = min(temp.sec_end - temp.sec_0);

        % print info
        msg = sprintf(['---------------\n'...
                       'Found %d Labels: %s\n' ...
                       '      Average Segment Time: %.2f sec\n' ...
                       '      Longest Segment Time: %.2f sec\n' ...
                       '      Shortest Segment Time: %.2f sec\n\n'], ...
                 temp_len, ...
                 unique_label{i}, ...
                 avg_reach_time, ...
                 longest_reach, ...
                 shortest_reach);
        app.TextArea_2.Value = sprintf([repmat('%s\n', 1, numel(app.TextArea_2.Value)) '%s\n'], ...
                                      app.TextArea_2.Value{:}, msg);
    end
    
catch
   msg = 'Something went wrong! :(';
   app.TextArea_2.Value = sprintf([repmat('%s\n', 1, numel(app.TextArea_2.Value)) '%s\n'], ...
                                      app.TextArea_2.Value{:}, msg);
end


function T = load_simia(day, rec, t_rec_dlc)
%LOAD_SIMIA Labels and Format
%
% Inputs:
%   day:      'yymmdd'
%   rec:      '###'
%   t_rec_dlc: double (optional)
%
% Outputs:
%   T: formatted table labels 
%
%
% 3-25-2024 - Alex Estrada %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

arguments
    day         (1,6)   char
    rec         (1,3)   char
    t_rec_dlc           double = []
end

T = [];
simia = ['SIMIA_label_segmentsimageDLC_resnet50_goose_' day '_' rec ...
         '_005Nov7shuffle1_1030000_filtered_labeled.mp4.mat'];
try
    % Load file
    t = load(simia);
    % Format
    T = cell2table(t.t_to_save, "VariableNames", ...
                    {'Label', 'frame_0', 'frame_end', 'sec_0', 'sec_end'});
    fprintf('Successfully loaded SIMIA labels: %s\n', simia)

    % Get info on simia label files
    unique_label = unique(T.Label);
    for i = 1:length(unique_label)
        temp = T(strcmp(T.Label, unique_label{i}), :);
        temp_len = size(temp, 1);
        avg_reach_time = mean(temp.sec_end - temp.sec_0);
        longest_reach = max(temp.sec_end - temp.sec_0);
        shortest_reach = min(temp.sec_end - temp.sec_0);

        % print info
        fprintf('Found %d Labels: %s\n', temp_len, unique_label{i})
        fprintf(['      Average Segment Time: %.2f sec\n' ...
                 '      Longest Segment Time: %.2f sec\n' ...
                 '      Shortest Segment Time: %.2f sec\n\n'], ...
                 avg_reach_time, ...
                 longest_reach, ...
                 shortest_reach);
    end
    
    % add the info if DLC exists
    if ~isempty(t_rec_dlc)
        % ensure t_rec_dlc and T are compatible
        max_label_frame = max(T.frame_end);
        if max_label_frame > length(t_rec_dlc)
            disp("SIMIA Label file and t_rec_dlc are not compatible")
            return
        end

        % get associated t_rec_times
        t_rec_times = [t_rec_dlc(T.frame_0); t_rec_dlc(T.frame_end)]';
        % create temp table
        tempTable = array2table(t_rec_times, 'VariableNames', {'t_rec_dlc_0', 't_rec_dlc_end'});
        % concatenate with main table
        T = [T, tempTable];

        disp("--Successfully added associated DLC times on labels--")
    end
catch
   disp("Something went wrong! :( Check for pathing!")
   fprintf("Make sure the file: %s is in path", simia)
end


function good_reach_idx = reach_segmentation(x, dist_x, thresh, min_duration)
%REACH_SEGMENTATION Summary of this function goes here

good_reach_idx = [];
segment_start = 1;

for i = 1:length(dist_x)
    % check if greater than cooldown or if last element
    if dist_x(i) > thresh || i == length(dist_x)
        % Add segment if eligible
        if i - segment_start >= min_duration
            % Check if at end and eligible
            if dist_x(i) <= thresh && i == length(dist_x)
                good_reach_idx = [good_reach_idx, x(segment_start:i+1)];
            else
                good_reach_idx = [good_reach_idx, x(segment_start:i)];
            end
        end
        % Update next segment start
        segment_start = i + 1;
    end
end


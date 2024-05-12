function [est_day, est_rec, est_monkey] = parse_vid_name(filename)
%PARSE_VID_NAME Summary of this function goes here
%   Detailed explanation goes here

arguments
    filename char
end

% Extract the first 6-digit number
sixDigitPattern = '\d{6}';
sixDigits = regexp(filename, sixDigitPattern, 'match');
if ~isempty(sixDigits)
    est_day = sixDigits{1}; % Save the first matched 6-digit number
else
    est_day = ''; % Or handle the case where no 6-digit number is found
end

% Extract the three digit number following 'rec' or the first lone three digit number
threeDigitPattern = 'rec(\d{3})';
threeDigits = regexp(filename, threeDigitPattern, 'match');
if ~isempty(threeDigits)
    est_rec = threeDigits{1}(4:end); % Extracting the number part after 'rec'
else
    % If 'rec' is not found, look for any lone three-digit number
    loneThreeDigitPattern = '(?<!\d)\d{3}(?!\d)';
    loneThreeDigits = regexp(filename, loneThreeDigitPattern, 'match');
    if ~isempty(loneThreeDigits)
        est_rec = loneThreeDigits{1};
    else
        est_rec = '989'; % Default value if no suitable three-digit number is found
    end
end

% Check for specific words and assign to est_monkey
keywords = {'goose', 'troopa', 'jester'};
est_monkey = 'coco'; % Default value
for i = 1:length(keywords)
    if contains(filename, keywords{i})
        est_monkey = keywords{i};
        break; % Stop searching once a match is found
    end
end

end


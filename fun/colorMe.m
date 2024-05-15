function app = colorMe(app,colorScheme)
%COLORME determines color scheme for GraFT App
%   Sets the color HEX values for given scheme. The goal is to support
%   multiple color options (dark mode, light mode, etc) for better
%   readability and overall usage satisfaction.

%% Color Pallete
colors = cell(20,1);
colors{1} = '#000000';  % black
colors{2} = '#FFFFFF';  % white
colors{3} = '#303C4D';  % 
colors{5} = '#0D1117';  % black background
colors{4} = '#161B22';  % gray
colors{6} = '#43A0EB';  % highlight blue
colors{7} = '#238636';  % github green

colors{8} = '#02052c';  % simia_background
colors{9} = '#fef5d1';  % bright simia highlight
colors{10} = '#fde6b2'; % cream simia highlight
colors{11} = '#5E87C9'; % bright blue
colors{13} = '#2D2D2D'; % 
colors{12} = '#191919'; %'

%% Determine Color Selection
% FontWeight - Bold
fwHandle = findobj(app.UIFigure, '-property', 'FontWeight',...
                                 '-property', 'FontColor');
fwBold = fwHandle(strcmp(get(fwHandle, 'FontWeight'), 'bold'));
fwNormal = fwHandle(strcmp(get(fwHandle, 'FontWeight'), 'normal'));

% Border Type - Lined
btHandle = findobj(app.UIFigure, '-property', 'BorderType');
btLined = btHandle(strcmp(get(btHandle, 'BorderType'), 'line'));

% Border Type - None
btNone = btHandle(strcmp(get(btHandle, 'BorderType'), 'none'));

% Grids Type - ALL
gdHandle = findobj(app.UIFigure, 'Type', 'uigridlayout');

% Buttons Type - ALL
bttnHandle = findobj(app.UIFigure, 'Type', 'uibutton');

% ListBoxes - ALL
lbxHandle = findobj(app.UIFigure, 'Type', 'uilistbox');

% Text Fields - ALL
txtaHandle = findobj(app.UIFigure, 'Type', 'uitextarea');

% State Buttons - ALL
stbtnHandle = findobj(app.UIFigure, 'Type', 'uistatebutton');

% Drop Downs - ALL
dbHandle = findobj(app.UIFigure, 'Type', 'uidropdown');

% Spinner - ALL
spinHandle = findobj(app.UIFigure, 'Type', 'uispinner');

% Number Edit Fields - ALL
efHandle = findobj(app.UIFigure, 'Type', 'uinumericeditfield');

% Text Edit Fields - ALL
tefHandle = findobj(app.UIFigure, 'Type', 'uieditfield');

% Tables - ALL 
% tbl_Handle = findobj(app.UIFigure, 'Type', 'uitable');

switch colorScheme
    case 'DarkMode'
        % FontColor Label -FontWeight -Bold
        set(fwBold, {'FontColor'}, repmat(colors(2), size(fwBold)));

        % FontColor Label -FontWeight -Normal
        set(fwNormal, {'FontColor'}, repmat(colors(2), size(fwNormal)));

        % ForeGround Color -Panel -BoderType -Lined
        set(btLined, {'ForegroundColor'}, repmat(colors(6), size(btLined)));
        set(btLined, {'BackgroundColor'}, repmat(colors(4), size(btLined)));

        % ForeGround Color -Panel -BoderType -None
        set(btNone, {'ForegroundColor'}, repmat(colors(2), size(btNone)));
        set(btNone, {'BackgroundColor'}, repmat(colors(4), size(btNone)));

        % Grids
        set(gdHandle, {'BackgroundColor'}, repmat(colors(4), size(gdHandle)));

        % Buttons
        set(bttnHandle, {'BackgroundColor'}, repmat(colors(5), size(bttnHandle)));
        
        % ListBox
        set(lbxHandle, {'BackgroundColor'}, repmat(colors(5), size(lbxHandle)));

        % TextAreas
        set(txtaHandle, {'BackgroundColor'}, repmat(colors(5), size(txtaHandle)));
        
        % State Button
        set(stbtnHandle, {'BackgroundColor'}, repmat(colors(5), size(stbtnHandle)));

        % Drop Downs
        set(dbHandle, {'BackgroundColor'}, repmat(colors(4), size(dbHandle)));

        % Spinners
        set(spinHandle, {'BackgroundColor'}, repmat(colors(4), size(spinHandle)));

        % Edit Field (Numeric)
        set(efHandle, {'BackgroundColor'}, repmat(colors(1), size(efHandle)));
        
        % Edit Field (Text)
        set(tefHandle, {'BackgroundColor'}, repmat(colors(1), size(tefHandle)));

        % ListBox
        % set(tbl_Handle, {'BackgroundColor'}, repmat([0 0 0], 2, 1));    % doesn't work

    case 'Simia'

        % FontColor Label -FontWeight -Bold
        set(fwBold, {'FontColor'}, repmat(colors(2), size(fwBold)));

        % FontColor Label -FontWeight -Normal
        set(fwNormal, {'FontColor'}, repmat(colors(2), size(fwNormal)));

        % ForeGround Color -Panel -BoderType -Lined
        set(btLined, {'ForegroundColor'}, repmat(colors(11), size(btLined)));
        set(btLined, {'BackgroundColor'}, repmat(colors(13), size(btLined)));

        % ForeGround Color -Panel -BoderType -None
        set(btNone, {'ForegroundColor'}, repmat(colors(2), size(btNone)));
        set(btNone, {'BackgroundColor'}, repmat(colors(13), size(btNone)));

        % Grids
        set(gdHandle, {'BackgroundColor'}, repmat(colors(12), size(gdHandle)));

        % Buttons
        set(bttnHandle, {'BackgroundColor'}, repmat(colors(1), size(bttnHandle)));
        
        % ListBox
        set(lbxHandle, {'BackgroundColor'}, repmat(colors(13), size(lbxHandle)));

        % TextAreas
        set(txtaHandle, {'BackgroundColor'}, repmat(colors(13), size(txtaHandle)));
        
        % State Button
        set(stbtnHandle, {'BackgroundColor'}, repmat(colors(1), size(stbtnHandle)));

        % Drop Downs
        set(dbHandle, {'BackgroundColor'}, repmat(colors(1), size(dbHandle)));

        % Spinners
        set(spinHandle, {'BackgroundColor'}, repmat(colors(1), size(spinHandle)));

        % Edit Field (Numeric)
        set(efHandle, {'BackgroundColor'}, repmat(colors(1), size(efHandle)));
        
        % Edit Field (Text)
        set(tefHandle, {'BackgroundColor'}, repmat(colors(1), size(tefHandle)));
end

% X = x;
% Y = y;
% 
% % fix bad channels
% for i = 1:length(bad_ch)
%     index = bad_ch(i);
%     X(index) = [];
%     Y(index) = [];
% end
% 
%  % Prepare the figure and scatter plot
% fig = figure;
% scatterPlot = scatter(X, Y, 200, 'filled'); % 100 is the marker size
% colorbar; % Add a colorbar to indicate voltage scale
% clim([min(temp_save(:)), max(temp_save(:))]); % Set the color axis scaling according to min and max voltage
% axis equal;
% xlabel('X Position');
% ylabel('Y Position');
% title('Electrode Voltage Activity');
% 
% % Number of frames
% % numFrames = size(temp_save, 2);
% numFrames = 10000;
% 
% % Loop through each time point and update the scatter plot
% for t = 1:numFrames
%     % Update the color data for each point
%     scatterPlot.CData = temp_save(:, t);
%     title(sprintf('Electrode Voltage Activity at Time %d', t));
%     drawnow;
% 
%     % Pause for the specified time to control the frame rate
%     pause(0.001);
% end
% 
% 
% %%%%%%%%%%%%%%%%%%%%%%%%
% 
% % Define the grid limits
% gridX = linspace(min(X), max(X), 100); % 100 can be adjusted for finer resolution
% gridY = linspace(min(Y), max(Y), 100); % 100 can be adjusted for finer resolution
% [gridX, gridY] = meshgrid(gridX, gridY);
% 
% % Prepare the figure
% fig = figure;
% colormap jet; % Set the colormap (can be adjusted as needed)
% colorBar = colorbar;
% clim([min(temp_save(:)), max(temp_save(:))]); % Set the color axis scaling according to min and max voltage
% hold on;
% axis equal;
% xlabel('X Position');
% ylabel('Y Position');
% title('Interpolated Electrode Voltage Activity');
% 
% % Loop through each time point
% for t = 1:size(temp_save, 2)
%     % Interpolate data onto the grid
%     Z = griddata(X, Y, temp_save(:, t), gridX, gridY, 'natural'); % 'natural' method can be changed as needed
% 
%     % Display the data
%     imagesc(gridX(1,:), gridY(:,1), Z);
%     set(gca, 'YDir', 'normal'); % Ensure the y-axis is not flipped
%     colorBar.Label.String = 'Voltage (mV)'; % Update colorbar label
%     title(sprintf('Interpolated Voltage Activity at Time %d', t));
%     drawnow;
% 
%     % Pause for the specified time to control the frame rate
%     pause(0.000001);
% end

end





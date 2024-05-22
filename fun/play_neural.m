function play_neural(app, event)
%PLAY_NEURAL Summary of this function goes here
%   Detailed explanation goes here
arguments
    app
    event
end

if strcmp(event.Source.Text, 'Play')
    if app.Slider_3.Value == app.Status.neural.max_idx
        app.Slider_3.Value = 1;
    end
    app.Status.neural.play = true;
    app.PlayButton_2.Text = 'Stop';
else
    app.Status.neural.play = false;
    app.PlayButton_2.Text = 'Play';
end

colormap(app.UIAxes6, app.DropDown_2.Value);
frameSkip = app.FrameStepEditField.Value;  % Display every n-th frame

switch app.DropDown_3.Value
    case 'Scatter'
        while app.Status.neural.play
            % read frame from slider
            app.Status.neural.idx = round(app.Slider_3.Value);
            
            if mod(app.Status.neural.idx, frameSkip) == 0
                
                app.Data.eeg.scatterPlot.CData = app.Data.eeg.original(app.Status.neural.selected, app.Status.neural.idx);
                title(app.UIAxes6, sprintf('Electrode Voltage Activity at Frame %d', app.Status.neural.idx));
                
                if frameSkip < 3
                    drawnow
                else
                    drawnow limitrate
                end
            end

            % check if ending
            if app.Status.neural.idx == app.Status.neural.max_idx
                app.Status.neural.play = false;
                app.PlayButton_2.Text = 'Play';
            else
                app.Slider_3.Value = app.Status.neural.idx + 1;
            end
        end

    case 'Grid'
        % Loop through each time point
        while app.Status.neural.play
            % read frame from slider
            app.Status.neural.idx = round(app.Slider_3.Value);
            if mod(app.Status.neural.idx, frameSkip) == 0
                % Interpolate data onto the grid
                Z = griddata(app.Data.eeg.el_x(app.Status.neural.selected), ...
                             app.Data.eeg.el_y(app.Status.neural.selected), ...
                             app.Data.eeg.original(app.Status.neural.selected, app.Status.neural.idx), ...
                             app.Data.eeg.gridX, ...
                             app.Data.eeg.gridY, ...
                             'natural'); % test different ones?
                % Display the data
                imagesc(app.UIAxes6, ...
                        app.Data.eeg.gridX(1,:), ...
                        app.Data.eeg.gridY(:,1), Z);
                set(app.UIAxes6, 'yDir', 'normal');
                title(app.UIAxes6, sprintf('Interpolated Electrode Voltage Activity at Frame %d', app.Status.neural.idx));
                
                if frameSkip < 3
                    drawnow
                else
                    drawnow limitrate
                end
                
            end

            if app.Status.neural.idx == app.Status.neural.max_idx
                app.Status.neural.play = false;
                app.PlayButton_2.Text = 'Play';
            else
                app.Slider_3.Value = app.Status.neural.idx + 1;
            end

        end
       
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

end


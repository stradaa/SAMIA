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


switch app.DropDown_3.Value
    case 'Scatter'
        
        while app.Status.neural.play
            % read frame from slider
            app.Status.neural.idx = round(app.Slider_3.Value);
            app.Data.eeg.scatterPlot.CData = app.Data.eeg.original(:,app.Status.neural.idx);
            title(app.UIAxes6, sprintf('Electrode Voltage Activity at Frame %d', app.Status.neural.idx));
            drawnow;

            pause(0.001)

            % check if ending
            if app.Status.neural.idx == app.Status.neural.max_idx
                app.Status.neural.play = false;
                app.PlayButton_2.Text = 'Play';
            else
                app.Slider_3.Value = app.Status.neural.idx + 1;
            end
        end

    case 'Grid'

end

end


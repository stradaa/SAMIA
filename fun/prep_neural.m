function prep_neural(app)
%PREP_NEURAL Summary of this function goes here
%   Detailed explanation goes here
arguments
    app
end

% Settings
marker_size = 150;

load_info = size(app.Data.eeg.original);

% Slider
app.Slider_3.Limits = [1, load_info(2)];
app.Slider_3.Value = 1;

% Drop Downs
app.DropDown_2.Value = 'jet';
app.DropDown_3.Value = 'Scatter';

% Plot
if isempty(app.Data.eeg.el_x)
    disp("Create genereic grid and alert the user")
else
    app.Data.eeg.scatterPlot = scatter(app.Data.eeg.el_x, ...
                                       app.Data.eeg.el_y, ...
                                       marker_size, 'filled', ...
                                       'Parent', app.UIAxes6);

    yticks(app.UIAxes6, []);yticklabels(app.UIAxes6, []);
    xticks(app.UIAxes6, []);xticklabels(app.UIAxes6, []);
    set(app.UIAxes6, 'Color', 'k', 'Xcolor', 'w','Ycolor', 'w', 'YGrid', 'on')
    set(get(app.UIAxes6, 'ylabel'), 'string', 'Y Position')
    set(get(app.UIAxes6, 'xlabel'), 'string', 'X Position')
    colorbar(app.UIAxes6, "Color",'w');
    title(app.UIAxes6, 'Electrode Positions', 'Color','w')
    clim(app.UIAxes6, [min(app.Data.eeg.original(:)), max(app.Data.eeg.original(:))]);
    axis(app.UIAxes6, 'padded')
end

% Enable idx for play
app.Status.neural.idx = 1;
app.Status.neural.max_idx = load_info(2);
app.PlayButton_2.Text = 'Play';
end

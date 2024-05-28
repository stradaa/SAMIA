function prep_neural(app)
%PREP_NEURAL Summary of this function goes here
%   Detailed explanation goes here
arguments
    app
end

%% Settings
marker_size = app.MarkerSizeEditField.Value;
load_info = size(app.Data.eeg.original);

% Selection
app.Status.neural.selected = [];
switch app.byPCBButtonGroup.SelectedObject.Text
    case 'All'
        app.Status.neural.selected = 1:load_info(1);
    case 'Arm 1'
        app.Status.neural.selected = find(app.Data.eeg.pcb_id==1 | app.Data.eeg.pcb_id==2);
    case 'Arm 2'
        app.Status.neural.selected = find(app.Data.eeg.pcb_id==3 | app.Data.eeg.pcb_id==4);
    case 'Arm 3'
        app.Status.neural.selected = find(app.Data.eeg.pcb_id==5 | app.Data.eeg.pcb_id==6);
    case 'Arm 4'
        app.Status.neural.selected = find(app.Data.eeg.pcb_id==7 | app.Data.eeg.pcb_id==8);
end

% Slider
pause(0.01)
app.Slider_3.MajorTickLabelsMode = 'auto';
app.Slider_3.Limits = [1, load_info(2)];
app.Slider_3.Value = 1;
new_values = linspace(1, load_info(2)/app.SamplingRateEditField.Value, length(app.Slider_3.MajorTickLabels));
% Convert the array to a cell array of strings
new_majorticklabels = arrayfun(@num2str, new_values, 'UniformOutput', false);
app.Slider_3.MajorTickLabels = new_majorticklabels;

% Drop Downs
app.DropDown_2.Value = 'jet';
app.DropDown_3.Value = 'Scatter';

%% Scatter (and show first by default)
if isempty(app.Data.eeg.el_x)
    disp("Create genereic grid and alert the user. TOTO")
    return
else
    app.Data.eeg.scatterPlot = scatter(app.Data.eeg.el_x(app.Status.neural.selected), ...
                                       app.Data.eeg.el_y(app.Status.neural.selected), ...
                                       marker_size, 'filled', ...
                                       'Parent', app.UIAxes6);

    yticks(app.UIAxes6, []);yticklabels(app.UIAxes6, []);
    xticks(app.UIAxes6, []);xticklabels(app.UIAxes6, []);
    colormap(app.UIAxes6, 'jet')
    set(app.UIAxes6, 'Color', 'k', 'Xcolor', 'w','Ycolor', 'w', 'YGrid', 'on')
    set(get(app.UIAxes6, 'ylabel'), 'string', 'Y Position')
    set(get(app.UIAxes6, 'xlabel'), 'string', 'X Position')
    colorbar(app.UIAxes6, "Color",'w');
    title(app.UIAxes6, 'Electrode Positions', 'Color','w')
    min_crange = min(app.Data.eeg.original(app.Status.neural.selected,:), [], 'all');
    max_crange = max(app.Data.eeg.original(app.Status.neural.selected,:), [], 'all');
    clim(app.UIAxes6, [min_crange, max_crange]);
    axis(app.UIAxes6, 'padded')
end

%% Grid
min_el_x = min(app.Data.eeg.el_x(app.Status.neural.selected));
max_el_x = max(app.Data.eeg.el_x(app.Status.neural.selected));
min_el_y = min(app.Data.eeg.el_y(app.Status.neural.selected));
max_el_y = max(app.Data.eeg.el_y(app.Status.neural.selected));

gridX = linspace(min_el_x, max_el_x, app.GridResolutionEditField.Value); 
gridY = linspace(min_el_y, max_el_y, app.GridResolutionEditField.Value);
[app.Data.eeg.gridX, app.Data.eeg.gridY] = meshgrid(gridX, gridY);

% Set default numbers automatically
app.Label_2.Text = string(load_info(2)/app.SamplingRateEditField.Value);

% Enable idx for play
app.Status.neural.idx = 1;
app.Status.neural.max_idx = load_info(2);
app.PlayButton_2.Text = 'Play';
end


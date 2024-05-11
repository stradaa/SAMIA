function app = setDefaultUI(app)
%SETDEFAULTUI Sets initial view of the app
% duh

%% Video Analysis
% Enable / Disable
app.PlayButton.Enable = 'off';
app.StartSegmentButton.Enable = 'off';
app.selectButton.Enable = 'off';
app.selectButton_2.Enable = 'off';
app.selectButton_3.Enable = 'off';
app.selectButton_4.Enable = 'off';
app.UIAxes.Visible = 'off';
app.Slider.Enable = 'off';
app.GridLayout24.Visible = 'off';
app.GotosegmentMenu.Enable = 'off';

% Defaults
app.FPSEditField.Value = 0;
app.Label.Text = pwd;
app.DropDown.Value = '.mat';
app.EditField.Value = 'Reach';
app.EditField2.Value = 'Still';
app.EditField3.Value = 'MIA';
app.EditField4.Value = 'Other';

%% Kinematics
app.ListBox.Items = {};
app.Slider_2.Visible = 'off';
app.PositionPanel.Visible = 'off';
app.VelocityPanel.Visible = 'off';
app.AutoSegmentButton.Enable = 'off';

% nans
app.UIAxes2.Visible = 'off';
app.Spinner.Enable = 'off';
app.SmoothButton.Enable = 'off';
app.ImputationMeanButton.Enable = 'off';
app.InterpolateButton.Enable = 'off';
app.RESETButton.Enable = 'off';
app.Lamp.Color = [0.5,0.5,0.5];
end

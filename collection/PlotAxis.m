function [fig] = plotCoordFrame(T, Label)
    % plotHoloLensTopDown - Creates a top-down visualization of HoloLens camera positions
    % 
    % Inputs:
    %   T_set - {matrix (4x4) X N}
    %   Label_set - {label X N}

    % % Create figure and set properties
    % fig = figure;
    % hold on;
    % axis equal;
    % xlabel('x [mm]');
    % ylabel('y [mm]');
    % zlabel('z [mm]');
    % grid on;
    
    % if(POV == "topdown")
    %     view([-90, 0]); % top-down view
    %     title(TitleLabel + ' - Top-Down');
    % elseif(POV == "back")
    %     view([-90, -90])
    %     title(' - Back');
    % elseif(POV == "backtofront")
    %     view([-90, 90])
    %     title(' - Back to Front');
    % end
    % 
    % Plot coordinate axes for each camera

    % Extract rotation matrix and translation vector
    R = T(1:3,1:3);
    t = T(1:3,4);

    % Create and scale unit vectors
    scale = 15;
    x_axis = R * [scale; 0; 0];
    y_axis = R * [0; scale; 0];
    z_axis = R * [0; 0; scale];

    % Plot coordinate axes
    linewidth = 2;
    quiver3(t(1), t(2), t(3), x_axis(1), x_axis(2), x_axis(3), 'r', 'LineWidth', linewidth);
    quiver3(t(1), t(2), t(3), y_axis(1), y_axis(2), y_axis(3), 'g', 'LineWidth', linewidth);
    quiver3(t(1), t(2), t(3), z_axis(1), z_axis(2), z_axis(3), 'b', 'LineWidth', linewidth);

    % Add labels
    text(t(1), t(2), t(3), Label, 'VerticalAlignment', 'bottom', ...
        'HorizontalAlignment', 'right');
end
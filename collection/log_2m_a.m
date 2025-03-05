%% Data Collection Math Verification (2 Meters)
% Author: Frank Regal
% Company: The University of Texas at Austin
% Date: 2025.03.04

close all;
clear all;
clc;
figure;
hold on;

%% Define Recorded Transforms
% all positions are [m] 
% all rotations [rad] 
% unless otherwise noted

% echoed transforms
qr_code_to_box_2 = [  0.99874, -0.04992, -0.00471, -1.46120;
                      0.04992,  0.99875, -0.00063,  2.50461;
                      0.00474,  0.00039,  0.99999,  0.79344;
                      0.00000,  0.00000,  0.00000,  1.00000];

qr_code_to_yellow = [ 0.11357, -0.99337,  0.03513, -1.48690;
                      0.92917,  0.11863,  0.35140,  0.67651;
                     -0.35308, -0.00744,  0.93560,  1.32124;
                      0.00000,  0.00000,  0.00000,  1.00000];

qr_code_to_pink =   [ 0.11357, -0.99337,  0.03513, -1.52481;
                      0.92917,  0.11863,  0.35140,  1.33620;
                     -0.35308, -0.00744,  0.93560,  1.21965;
                      0.00000,  0.00000,  0.00000,  1.00000];

pink_to_yellow =    [ 1.00000,  0.00000,  0.00000, -0.64451;
                      0.00000,  1.00000,  0.00000, -0.11702;
                      0.00000,  0.00000,  1.00000, -0.13539;
                      0.00000,  0.00000,  0.00000,  1.00000];

pink_to_box_2 =     [ 0.15770,  0.92244, -0.35372,  1.24329;
                     -0.98634,  0.16730, -0.00357,  0.07904;
                      0.05604,  0.34927,  0.93538,  0.01407;
                      0.00000,  0.00000,  0.00000,  1.00000];

% additional transforms
yellow_to_pink = InvSE3(pink_to_yellow);
yellow_to_box_2 = InvSE3(qr_code_to_yellow) * qr_code_to_box_2;

% Plot the transforms
PlotCoordFrame(qr_code_to_box_2, 'box2', 0.5)
PlotCoordFrame(qr_code_to_pink, 'lower', 0.5)
PlotCoordFrame(qr_code_to_yellow, 'upper', 0.5)

%% Plot Plane Aligned w/ X-Z Axes of Box Coordinate

% Define the plane in the x-z plane
[x, z] = meshgrid(-3:0.5:3);
y = ones(size(x))*2.504608055756883;

% Plot the plane
surf(x, y, z, 'FaceAlpha', 0.2, 'EdgeColor', 'none', 'FaceColor','b');

% Set axis labels and title
title('Data Collection Math Verification (2 Meters)');
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');
xlim([-3, 0.5]); ylim([0, 3]); zlim([-1, 2.5]);    
view([45, 23])
axis square; grid on;

%% Calculate Minimum Distance

Pb_star = qr_code_to_box_2(1:3, 4);  % point from 'pink' upper arm to box center
Py      = qr_code_to_yellow(1:3, 4); % point of 'pink' defined as math base
Pp      = qr_code_to_pink(1:3, 4);   % point from 'pink' upper arm to 'yellow' lower arm
d = CalculateMinDistance(Pb_star, Py, Pp);
fprintf('Distance Between Target & Vector: %0.5f\n', d)

hold off;

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
qr_code_to_box_2 = [
    0.99871, -0.05073, -0.00083, -1.46084;
    0.05073,  0.99871, -0.00302,  2.50455;
    0.00098,  0.00297,  1.00000,  0.79363;
    0.00000,  0.00000,  0.00000,  1.00000
];
qr_code_to_yellow = [
    0.11357, -0.99337,  0.03513, -1.46077;
    0.92917,  0.11863,  0.35140,  1.72000;
   -0.35308, -0.00744,  0.93560,  1.19053;
    0.00000,  0.00000,  0.00000,  1.00000
];
qr_code_to_pink = [
    0.11357, -0.99337,  0.03513, -1.47652;
    0.92917,  0.11863,  0.35140,  2.08678;
   -0.35308, -0.00744,  0.93560,  1.07407;
    0.00000,  0.00000,  0.00000,  1.00000
];
pink_to_yellow = [
    1.00000,  0.00000,  0.00000, -0.37075;
    0.00000,  1.00000,  0.00000, -0.05629;
    0.00000,  0.00000,  1.00000, -0.08866;
    0.00000,  0.00000,  0.00000,  1.00000
];
pink_to_box_2 = [
    0.15770,  0.92244, -0.35372,  0.50186;
   -0.98634,  0.16730, -0.00357,  0.03682;
    0.05604,  0.34927,  0.93538, -0.02538;
    0.00000,  0.00000,  0.00000,  1.00000
];


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
title('Data Collection Math Verification (1 Meter)');
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

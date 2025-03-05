close all;
clear all;
clc;

% Create a 3D figure
figure;
hold on;

% Define two vectors in the x-z plane
v1 = [0, 10, 1];
v2 = [0, 2, 2];

% Plot the vectors
quiver3(0, 0, 0, v1(1), v1(2), v1(3), 'r', 'LineWidth', 2);
quiver3(0, 0, 0, v2(1), v2(2), v2(3), 'b', 'LineWidth', 2);

% Define the plane in the x-z plane
[x, z] = meshgrid(-3:0.5:3);
y = ones(size(x))*5;

% Plot the plane
surf(x, y, z, 'FaceAlpha', 0.3, 'EdgeColor', 'none');

% Set axis labels and title
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Two Vectors and a Plane in the X-Z Plane');

% Set axis limits
xlim([-5, 5]);
ylim([-5, 5]);
zlim([-5, 5]);

% Add a grid
grid on;

% Set the view angle
view(30, 30);

hold off;

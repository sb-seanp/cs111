close all;
clear all;
clc;

% Variables
xv_red = .3;
yv_red = 0;
t = 0;
delta_t = .03;
t_final = 600;
radius = .05;
xd_red = .5;
yd_red = 1-radius;
n_damp = .8;
t_damp = .99;
g = -.0981;

x_wall = 1;
y_wall = 1;

clf;

% Initialise
Draw_Disk(xd_red,yd_red,radius);
axis([0 x_wall 0 y_wall]);
drawnow;

while true,
    % Advance time
    t = t + delta_t;
    % Accelerate
    yv = yv + g*delta_t;
    % Update position
    xd_red = xd_red + xv*delta_t;
    yd_red = yd_red + yv*delta_t;
    
    % Draw circle
    Draw_Disk(xd_red,yd_red,radius);
    axis([0 x_wall 0 y_wall]);
    drawnow;
    
    % Check for wall collision
    if ((xd_red + radius) >= x_wall || xd_red <= radius),
        % Reverse direction
        xv = -1*xv*n_damp;
        % Damp
        yv = yv*t_damp;
    end;
    if ((yd_red + radius) >= y_wall || yd_red <= radius),
        yv = -1*yv*n_damp;
        xv = xv*t_damp;
    end;
    % Check for end
    if (yd_red <= radius),
        yd_red = radius;
    end;
    
end;
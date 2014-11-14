close all;
clear all;
clc;

% Variables
v_red = [5 0]
xv_red = 5;
yv_red = 0;
xv_blue = 1;
yv_blue = 0;
t = 0;
delta_t = .03;
t_final = 5;
radius = .05;
xd_red = .5;
yd_red = 1-radius;
xd_blue = .2;
yd_blue = 1.4;
n_damp = .8;
t_damp = .99;

ball_collision = 0;

x_wall = 1;
y_wall = 2;

clf;

while t < t_final,
    if (t + delta_t > t_final),
        delta_t = t_final - t;
    end;
    % Update position
    xd_red = xd_red + xv_red*delta_t;
    yd_red = yd_red + yv_red*delta_t;
    xd_blue = xd_blue + xv_blue*delta_t;
    yd_blue = yd_blue + yv_blue*delta_t;
    
    if (sqrt((xd_blue - xd_red)^2 + (yd_blue - yd_red)^2) <= 2*radius),
        ball_collision = 1;
    else
        ball_collision = 0;
    end;
    
    if (ball_collision == 1),
        
    
    % Check for wall collision
    if ((xd_red + radius) >= x_wall || xd_red <= radius),
        % Reverse direction
        xv_red = -1*xv_red*n_damp;
        % Damp
        yv_red = yv_red*t_damp;
    end;
    if ((yd_red + radius) >= y_wall || yd_red <= radius),
        yv_red = -1*yv_red*n_damp;
        xv_red = xv_red*t_damp;
    end;
    if ((xd_blue + radius) >= x_wall || xd_blue <= radius),
        xv_blue = -1*xv_blue*n_damp;
        yv_blue = yv_blue*t_damp;
    end;
    if ((yd_blue + radius) >= y_wall || yd_blue <= radius),
        yv_blue = -1*yv_blue*n_damp;
        xv_blue = xv_blue*t_damp;
    end;
    % Check for end
    if (yd_red <= radius),
        yd_red = radius;
    end;
    
    Draw_Disk(xd_red,yd_red,radius);
    Draw_Disk(xd_blue,yd_blue,radius);
    axis([0 x_wall 0 y_wall]);
    axis normal;
    drawnow;
    
    % Advance time
    t = t + delta_t;
    
end;
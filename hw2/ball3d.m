close all;
clear all;
clc;

% Variables
v_vector_red = [.3 0];
v_vector_blue = [0, 0];
v_old_red = v_vector_red;
v_old_blue = v_vector_blue;
t = 0;
t_final = 5;
delta_t = .03;
radius = .05;
d_vector_red = [.5 1-radius];
d_vector_blue = [.3 2-radius];
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
    % Store vectors at collision
    v_old_red = v_vector_red;
    d_old = d_vector_red;
    % Update position
    d_vector_red = d_vector_red + v_vector_red*delta_t;
    d_vector_blue = d_vector_blue + v_vector_blue*delta_t;
    
    if (sqrt((d_vector_blue(1) - d_vector_red(1)^2 + (d_vector_blue(2) - d_vector_red(2)))^2) <= 2*radius),
        ball_collision = 1;
    else
        ball_collision = 0;
    end;
    
    if (ball_collision == 1),
        d_vector_red = d_old_red;
        d_vector_blue = d_old_blue;
        delta_t = abs(1 - d_vector_red(1) - radius)/v_old_red(1);
        d_vector_red = d_vector_red + v_old_red*delta_t;
        d_vector_blue = d_vector_blue + v_old_blue*delta_t;
        
        phi = atan((d_vector_blue(2) - d_vector_red(2))/(d_vector_blue(1) - d_vector_red(1)));
        
        n_red = cos(phi)*d_vector_red(1) + sin(phi)*d_vector_red(2);
        t_red = -sin(phi)*d_vector_red(1) + cos(phi)*d_vector_red(2);
        
        n_blue = cos(phi)*d_vector_red(1) + sin(phi)*d_vector_red(2);
        t_blue = -sin(phi)*d_vector_red(1) + cos(phi)*d_vector_red(2);
    end;
        
    % Check if ball passes x walls
    if (d_vector_red(1) + radius >= x_wall),
        % Move to collision
        d_vector_red = d_old;
        % Check time to collision
        delta_t = abs(1 - d_vector_red(1) - radius)/v_old_red(1);
        % Update position again to true position
        d_vector_red = d_vector_red + v_old_red*delta_t;
        % Reverse direction
        v_vector_red(1) = -1*v_old_red(1);
        % Damp
        v_vector_red = v_vector_red .* [n_damp t_damp];
        disp('x');
    end;
    if (d_vector_red(1) <= radius),
        d_vector_red = d_old;
        delta_t = abs(radius - d_vector_red(1))/v_old_red(1);
        d_vector_red = d_vector_red + v_old_red*delta_t;
        v_vector_red(1) = -1*v_old_red(1);
        v_vector_red = v_vector_red .* [n_damp t_damp];
    end;
    % Check if ball passes y walls
    if (d_vector_red(2) + radius >= y_wall),
        d_vector_red = d_old;
        delta_t = abs(1 - d_vector_red(2) - radius)/v_old_red(2);
        d_vector_red = d_vector_red + v_old_red*delta_t;
        v_vector_red(2) = -1*v_old_red(2);
        v_vector_red = v_vector_red .* [t_damp n_damp];
        disp('y');
    end;
    if (d_vector_red(2) <= radius),
        d_vector_red = d_old;
        delta_t = abs(radius - d_vector_red(2))/v_old_red(2);
        d_vector_red = d_vector_red + v_old_red*delta_t;
        v_vector_red(2) = -1*v_old_red(2);
        v_vector_red = v_vector_red .* [t_damp n_damp];
    end;
    
    % Advance time
    t = t + delta_t;
    
    % Reset delta t
    delta_t = .03;
    
    % Draw
    Draw_Disk(d_vector_red(1),d_vector_red(2),radius);
    Draw_Blue(d_vector_blue(1),d_vector_blue(2),radius);
    axis([0 x_wall 0 y_wall]);
    drawnow;
    
end;
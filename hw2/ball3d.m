close all;
clear all;
clc;

% Variables
v_vector_red = [5 0];
v_vector_blue = [0 0];
v_old_red = v_vector_red;
v_old_blue = v_vector_blue;
t = 0;
t_final = 5;
delta_t = .03;
radius = .05;
d_vector_red = [.2 1];
d_vector_blue = [.8 1.05];
n_damp = .8;
t_damp = .99;
ball_collision = 0;

L = 1;

x_wall = L;
y_wall = 2*L;

clf;

set(gcf, 'Units', 'normalized');
set(gcf, 'Position', [0 0 .25 1]);

while t < t_final,
    % Get that last timestamp in
    if (t + delta_t > t_final),
        delta_t = t_final - t;
    end;
    % Store vectors at collision
    v_old_red = v_vector_red;
    v_old_blue = v_vector_blue;
    d_old_red = d_vector_red;
    d_old_blue = d_vector_blue;
    % Update position
    d_vector_red = d_vector_red + v_vector_red*delta_t;
    d_vector_blue = d_vector_blue + v_vector_blue*delta_t;
    
    % Check for ball on ball action
    if ( sqrt((d_vector_blue(1) - d_vector_red(1))^2 + (d_vector_blue(2) - d_vector_red(2))^2) <= 2*radius),
        ball_collision = 1;
        disp('col');
    else
        ball_collision = 0;
    end;
    
    % If there's a ball on ball collision
    if (ball_collision == 1),
        
        % Move to collision
        d_vector_red = d_old_red;
        d_vector_blue = d_old_blue;
        
        % Pre-calculate distances
        d_vector_x = d_vector_red(1) - d_vector_blue(1);
        d_vector_y = d_vector_red(2) - d_vector_blue(2);
        v_vector_x = v_vector_red(1) - v_vector_blue(1);
        v_vector_y = v_vector_red(2) - v_vector_blue(2); 
        
        % Find new delta_t of collision
        delta_t = (sqrt((d_vector_x)^2 + (d_vector_y)^2) - 2*radius) / (sqrt((v_vector_x)^2 + (v_vector_y)^2));
        
        % Update position with new time
        d_vector_red = d_vector_red + v_old_red*delta_t;
        d_vector_blue = d_vector_blue + v_old_blue*delta_t;
        
        % Calculate angle
        phi = atan((d_vector_blue(2) - d_vector_red(2))/(d_vector_blue(1) - d_vector_red(1)));
        
        % Get the normal and tangential velocities
        n_red = cos(phi)*v_vector_red(1) + sin(phi)*v_vector_red(2);
        t_red = -sin(phi)*v_vector_red(1) + cos(phi)*v_vector_red(2);
        
        n_blue = cos(phi)*v_vector_blue(1) + sin(phi)*v_vector_blue(2);
        t_blue = -sin(phi)*v_vector_blue(1) + cos(phi)*v_vector_blue(2);
        
        % Convert back to regular velocity and swap normals
        v_vector_red(1) = cos(phi)*n_blue - sin(phi)*t_red;
        v_vector_red(2) = sin(phi)*n_blue + cos(phi)*t_red;
    
        v_vector_blue(1) = cos(phi)*n_red - sin(phi)*t_blue;
        v_vector_blue(2) = sin(phi)*n_red + cos(phi)*t_blue;
        
    end;
    
        
    % Check if ball passes x walls
    if (d_vector_red(1) + radius >= x_wall),
        % Move to collision
        d_vector_red = d_old_red;
        % Check time to collision
        delta_t = abs(x_wall - d_vector_red(1) - radius)/v_old_red(1);
        % Update position again to true position
        d_vector_red = d_vector_red + v_old_red*delta_t;
        % Reverse direction
        v_vector_red(1) = -1*v_old_red(1);
        % Damp
        v_vector_red = v_vector_red .* [n_damp t_damp];
        disp('x');
    end;
    if (d_vector_red(1) <= radius),
        d_vector_red = d_old_red;
        delta_t = abs(radius - d_vector_red(1))/v_old_red(1);
        d_vector_red = d_vector_red + v_old_red*delta_t;
        v_vector_red(1) = -1*v_old_red(1);
        v_vector_red = v_vector_red .* [n_damp t_damp];
    end;
    % Check if ball passes y walls
    if (d_vector_red(2) + radius >= y_wall),
        d_vector_red = d_old_red;
        delta_t = abs(y_wall - d_vector_red(2) - radius)/v_old_red(2);
        d_vector_red = d_vector_red + v_old_red*delta_t;
        v_vector_red(2) = -1*v_old_red(2);
        v_vector_red = v_vector_red .* [t_damp n_damp];
        disp('y');
    end;
    if (d_vector_red(2) <= radius),
        d_vector_red = d_old_red;
        delta_t = abs(radius - d_vector_red(2))/v_old_red(2);
        d_vector_red = d_vector_red + v_old_red*delta_t;
        v_vector_red(2) = -1*v_old_red(2);
        v_vector_red = v_vector_red .* [t_damp n_damp];
    end;
    % Blue ball walls
    if (d_vector_blue(1) + radius >= x_wall),
        d_vector_blue = d_old_blue;
        delta_t = abs(x_wall - d_vector_blue(1) - radius)/v_old_blue(1);
        d_vector_blue = d_vector_blue + v_old_blue*delta_t;
        v_vector_blue(1) = -1*v_old_blue(1);
        v_vector_blue = v_vector_blue .* [n_damp t_damp];
        disp('xblue');
    end;
    if (d_vector_blue(1) <= radius),
        d_vector_blue = d_old_blue;
        delta_t = abs(radius - d_vector_blue(1))/v_old_blue(1);
        d_vector_blue = d_vector_blue + v_old_blue*delta_t;
        v_vector_blue(1) = -1*v_old_blue(1);
        v_vector_blue = v_vector_blue .* [n_damp t_damp];
    end;
    % Check if ball passes y walls
    if (d_vector_blue(2) + radius >= y_wall),
        d_vector_blue = d_old_blue;
        delta_t = abs(y_wall - d_vector_blue(2) - radius)/v_old_blue(2);
        d_vector_blue = d_vector_blue + v_old_blue*delta_t;
        v_vector_blue(2) = -1*v_old_blue(2);
        v_vector_blue = v_vector_blue .* [t_damp n_damp];
        disp('y');
    end;
    if (d_vector_blue(2) <= radius),
        d_vector_blue = d_old_blue;
        delta_t = abs(radius - d_vector_blue(2))/v_old_blue(2);
        d_vector_blue = d_vector_blue + v_old_blue*delta_t;
        v_vector_blue(2) = -1*v_old_blue(2);
        v_vector_blue = v_vector_blue .* [t_damp n_damp];
    end;
    
    % Advance time
    t = t + delta_t;
    
    % Reset delta t
    delta_t = .03;
    
    % Draw
    Draw_Disk(d_vector_red(1),d_vector_red(2),d_vector_blue(1),d_vector_blue(2),radius);
    axis([0 x_wall 0 y_wall]);
    drawnow;
    
end;
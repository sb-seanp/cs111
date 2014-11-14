close all;
clear all;
clc;

% Variables
v_vector = [.3 .1 .2];
v_old = v_vector;
t = 0;
t_final = 1000;
delta_t = .03;
radius = .05;
d_vector = [.5 1-radius .5];
n_damp = .8;
t_damp = .99;
g = -.0981;
g_vector = [0 g 0];

x_wall = 1;
y_wall = 1;
z_wall = 1;

clf;

% Initialise
[x,y,z]= sphere();
surf(radius*x + d_vector(1), radius*y+d_vector(3), radius*z + d_vector(2));
axis([0 x_wall 0 z_wall 0 y_wall]);
drawnow;

while true,
    % Advance time
    t = t + delta_t;
    % Store vectors at collision
    v_old = v_vector;
    d_old = d_vector;
    % Accelerate
    v_vector = v_vector + g_vector*delta_t;
    % Update position
    d_vector = d_vector + v_vector*delta_t;
        
    % Check if ball passes x walls
    if (d_vector(1) + radius >= x_wall),
        % Move to collision
        d_vector = d_old;
        % Check time to collision
        delta_t = abs(1 - d_vector(1) - radius)/v_old(1);
        % Update position again to true position
        d_vector = d_vector + v_old*delta_t;
        % Reverse direction
        v_vector(1) = -1*v_old(1);
        % Damp
        v_vector = v_vector .* [n_damp t_damp t_damp];
        disp('x');
    end;
    if (d_vector(1) <= radius),
        d_vector = d_old;
        delta_t = abs(radius - d_vector(1))/v_old(1);
        d_vector = d_vector + v_old*delta_t;
        v_vector(1) = -1*v_old(1);
        v_vector = v_vector .* [n_damp t_damp t_damp];
    end;
    % Check if ball passes z walls
    if (d_vector(2) + radius >= z_wall),
        d_vector = d_old;
        delta_t = abs(1 - d_vector(2) - radius)/v_old(2);
        d_vector = d_vector + v_old*delta_t;
        v_vector(2) = -1*v_old(2);
        v_vector = v_vector .* [t_damp n_damp t_damp];
        disp('z');
    end;
    if (d_vector(2) <= radius),
        d_vector = d_old;
        delta_t = abs(radius - d_vector(2))/v_old(2);
        d_vector = d_vector + v_old*delta_t;
        v_vector(2) = -1*v_old(2);
        v_vector = v_vector .* [t_damp n_damp t_damp];
    end;
    % Check if ball passes y walls
    if (d_vector(3) + radius >= y_wall),
        d_vector = d_old;
        delta_t = abs(1 - d_vector(3) - radius)/v_old(3);
        d_vector = d_vector + v_old*delta_t;
        v_vector(3) = -1*v_old(3);
        v_vector = v_vector .* [t_damp t_damp n_damp];
        disp('y');
    end;
    if (d_vector(3) <= radius),
        d_vector = d_old;
        delta_t = abs(radius - d_vector(3))/v_old(3);
        d_vector = d_vector + v_old*delta_t;
        v_vector(3) = -1*v_old(3);
        v_vector = v_vector .* [t_damp t_damp n_damp];
    end;
    
    % Check for end
    if (d_vector(3) <= radius),
        d_vector(3) = radius;
    end;
    
    % Reset delta t
    delta_t = .03;
    
    % Draw
    surf(radius*x + d_vector(1), radius*y + d_vector(3), radius*z + d_vector(2));
    axis([0 x_wall 0 z_wall 0 y_wall]);
    drawnow;
    
end;
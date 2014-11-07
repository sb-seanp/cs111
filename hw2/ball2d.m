close all;
clear all;
clc;

xv = .3;
yv = 0;
t = 0;
delta_t = .03;
t_final = 600;
radius = .05;
xd = .5;
yd = 1-radius;
n_damp = .8;
t_damp = .99;
g = -.0981;

x_wall = 1;
y_wall = 1;

clf;

Draw_Disk(xd,yd,radius);
axis([0 x_wall 0 y_wall]);
drawnow;

while true,
    t = t + delta_t;
    xd = xd + xv*delta_t;
    yv = yv + g*delta_t;
    yd = yd + yv*delta_t;
    
    Draw_Disk(xd,yd,radius);
    axis([0 x_wall 0 y_wall]);
    drawnow;
    
    if ((xd + radius) >= x_wall || xd <= radius),
        xv = -1*xv*n_damp;
        yv = yv*t_damp;
    end;
    if ((yd + radius) >= y_wall || yd <= radius),
        yv = -1*yv*n_damp;
        xv = xv*t_damp;
    end;
    if (yd <= radius),
        yd = radius;
    end;
    
end;
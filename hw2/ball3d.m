close all;
clear all;
clc;

xv = .3;
yv = .1;
zv = .2;
t = 0;
delta_t = .03;
t_final = 100;
radius = .05;
xd = .5;
yd = 1-radius;
zd = .5;
n_damp = .8;
t_damp = .99;
g = -.0981;

x_wall = 1;
y_wall = 1;
z_wall = 1;

[x,y,z] = sphere();

clf;

mesh(radius*x+xd, radius*y+yd, radius*z+zd);
axis([0 x_wall 0 y_wall 0 z_wall]);
drawnow;

while true,
    t = t + delta_t;
    yv = yv + g*delta_t;
    xd = xd + xv*delta_t;
    yd = yd + yv*delta_t;
    zd = zd + zv*delta_t;

    mesh(radius*x+xd, radius*y+yd, radius*z+zd);
    axis([0 x_wall 0 y_wall 0 z_wall]);
    drawnow;
    
    if ((xd + radius) > x_wall || xd < radius),
        xv = -1*xv*n_damp;
        yv = yv*t_damp;
        zv = zv*t_damp;
        disp('x');
    end;
    if ((yd + radius) > y_wall || yd < radius),
        yv = -1*yv*n_damp;
        xv = xv*t_damp;
        zv = zv*t_damp;
        disp('y');
    end;
    if ((zd + radius) > z_wall || zd < radius),
        zv = -1*zv*n_damp;
        xv = xv*t_damp;
        yv = yv*t_damp;
        disp('z');
    end;
    if (yd <= radius),
        yd = radius;
    end;
    
end;
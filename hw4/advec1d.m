clear;
clc;
clf;

p = -1;
q = 1;
N = 100;
c = 1;
%c = -1;

dx = (q - p)/(N - 1);
x = p:dx:q;
u_old = zeros(N,1);
u_old = cos(pi*x); 

t = 0;
t_final = 2;
dt = .5*dx;

u = zeros(N,1);
r = c*dt/dx;

while t < t_final,
    if t + dt > t_final,
        dt = t_final - t;
    end;
    for i = 2:N,%i = 1:N-1
        u(i) = u_old(i) - r*(u_old(i) - u_old(i-1));
        %u(i) = u_old(i) - r*(u_old(i+1) - u_old(i));
    end;
    u_old = u;
    t = t + dt;
end;

exact = cos(pi*(x - c*t));
plot(x, u(1:N), 'r+');
hold on;
plot(x, exact, 'bo');
hold off;
xlabel('x');
ylabel('u');
title('Linear advection in 1 dimension');
      
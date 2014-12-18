clear all;
clc;

m = 50;

low = 0;
up = 1;

x = linspace(low, up, m);
y = linspace(low, up, m);
dx = x(2) - x(1);
dy = y(2) - y(1);

A = zeros(m,m);
RHS = zeros(m,1);

dt = .25*min(dx, dy);
t = 0;
t_final = 1;
D = 0.5;

a_init = 1;
u = zeros(m,m);
v = zeros(m,m);

e = exp(-t)-1;

exact = e*(sin(pi*x) + sin(pi*y));

A = sparse(m,m);
% Treat boundary
for i = 1:m,
    j = 1;
    p = (j - 1)*m + i;
    A(p,p) = 1; RHS(p) = u(i,j);
    j = m;
    p = (j - 1)*m + i;
    A(p,p) = 1; RHS(p) = u(i,j);
end;
for j = 1:m,
    i = 1;
    p = (j - 1)*m + i;
    A(p,p) = 1; RHS(p) = u(i,j);
    i = m;
    p = (j - 1)*m + i;
    A(p,p) = 1; RHS(p) = u(i,j);
end;

while t < t_final,
    if t + dt > t_final,
        dt = t_final - t;
    end;
    for i = 2:m - 1,
        for j = 2:m - 1,
            p = (j - 1)*m + i;
            A(p, p)     = 1 + 2*D*dt/dx/dx + 2*D*dt/dy/dy;
            A(p, p + 1) = -D*dt/dx/dx;
            A(p, p - 1) = -D*dt/dy/dy;
            A(p, p + m) = -D*dt/dx/dx;
            A(p, p - m) = -D*dt/dy/dy;
            if a_init > 0,
                RHS(p) = u(i,j) - a_init*dt/dx*(u(i,j) - u(i - 1,j)) - dt/dy*(u(i,j) - u(i,j - 1));
            else
                RHS(p) = u(i,j) - a_init*dt/dx*(u(i + 1,j) - u(i,j)) - dt/dy*(u(i,j + 1) - u(i,j));
            end;
        end;
        
    end;
    
    unew = A\RHS;
    for i = 1:m,
        for j = 1:m,
            p = (j - 1)*m + i;
            u(i,j) = unew(p);
        end;
    end;
    t = t + dt;
end;
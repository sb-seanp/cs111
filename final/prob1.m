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

a = 1;
c = zeros(m,1);
u = a*y.*(1 - y);
v = 0;

e = exp(-t)-1;

%S = exact - u*e*pi*cos(pi*x)-u*e*cos(pi*y)+D*e*pi^2*sin(pi*x)+D*e*pi^2*sin(pi*x);

% Treat boundary
for i = 1:m,
    j = 1;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i))); RHS(p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
    j = m;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i))); RHS(p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
end;
for j = 1:m,
    i = 1;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i))); RHS(p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
    i = m;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i))); RHS(p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
end;

while t < t_final,
    if t + dt > t_final,
        dt = t_final - t;
    end;
    exact = (exp(-t)-1)*(sin(pi*x) + sin(pi*y));
    u = a*y.*(1-y);
    for i = 2:m - 1,
        for j = 2:m - 1,
            p = (j - 1)*m + i;
            A(p, p)     = 1 + 2*D*dt/dx/dx + 2*D*dt/dy/dy;
            A(p, p + 1) = -D*dt/dx/dx;
            A(p, p - 1) = -D*dt/dy/dy;
            A(p, p + m) = -D*dt/dx/dx;
            A(p, p - m) = -D*dt/dy/dy;
        end;
        if c(i) > 0,
            RHS(i) = c(i) - a*y(i)*(1-y(i))*dt/dx*(c(i) - c(i-1));%+ dt*S
            
        else
            RHS(i) = c(i) - a*y(i)*(1-y(i))*dt/dx*(c(i + 1) - c(i));%+ dt*S
        end;        
    end;
    S = sparse(A);
    cnew = S\RHS;
    c = cnew;
    t = t + dt;
    y = y + dy;
end;
% vector to matrix ,use c and grid points
plot(x,exact,'r');
%plot(x,c,'b');
hold on;
hold off;
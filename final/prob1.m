clear all;
clc;

m = 5;

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
c = zeros(m,1);
u = a_init*y.*(1 - y);
v = 0;

exact = exp(-t)-1*(sin(pi*x) + sin(pi*y));

A = sparse(A);

% Treat boundary
for i = 1:m,
    j = 1;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
    j = m;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
end;
for j = 1:m,
    i = 1;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
    i = m;
    p = (j - 1)*m + i;
    A(p,p) = exp(-t)-1*(sin(pi*x(i)) + sin(pi*y(i)));
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
        end;
        if a_init > 0,
            RHS(p) = c(p) - u*dt/dx*(c(p) - c(p-1));%+ dt*S
        else
            RHS(p) = c(p) - u*dt/dx*(c(p + 1) - c(p));%+ dt*S
        end;        
    end;
    %cnew = A\RHS;
    %c = cnew;
    %for i = 1:m,
     %   for j = 1:m,
      %      p = (j - 1)*m + i;
       %     u(i,j) = unew(p);
        %end;
    %end;
    t = t + dt;
end;
% vector to matrix ,use c and grid points
c_exact = (exp(-t) - 1)*(sin(pi*x) + sin(pi*y));
mat = vec2mat(c_exact,m);
plot(mat,m);
hold on;
hold off;
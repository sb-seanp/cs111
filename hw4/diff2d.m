clear;
clc;
clf;

px  = -pi/2;
qx  = pi/2;
py  = -pi/2;
qy  = pi/2;
N   = 100;
dx  = (qx - px)/(N - 1);
dy  = (qy - py)/(N - 1);
x   = px:dx:qx;
y   = py:dy:qy;

t = 0;
t_final = pi;
dt = 0.2*dx;

u   = zeros(N,N);                  
u_new = zeros(N,N);                 
v   = zeros(N,N);                  
v_new = zeros(N,N);

r = 0.25;

while t < t_final,
    for i = 2:N - 1,
        for j = 2:N - 1;
            %u(i,j) = -cos(x).*sin(y);
            %v(i,j) = sin(x).*cos(y);
            u_new = u;
            v_new = v;
            u(i,j) = u_new(i,j)-(dt*u_new(i,j).*(u_new(i,j)-u_new(i-1,j))/dx)-(dt*v_new(i,j).*(u_new(i,j)-u_new(i,j-1))/dy);
            v(i,j) = v_new(i,j)-(dt*u_new(i,j).*(v_new(i,j)-v_new(i-1,j))/dx)-(dt*v_new(i,j).*(v_new(i,j)-v_new(i,j-1))/dy);
        end;
    end;
    t = t + dt;
end;

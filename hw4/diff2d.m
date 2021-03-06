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

% Boundary conditions
u(1,:) = 0;
u(N,:) = 0;
u(:,1) = 0;
u(:,N) = 0;
v(1,:) = 0;
v(N,:) = 0;
v(:,1) = 0;
v(:,N) = 0;

i = 1:N;
j = 1:N;

disp('working');
%u = -cos(x).*sin(y).*cos(t);
%v = sin(x).*cos(y).*cos(t);
disp('working');

r = 0.25;

while t < t_final,
    u_new = u;
    v_new = v;
    u = -cos(x).*sin(y)*cos(t);
    v = sin(x).*cos(y)*cos(t);
    quiver(x,y,u,v);
    title('Vector field');
    u(i,j) = u_new(i,j)-(dt*u_new(i,j).*(u_new(i,j)-u_new(i-1,j))/dx)-(dt*v_new(i,j).*(u_new(i,j)-u_new(i,j-1))/dy);
    v(i,j) = v_new(i,j)-(dt*u_new(i,j).*(v_new(i,j)-v_new(i-1,j))/dx)-(dt*v_new(i,j).*(v_new(i,j)-v_new(i,j-1))/dy);
    t = t + dt;
    u(1,:) = 0;
    u(N,:) = 0;
    u(:,1) = 0;
    u(:,N) = 0;
    v(1,:) = 0;
    v(N,:) = 0;
    v(:,1) = 0;
    v(:,N) = 0;
end;

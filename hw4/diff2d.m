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

u   = zeros(N,N);                  
u_new = zeros(N,N);                 
v   = zeros(N,N);                  
v_new = zeros(N,N);  
u = -cos(x)*sin(y)*cos(t);
v = sin(x)*cos(y)*cos(t);

t = 0;
t_final = pi;
dt = .2*dx;

r = .25;

A = zeroes(N,N);

for i = 2:N-1,
    for j = 2:N-1,
        m = (j - 1)*qx + px;
        A(m,m) = C;
        A(m,m + px) = R;
        A(m,m - px) = L;
        A(m,m + qx) = T;
        A(m,m - qx) = B;
    end;
end;
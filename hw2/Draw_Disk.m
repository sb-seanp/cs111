function outvar=DrawDisk(x,y,a,b,r)
n=100;
for i=1:n
    theta=i*(2*pi/n);
    X(i)=x+r*cos(theta);
    Y(i)=y+r*sin(theta);
    A(i)=a+r*cos(theta);
    B(i)=b+r*sin(theta);
end
fill(X,Y,'r'); % fills (in red 'r') the 2-D polygon defined by vectors X and Y
hold on;
fill(A,B,'b');
hold off;
end
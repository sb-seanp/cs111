close all;
clear all;
clc;

%  User inputs (initial conditions and such):
xPosition = 5;  %  meters
yPosition = 5;  %  meters
xVelocity = 2;  %  meters/second
yVelocity = 3;  %  meters/second

Time = 0;  %  seconds
TimeStep = 0.01;  %  seconds
FinalTime = 100;  %  seconds

ballRadius = .05;
xBoundary = 10;  %  meters
yBoundary = 10;  %  meters
%  Other boundaries at zero.
%  End user input.


%  Run the simulation:
plot(xPosition,yPosition,'ro');
axis([-1,xBoundary+1,-1,yBoundary+1]);
drawnow;
nCount = 0;
nMaxCount = 1000;
while Time < FinalTime,
    
  %  Create escape:
  nCount = nCount + 1;
  if nCount==nMaxCount,  
    break;
  end;
  
  %  Time step ball's motion:
  Time = Time + TimeStep;
  xPosition = xPosition + xVelocity*TimeStep;
  yPosition = yPosition + yVelocity*TimeStep;
  
  %  Plot the ball.
  plot(xPosition,yPosition,'ro');
  axis([-1,xBoundary+1,-1,yBoundary+1]);
  drawnow;
    
  %  Check the boundaries and bounce if necessary.
  if or(xPosition > xBoundary, xPosition < 0),
    xVelocity = -1 * xVelocity;
  end;
  if or(yPosition > yBoundary, yPosition < 0),
    yVelocity = -1 * yVelocity;
  end;
  
end;
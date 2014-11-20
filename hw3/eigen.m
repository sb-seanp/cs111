close all;
clear all;
clc;
clf;

m1 = 40;
m2 = 20;
m3 = 30;
k1 = 200;
k2 = 100;
k3 = 250;
k4 = 110;

aa = (k1 + k2)/m1;
ab = -k1/m1;
ac = 0;
ba = -k2/m2;
bb = (k2 + k3)/m2;
bc = -k2/m2;
ca = 0;
cb = -k3/m3;
cc = k3/m3;

A = [aa ab ac; ba bb bc; ca cb cc];
[v,d] = eig(A);

freqs = Freq(d);

t_final = 5;
dt = 0.02;
t = 0:dt:t_final;

x = v(1,1)*sin(freqs(1)*t);

figure;
plot(t, x);
axis([0 5 -1 1]);
xlabel('Time');
title('Vibrating System');
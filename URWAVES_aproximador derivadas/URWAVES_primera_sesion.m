clc
close all
clearvars

x = 0:0.1:(2*pi);
f = func(x);


hold on
plot(funcion_ejemplo(x, 0.1))
plot(funcion_ejemplo(x, 0.01))
plot(funcion_ejemplo(x, 0.001))
plot(cos(x))    

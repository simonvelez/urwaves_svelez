clc
close all
clearvars

elem = 10;
h = 0.1;

% Yi = f(xi)
X = 0:h:elem;
n = size(X);
n = n(2);
Y = func(X); %func está en func.m

% Creación Matriz que al multiplicar con Yi = f(xi) es f'(xi)
A = zeros(n,n);
A(1:size(A)+1:end) = -1;
A(size(A)+1:size(A)+1:end) = 1;
A(n,:) = 0;
A = A.*(1/h);

%Vector Z con la derivada aproximada para cada valor en X
Z = A * Y.';
    
d = cos(X); %derivada de func calculada por matlab
plot(X,Z,X,d, '--')


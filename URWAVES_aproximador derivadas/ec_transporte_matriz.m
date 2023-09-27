clc
close all
clearvars

elem = 2;
dt = 0.005;
dx = 0.005;
c = -0.5;
tf = 0.3; % Tiempo final


% Yi = f(xi)
X = 0:dx:elem;
n = size(X);
n = n(2);
Y = func(X); %func está en func.m

% Creación Matriz que al multiplicar con Yi = f(xi) es f'(xi)
A = zeros(n,n);
A(1:size(A)+1:end) = -1;
A(size(A)+1:size(A)+1:end) = 1;
A(n,:) = 0;
A = A.*(1/dx);

%Vector Z con la derivada aproximada para cada valor en X
Z = A * Y.';

% U = matriz de u(x, t+dt) el "futuro" de la ecuación de transporte
U = zeros(tf/dt+1, elem/dx+1);
U(1,:) = func(X); %Llenar la primera fila con func(x), para después hacer el resta

% Implementación con multiplicación de matrices
for i = 2:tf/dt
    U(i,:) = U(i-1,:) - c.*dt.*(A*U(i-1,:)')';
end

Yt = 0:dt:tf;
mesh(X, Yt, U)




    




% Solución por diferencias finitas al sistema lineal de aguas poco profundas
% URwaves, Universidad del Rosario, 2024

clc
close all

% Variables

dx = 0.02; %intervalo de espacio
dt = 0.02; % intervalo de tiempo
a = 1; % pos inicial de los valores
eps = 0.1; %"ancho" de la onda

J = 200; % # de puntos en el espacio
N = 160; % # de puntos en el tiempo
est = 10; % # de estados de tiempo a imprimir

g = 1; %aceleración gravitacional
h = 1;

m = dx/(6*dt);
p = (g*h)/4;
q = 1/4;

% Sistema de la forma As^(n+1) = Bs^n

M1 = diag(4*m*ones(1,J-2)) + diag(m*ones(1,J-3),1) + diag(m*ones(1,J-3),-1);
M2 = diag(p*ones(1,J-3),1) + diag(-p*ones(1,J-3),-1);
M3 = diag(q*ones(1,J-3),1) + diag(-q*ones(1,J-3),-1);

A = [M1, M2; M3, M1];
B = [M1, -M2; -M3, M1];

C = A\B;

% Valores iniciales de la matriz de solución
sol = zeros(2*J-4,N);
X = dx:dx:(J-1)*dx;
eta = exp(-(X-a).^2 ./ eps);

for i = 1:J-2
    sol(i,1) = h*eta(i+1);
    sol(i+J-2,1) = eta(i+1);
end

% Progresión respecto al tiempo de sol
for i = 2:N
    sol(:,i) = C*sol(:,i-1);
end

% Visualización de resultados
j = 1;
k = 1;
aux = zeros(J-2, est); % Matriz auxiliar
aux(:,k) = sol(J-1:2*J-4,i);
for i = 2:N
    j = j+1;
    if j == floor(N/(est-1))
        k = k + 1;
        aux(:,k) = sol(J-1: 2*J-4, i);
        j = 0; 
        if k >= est
            break
        end
    end
end

plot(X(:,10), [zeros(1,est);aux;zeros(1,est)])

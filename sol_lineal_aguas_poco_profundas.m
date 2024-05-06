% Solución por diferencias finitas al sistema lineal de aguas poco profundas
% URwaves, Universidad del Rosario, 2024

clc
close all

% Variables

dx = 0.01; %intervalo de espacio
dt = 0.01; % intervalo de tiempo
a = 1; % pos inicial de los valores
eps = 0.1; %"ancho" de la onda

dom = 10;
J = round(dom/dx); % # de puntos en el espacio
N = round(8/dt); % # de puntos en el tiempo
est = 10; % # de estados de tiempo a imprimir

g = 1; %aceleración gravitacional
h = [1*ones(1,floor(J/2)), 1/2*ones(1,round(J/4)), 1*ones(1,ceil(J/4))]';

m = dx/(6*dt);
p = (g.*h(:))/4;
q = 1/4;

% Sistema de la forma As^(n+1) = Bs^n
% diag(q*ones(1,J-3),1) + diag(-q*ones(1,J-3),-1);
M1 = spdiags([[m*ones(J-3,1);0], 4*m*ones(J-2,1), [m*ones(J-3,1);0]], -1:1, J-2,J-2);
M2 = spdiags([[-p(1:J-3);0],[p(1:J-3);0]], [-1,1], J-2,J-2);
M3 = spdiags([[-q*ones(J-3,1);0],[q*ones(J-3,1);0]], [-1,1], J-2,J-2);

A = [M1, M2; M3, M1];
B = [M1, -M2; -M3, M1];

C = A\B;

% Valores iniciales de la matriz de solución
sol = zeros(2*J-4,N);
X = dx:dx:(J-1)*dx;
eta = exp(-(X-a).^2 ./ eps);

for i = 1:J-2
    sol(i,1) = h(i+1)*eta(i+1);
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
aux(:,k) = sol(J-1:2*J-4,1);
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

tiledlayout(2,1)
nexttile
plot(X, [zeros(1,est);aux])
nexttile
plot(X, h(1:999))

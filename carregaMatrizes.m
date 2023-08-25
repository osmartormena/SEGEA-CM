function M = carregaMatrizes
%carregaMatrizes Carrega e processa os dados das matrizes curriculares do
%Sistema Acadêmico. 
%   É criada uma tabela 'M' com todas as informações das unidades
%   curriculares do campus.

%% Carrega arquivo
load("data/matriz.mat", "M")

%% Remove colunas irrelevantes
M.Periodo = [];
M.OPT = [];
M.AT = [];
M.AP = [];
M.TA = [];
M.APS = [];
M.APCC = [];
M.AD = [];
M.CHEXT = [];
M.CHEAD = [];
M.CHT = [];
M.Pre = [];
M.Equivalente = [];
M.CH = [];
M.Grupo = [];

%% Agrupar duplicatas em múltiplas matrizes
[N, ~] = size(M);
n = 1;
while n<N
    if strcmp(M.Codigo(n), M.Codigo(n + 1))
        M.Matriz(n) = strcat(M.Matriz(n), ", ", M.Matriz(n + 1));
        M(n + 1, :) = []; 
        n = n - 1;
        N = N - 1;
    end
    n = n + 1;
end

end

% ativo = { ...
%     "44", [3, 4, 5, 6, 7, 8, 9, 10];    ... Engenharia Eletrônica
%     "88", [1, 2];                       ... Engenharia Eletrônica
%     };
% optativas = { ...
%     "[17]", ["FC32O", "TCFH3ON", "HC32O", "TS32O"]; ... Matriz 44 — Ciências Humanas (2–5)
%     "[23]", ["RB39O", "C439O", "IE39O"];            ... Matriz 44 — Optativas de Aprofundamento (9-10)
%     };

% Filtra apenas os períodos ativos das matrizes
% [I, ~] = size(ativo);
% n = 1;
% for i=1:I
%     rows = T(T.Matriz==ativo{i, 1} & any(T.Periodo==ativo{i, 2}, 2), :);
%     [N, ~] = size(rows);
%     M(n:n + N - 1, :) = rows;
%     n = n + N;
% end

% Insere as optativas ativas no semestre
% [N, ~] = size(optativas);
% for i=1:N
%     rows = T(T.OPT==optativas{i, 1} & any(T.OPT==optativas{i, 2}, 2), :);
%     [nrows, ~] = size(rows);
%     M(n:n + nrows - 1, :) = rows;
%     n = n + nrows;
% end

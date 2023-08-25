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

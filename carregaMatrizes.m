function M = carregaMatrizes(matrizes, ativo)
%carregaMatrizes Carrega e processa os dados das matrizes curriculares do
%Sistema Acadêmico.
%   A entrada 'matrizes' é uma string que aponta para um arquivo CSV
%   contendo todas as matrizes do campus, concatenadas em uma única tabela.
%   A entrada 'ativo' é uma célula com a discriminação dos períodos ativos
%   das matrizes curriculares.
%   É criada uma tabela 'M' com todas as informações das disciplinas ativas
%   do campus.

% Configuração da importação
opts = detectImportOptions(matrizes);
varNames = {'Matriz', 'Periodo', 'Codigo', 'Disciplina', 'Modelo', 'CHT'};
varTypes = {'string', 'uint8', 'string', 'string', 'string', 'string', ...
    'uint16', 'uint16', 'uint16', 'uint16', 'uint16', 'uint16', ...
    'uint16', 'uint16', 'string', 'string', 'string', 'uint16', 'string'};
opts.SelectedVariableNames = varNames;
opts.VariableTypes = varTypes;
opts.MissingRule = 'omitrow';
T = readtable(matrizes, opts);

% Remoção das compontentes curriculares
T(T.Disciplina=="Disciplina",:) = [];
T(T.Modelo=="ENADE INGRESSANTE",:) = [];
T(T.Modelo=="ENADE CONCLUINTE",:) = [];
T(T.Modelo=="ATIVIDADES COMPLEMENTARES",:) = [];
T(T.Modelo=="ESTÁGIO",:) = [];
T(T.Modelo=="TRABALHO DE CONCLUSÃO",:) = [];
T.Modelo = [];

% Ajuste do formato dos dados
T.Codigo = erase(T.Codigo, "Turmas");
T.Codigo = strtrim(T.Codigo);
T.CHT = erase(T.CHT, "horas");
T.CHT = strtrim(T.CHT);
T.CHT = uint16(str2double(T.CHT));

% Filtra apenas os períodos ativos das matrizes
[N, ~] = size(ativo);
n = 1;
for i=1:N
    rows = T(T.Matriz==ativo{i, 1} & any(T.Periodo==ativo{i, 2}, 2), :);
    [N, ~] = size(rows);
    M(n:n + N - 1, :) = rows;
    n = n + N;
end

% Agrupar duplicatas em múltiplas matrizes
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
M.Matriz = categorical(M.Matriz);
% M.Periodo = categorical(M.Periodo);


% Ordenar a Matriz
M = sortrows(M, {'Periodo', 'Codigo'});

end

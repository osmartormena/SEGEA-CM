function M = carregaMatrizes(matrizes)
%carregaMatrizes Carrega e processa os dados das matrizes curriculares do
%Sistema Acadêmico.
%   A entrada 'matrizes' é uma string que aponta para um arquivo CSV
%   contendo todas as matrizes do campus, concatenadas em uma única tabela.
%   É criada uma tabela 'M' com todas as informações das disciplinas ativas
%   do campus.

% Configuração da importação
opts = detectImportOptions(matrizes);
varNames = {'Matriz', 'Codigo', 'Disciplina', 'Modelo'};
varTypes = {'string', 'uint8', 'string', 'string', 'string', 'string', ...
    'uint16', 'uint16', 'uint16', 'uint16', 'uint16', 'uint16', ...
    'string', 'string', 'string', 'string', 'string'};
opts.SelectedVariableNames = varNames;
opts.VariableTypes = varTypes;
opts.MissingRule = 'omitrow';
M = readtable(matrizes, opts);

% Remoção das compontentes curriculares
M(M.Disciplina=="Disciplina",:) = [];
M(M.Modelo=="ENADE INGRESSANTE",:) = [];
M(M.Modelo=="ENADE CONCLUINTE",:) = [];
M(M.Modelo=="ATIVIDADES COMPLEMENTARES",:) = [];
M(M.Modelo=="ESTÁGIO",:) = [];
M(M.Modelo=="TRABALHO DE CONCLUSÃO",:) = [];
M.Modelo = [];

% Ajuste do formato dos dados
M.Codigo = erase(M.Codigo, "Turmas");
M.Codigo = strtrim(M.Codigo);

% Ordenar a Matriz
M = sortrows(M, {'Codigo','Matriz'});

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

end

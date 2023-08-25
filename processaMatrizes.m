% Processa as matrizes e salva em arquivo de dados
clear
clc

%% Definições gerais
matrizes = "data/Matrizes.csv";

%% Configuração da importação
opts = detectImportOptions(matrizes);
varNames = {'Matriz', 'Periodo', 'OPT', 'Codigo', 'Disciplina', ...
    'Modelo', 'AT', 'AP', 'TA', 'APS', 'APCC', 'AD', 'CHEXT', 'CHEAD', ...
    'CHT', 'Pre', 'Equivalente', 'CH', 'Grupo'};
varTypes = {'string', 'uint8', 'string', 'string', 'string', 'string', ...
    'uint16', 'uint16', 'uint16', 'uint16', 'uint16', 'uint16', ...
    'uint16', 'uint16', 'string', 'string', 'string', 'uint16', 'string'};
opts.SelectedVariableNames = varNames;
opts.VariableTypes = varTypes;
M = readtable(matrizes, opts);

%% Remoção das compontentes curriculares
M(M.Disciplina=="Disciplina", :) = [];
M(M.Periodo==0, :) = [];
M(M.Modelo=="ENADE INGRESSANTE", :) = [];
M(M.Modelo=="ENADE CONCLUINTE", :) = [];
M(M.Modelo=="ATIVIDADES COMPLEMENTARES", :) = [];
M(M.Modelo=="ESTÁGIO", :) = [];
M(M.Modelo=="TRABALHO DE CONCLUSÃO", :) = [];
M.Modelo = [];

%% Ajuste do formato dos dados
M.Codigo = erase(M.Codigo, "Turmas");
M.Codigo = strtrim(M.Codigo);
M.CHT = erase(M.CHT, "horas");
M.CHT = strtrim(M.CHT);
M.CHT = uint16(str2double(M.CHT));
[N, ~] = size(M);
for n = 1:N
    M.Pre(n) = replace(M.Pre(n), newline, ';');
    M.Equivalente(n) = replace(M.Equivalente(n), newline, ';');
    M.Grupo(n) = replace(M.Grupo(n), newline, ';');
end

%% Ordenar a Matriz
M.Matriz = categorical(M.Matriz);
M = sortrows(M, {'Matriz', 'Periodo', 'Codigo'});

%% Exportar variável
save("data/matriz.mat", "M")

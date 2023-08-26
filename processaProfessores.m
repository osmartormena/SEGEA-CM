% Processa as matrizes e salva em arquivo de dados
clear
clc

%% Definições gerais
professores = "data/Professores.csv";

%% Configuração da importação
opts = detectImportOptions(professores);
varNames = {'Nome', 'Email', 'Departamento', 'Carreira', 'Aulas'};
varTypes = {'string', 'string', 'string', 'string', 'uint8'};
opts.SelectedVariableNames = varNames;
opts.VariableTypes = varTypes;
P = readtable(professores, opts);
 
%% Ordenar os professores
P.Departamento = categorical(P.Departamento);
P.Carreira = categorical(P.Carreira);
P = sortrows(P, {'Departamento', 'Nome'});

%% Exportar variável
save("data/professores.mat", "P")

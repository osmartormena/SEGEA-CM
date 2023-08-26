% Processa as matrizes e salva em arquivo de dados
clear
clc

%% Definições gerais
salas = "data/Salas.csv";

%% Configuração da importação
opts = detectImportOptions(salas);
varNames = {'Sala', 'Bloco', 'Capacidade', 'Ambiente', 'Nome'};
varTypes = {'string', 'string', 'uint8', 'string', 'string'};
opts.SelectedVariableNames = varNames;
opts.VariableTypes = varTypes;
S = readtable(salas, opts);
 
%% Ordenar as Salas
S.Bloco = categorical(S.Bloco);
S.Ambiente = categorical(S.Ambiente);
S = sortrows(S, {'Bloco', 'Sala'});

%% Exportar variável
save("data/salas.mat", "S")

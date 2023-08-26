function S = carregaSalas
%carregaSalas Carrega e processa os dados das salas de aula no Sistema
%Acadêmico. 
%   É criada uma tabela 'S' com todas as informações dos blocos e salas do
%   campus.

%% Carrega arquivo
load("data/salas.mat", "S")

%% Remove colunas irrelevantes
S.Ambiente = [];

end

function P = carregaProfessores
%carregaSalas Carrega e processa os dados dos professores no Sistema
%Acadêmico. 
%   É criada uma tabela 'P' com todas as informações dos professores do
%   campus.

%% Carrega arquivo
load("data/professores.mat", "P")

%% Remove colunas irrelevantes
P.Email = [];
P.Carreira = [];

end

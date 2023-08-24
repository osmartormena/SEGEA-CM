% Escreve o arquivo 'utfpr-cm-<timestamp>.fet' na pasta de saída
clear
clc

%% Definições gerais
timestamp = replace(string(datetime), {' ', ':'}, '.');
saida = join(["fet/utfpr-cm-",timestamp,".fet"], '');
ativo = { ...
    "44", [3, 4, 5, 6, 7, 8, 9, 10]; ... Engenharia Eletrônica
    "88", [1, 2]; ... Engenharia Eletrônica
    };

%% Escrita do Preâmbulo do XML
preambulo = "preambulo.xml";
arquivoFET = fopen(saida, 'w');
preXML = fopen(preambulo);
fwrite(arquivoFET, fread(preXML));
fprintf(arquivoFET, "\n");
fclose(preXML);

%% Escrita da lista de disciplinas
matrizes = "data/Matrizes.csv";
M = carregaMatrizes(matrizes, ativo);
[numDisciplinas, ~] = size(M);
fprintf(arquivoFET, "<Subjects_List>\n");
for n = 1:numDisciplinas
    fprintf(arquivoFET, "<Subject>\n");
    fprintf(arquivoFET, "\t<Name>%s: %s</Name>\n", M.Codigo(n), ...
        M.Disciplina(n));
    fprintf(arquivoFET, "\t<Comments>Matriz %s</Comments>\n", M.Matriz(n));
    fprintf(arquivoFET, "</Subject>\n");
end
fprintf(arquivoFET, "</Subjects_List>\n\n");

%% Escrita dos marcadores de atividades
fprintf(arquivoFET, "<Activity_Tags_List>\n");
fprintf(arquivoFET, "</Activity_Tags_List>\n\n");

%% Escrita da lista de docentes
fprintf(arquivoFET, "<Teachers_List>\n");
fprintf(arquivoFET, "</Teachers_List>\n\n");

%% Escrita da lista de turmas
fprintf(arquivoFET, "<Students_List>\n");
fprintf(arquivoFET, "</Students_List>\n\n");

%% Escrita da lista de distribuição de aulas
fprintf(arquivoFET, "<Activities_List>\n");
fprintf(arquivoFET, "</Activities_List>\n\n");

%% Escrita da lista de prédios
fprintf(arquivoFET, "<Buildings_List>\n");
fprintf(arquivoFET, "</Buildings_List>\n\n");

%% Escrita da lista de salas
fprintf(arquivoFET, "<Rooms_List>\n");
fprintf(arquivoFET, "</Rooms_List>\n\n");

%% Escrita da lista de restrições de tempo
fprintf(arquivoFET, "<Time_Constraints_List>\n");
fprintf(arquivoFET, "<ConstraintBasicCompulsoryTime>\n");
fprintf(arquivoFET, "\t<Weight_Percentage>100</Weight_Percentage>\n");
fprintf(arquivoFET, "\t<Active>true</Active>\n");
fprintf(arquivoFET, "\t<Comments></Comments>\n");
fprintf(arquivoFET, "</ConstraintBasicCompulsoryTime>\n");
fprintf(arquivoFET, "</Time_Constraints_List>\n\n");

%% Escrita da lista de restrições de espaço
fprintf(arquivoFET, "<Space_Constraints_List>\n");
fprintf(arquivoFET, "<ConstraintBasicCompulsorySpace>\n");
fprintf(arquivoFET, "\t<Weight_Percentage>100</Weight_Percentage>\n");
fprintf(arquivoFET, "\t<Active>true</Active>\n");
fprintf(arquivoFET, "\t<Comments></Comments>\n");
fprintf(arquivoFET, "</ConstraintBasicCompulsorySpace>\n");
fprintf(arquivoFET, "</Space_Constraints_List>\n\n");

%% Finalização do XML
fprintf(arquivoFET, "</fet>\n");
fclose(arquivoFET);

% Escreve o arquivo 'utfpr-cm-<timestamp>.fet' na pasta de saída
clear
clc

%% Definições gerais
timestamp = replace(string(datetime), {' ', ':'}, '.');
saida = join(["fet/utfpr-cm-",timestamp,".fet"], '');

%% Escrita do Preâmbulo do XML
preambulo = "preambulo.xml";
arquivoFET = fopen(saida, 'w');
preXML = fopen(preambulo);
fwrite(arquivoFET, fread(preXML));
fprintf(arquivoFET, "\n");
fclose(preXML);

%% Escrita da lista de disciplinas
M = carregaMatrizes;
[N, ~] = size(M);
fprintf(arquivoFET, "<Subjects_List>\n");
for n = 1:N
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
S = carregaSalas;
B = categories(S.Bloco);
fprintf(arquivoFET, "<Buildings_List>\n");
for n = 1:length(B)
    fprintf(arquivoFET, "<Building>\n");
    fprintf(arquivoFET, "\t<Name>Bloco %c</Name>\n", B{n});
    fprintf(arquivoFET, "\t<Comments></Comments>\n");
    fprintf(arquivoFET, "</Building>\n");
end
fprintf(arquivoFET, "</Buildings_List>\n\n");

%% Escrita da lista de salas
[N, ~] = size(S);
fprintf(arquivoFET, "<Rooms_List>\n");
for n = 1:N
    fprintf(arquivoFET, "<Room>\n");
    fprintf(arquivoFET, "\t<Name>%s</Name>\n", S.Sala(n));
    fprintf(arquivoFET, "\t<Building>Bloco %c</Building>\n", S.Bloco(n));
    fprintf(arquivoFET, "\t<Capacity>%u</Capacity>\n", S.Capacidade(n));
    fprintf(arquivoFET, "\t<Virtual>false</Virtual>\n");
    if ismissing(S.Nome(n))
        fprintf(arquivoFET, "\t<Comments></Comments>\n");
    else
        fprintf(arquivoFET, "\t<Comments>%s</Comments>\n", S.Nome(n));
    end
    fprintf(arquivoFET, "</Room>\n");
end
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

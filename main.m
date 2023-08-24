% Escreve o arquivo 'utfpr-cm-<timestamp>.fet' na pasta de saída
clear
clc

%% Definições iniciais
timestamp = replace(string(datetime), {' ', ':'}, '.');
saida = join(["fet/utfpr-cm-",timestamp,".fet"], '');
preambulo = "preambulo.xml";

%% Escrita do Preâmbulo do XML
arquivoFET = fopen(saida, 'w');
preXML = fopen(preambulo);
fwrite(arquivoFET, fread(preXML));
fprintf(arquivoFET, "\n");
fclose(preXML);

%% Escrita da lista de disciplinas
fprintf(arquivoFET, "<Subjects_List>\n");
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

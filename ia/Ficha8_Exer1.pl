aluno(1,joao,n).
aluno(2,antonio,n).
aluno(3,carlos,n).  
aluno(4,luisa,f).
aluno(5,maria,f).
aluno(6,isabel,f).

curso(1,lei).
curso(2,miei).
curso(3,lcc).

%disciplina(cod,sigla,ano,curso)
disciplina(1,ed,2,1).
disciplina(2,ia,3,1).
disciplina(3,fp,1,2).

%inscrito(aluno,disciplina)
inscrito(1,1).
inscrito(1,2).
inscrito(5,3).
inscrito(5,5).
inscrito(2,5).

%nota(aluno,disciplina,nota)
nota(1,1,15).
nota(1,2,16).
nota(1,5,20).
nota(2,5,10).
nota(3,5,8).

%copia
copia(1,2).
copia(2,3).
copia(3,4).



% 1.1 - Quais os alunos que não estão inscritos em qualquer disciplina;
nao_inscrito(L) :- findall(Aluno,aluno(ID, Aluno, _),\+(inscrito(ID, _)),L).


% 1.2 - Quais os alunos que não estão inscritos em qualquer disciplina, assumindo que 
        um aluno inscrito numa disciplina que não existe não está inscrito;

    nao_inscrito_existente(L) :- findall(aluno(Aluno,_,_),\+ (inscrito(Aluno, Disciplina), disciplina(Disciplina,_,_,_)),L).
  

% 1.3 - Qual a nédia de um determinado aluno;

    media_aluno(Aluno, Media) :-
    aluno(Aluno, _, _),
    findall(Nota, nota(Aluno, _, Nota), Notas),
    length(Notas, NumNotas),
    NumNotas > 0,
    sum_list(Notas, Soma),
    Media is Soma / NumNotas.

% 1.4 - Quais os alunos cuja nédia é acima da nédia (considere todas as notas de todas as disciplinas);

% 1.5 - Quais os nomes dos alunos que copiaram;

    copiaram(L) :- findall(Nome,copia(Aluno,_),aluno(Aluno,Nome,_),L).






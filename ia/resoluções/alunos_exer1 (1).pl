
aluno(1,joao,m).
aluno(2,antonio,m).
aluno(3,carlos,m).
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

%------------------ alinea i)

alunosIncritos(Aluno) :- aluno(Numero, Aluno,_), not(inscrito(Numero,_)).

naoinscrito(L):- findall(Aluno, alunosIncritos(Aluno), L).


% --alínea ii) 

concatenar( [],L2,L2 ).
concatenar( [X|R],L2,[X|L] ) :-
							concatenar( R,L2,L ).

disciplinaNaoExiste(Aluno) :- aluno(Numero, Aluno,_), inscrito(Numero, D), not(disciplina(D,_,_,_)).

naoinscrito2(S) :- findall(Aluno, disciplinaNaoExiste(Aluno), L), naoinscrito(R), concatenar(L, R, S).

% --alínea iii)

% Tamanho de uma Lista
tamL([_], 1):- !.
tamL([_|L], T):- tamL(L, X), T is X + 1.

somaL([],0).
somaL([H|T],S):-somaL(T,G),S is H+G.



% Média aritmética de uma lista
mediaA(L,M):- somaL(L, S), tamL(L,T), M is S / T.


media(Aluno,M):-aluno(Numero,Aluno,_), findall(N,nota(Numero,_,N),Ls), mediaA(Ls,M).


% --alínea iv)

lista_acima_media(M,R) :- findall(Aluno, (media(Aluno,MediaA), MediaA > M), R).

acimamedia(Aluno):-findall(N, nota(_,_,N),L), mediaA(L,M), lista_acima_media(M,Aluno).

% --alínea v)

copiaram(Nome):-aluno(Numero, Nome,_), copia(_,Numero).

todosC(L):-findall(Nome,copiaram(Nome),L).
 

% --alínea vi)

%-----------copiar indireto
 copiou(X,Y):-copia(X,Y).
 copiou(X,Y):-copia(A,Y), copiou(X,A).
 
%--------maptolist vii)
 

 
 maptolist([],[]).
 maptolist([H|T], [N|T1]):- aluno(H,N,_), maptolist(T,T1); maptolist(T,T1).


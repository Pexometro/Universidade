%LICENCIATURA EM ENGENHARIA INFORMATICA
%MESTRADO integrado EM ENGENHARIA INFORMATICA

%Inteligencia Artificial
%2023/24

%Ficha 7


% Parte I
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Operacoes aritmeticas

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado soma: X,Y,Z,Soma -> {V,F}

soma( X,Y,Z,Soma ) :-
    Soma is X+Y+Z.



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado somaL: L ,Soma -> {V,F}

somaL([],0).
somaL([H|T],S):-somaL(T,G),S is H+G.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Calculo do maior de 2 numeros.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior: X,Y,R -> {V,F}

maior1(X,Y,X) :-
    X > Y.
maior1(X,Y,Y).

maior2(X,Y,X) :-
    X > Y,!.
maior2(X,Y,Y).

maior3(X,Y,X) :-
    X > Y.
maior3(X,Y,Y) :-
   X =< Y.

% Extensao do predicado maior: Lista, M, Resultado -> {V,}


accMax([H|T],A,Max):- H > A,
                      accMax(T,H,Max).
accMax([H|T],A,Max):- H =< A,
                      accMax(T,A,Max).
accMax([],A,A).
max([H|T],Max):-accMax(T,H,Max).


% Quantidade de elementos de uma lista.
qtde([],0).
qtde([_|T],S):-qtde(T,G),S is 1+G.

% Tamanho de uma Lista
tamL([_], 1):- !.
tamL([_|L], T):- tamL(L, X), T is X + 1.

% Média aritmética de uma lista
mediaarit(L,M):- somaL(L, S), tamL(L,T), M is S / T.


% verificar se um numero é par


par( 0 ).
par( X ) :-
    N is X-2,
    N >= 0,
    par( N ).




%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado impar: N -> {V,F}

impar( 1 ).
impar( X ) :-
    N is X-2,
    N >= 1,
    impar( N ).



% Parte II--------------------------------------------------------- - - - - -


% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).


% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento( [],0 ).
comprimento( [X|L],N ) :-
	comprimento( L,N1 ),
	N is N1+1.


% Extensao do predicado quantos: Lista,Comprimento -> {V,F}




quantos( [],0 ).
quantos( [X|L],N ) :-
	pertence( X,L ),
	quantos( L,N ).
quantos( [X|L],N1 ) :-
	nao( pertence( X,L ) ),
	quantos( L,N ), N1 is N+1.


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}

apagar( X,[X|R],R ).
apagar( X,[Y|R],[Y|L] ) :-
	X \= Y,
	apagar( X,R,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagatudo( X,[],[] ).
apagatudo( X,[X|R],L ) :-
	apagatudo( X,R,L ).
apagatudo( X,[Y|R],[Y|L] ) :-
	X \= Y,
	apagatudo( X,R,L ).



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

adicionar( X,L,L ) :-
	pertence(X,L).
adicionar( X,L,[X|L] ) :-
	nao( pertence( X,L ) ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}

concatenar( [],L2,L2 ).
concatenar( [X|R],L2,[X|L] ) :-
	concatenar( R,L2,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}

inverter( [],[] ).
inverter( [X|R],NL ) :-
	inverter( R,L ),
	concatenar( L,[X],NL ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

sublista( S,L ) :-
	concatenar( L1,L3,L ),
	concatenar( S,L2,L3 ).

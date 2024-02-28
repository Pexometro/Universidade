%LICENCIATURA EM ENGENHARIA INFORMATICA
%MESTRADO integrado EM ENGENHARIA INFORMATICA

%Inteligencia Artificial
%2023/24

%Draft Ficha 7


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

somaL([], 0).
somaL([Head|Tail], Soma) :-
    somaL(Tail, Resto),
    Soma is Head + Resto.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior: X,Y,R -> {V,F}

maior_entre(X, Y, Maior) :-
    (X > Y ->
        Maior = X;
        Maior = Y
    ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado maior: Lista, M, Resultado -> {V,}

maior_lista([X], X). % Caso base: Maior de uma lista com um único elemento é esse próprio elemento

% Encontra o maior elemento de uma lista
maior_lista([X|Xs], Maior) :-
    maior_lista(Xs, RestoMaior),  % Encontra o maior no resto da lista
    maior_entre(X, RestoMaior, Maior).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Quantidade de elementos de uma lista.

num_elementos(Lista, Quantidade) :-
    length(Lista, Quantidade).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Tamanho de uma Lista


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Média aritmética de uma lista

media_list(Valores,Media):-
    somaL(Valores,Soma),
    length(Valores,NumeroElementos),
    Media is Soma/NumeroElementos

 %--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Predicado para inserir um elemento em uma lista ordenada

inserir(El,[],[E]).
inserir(El,)
    
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% verificar se um numero é par

par(N) :- N mod 2 =:= 0.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado impar: N -> {V,F}


% Parte II--------------------------------------------------------- - - - - -



%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pertence: Elemento,Lista -> {V,F}

pertence( X,[X|L] ).
pertence( X,[Y|L] ) :-
    X \= Y,
    pertence( X,L ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado comprimento: Lista,Comprimento -> {V,F}

comprimento([], 0).
comprimento([X|Resto], Comprimento) :-
    comprimento(Resto, ComprimentoResto),
    Comprimento is ComprimentoResto + 1.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado quantos: Lista,Comprimento -> {V,F} 

quantos([],0).
quantos([X|L], N) :-
    pertence(X,L),
    quantos(L,N).
quantos ([X|L],N1) :-
    nao(pertence(X,L) ),
    quantos(L,N), N1 is N + 1


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagar: Elemento,Lista,Resultado -> {V,F}

apaga1(X, [X|L], L).
apaga1(X, [Y|L], [Y|Restante]) :-
    X \= Y
    apaga1(X, L, Restante).
              
%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado apagatudo: Elemento,Lista,Resultado -> {V,F}

apagatudo(X,[],[]).
apagatudo(X,[X|R],L) :-
    apagatudo(X,R,L).
apagatudo(X,[Y|R],[Y|L]):-
    X /= Y
    apagatudo(X,R,L).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado adicionar: Elemento,Lista,Resultado -> {V,F}

% Não permite repetidos

adicionar(X,L,L) :-
    pertence(X,L).
adicionar(X,L,[X,L]) :-
    nao (pertence (X,L)).

% Permite repetidos
 
adicionar(X,L,[X,L]).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado concatenar: Lista1,Lista2,Resultado -> {V,F}

concatenar ([],L2,L2).
concatenar ([X,R],L2,[X,L]) :-
    concatenar(R,L2,L).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado inverter: Lista,Resultado -> {V,F}


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado sublista: SubLista,Lista -> {V,F}

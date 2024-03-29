%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Inteligência Artificial- MiEI/3 LEI/3

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Base de Conhecimento com informacao genealogica.

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado filho: Filho,Pai -> {V,F}

filho( joao,jose ).
filho( jose,manuel ).
filho( carlos,jose ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado pai: Pai,Filho -> {V,F}

pai( P,F ) :-
    filho( F,P ).


%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado avo: Avo,Neto -> {V,F}

avo( A,N ) :-
    filho( N,X ),
    filho( X,A ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado bisavo: Bisavo,Bisneto -> {V,F}

bisavo( A,D ) :-
    descendente( D,A,3 ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente -> {V,F}


descendente( D,A ) :-
    filho( D,A ).
descendente( D,A ) :-
    filho( D,X ),
    descendente( X,A ).

%--------------------------------- - - - - - - - - - -  -  -  -  -   -
% Extensao do predicado descendente: Descendente,Ascendente,Grau -> {V,F}


descendente( D,A,1 ) :-
    filho( D,A ).
descendente( D,A, G  ) :-
    filho( D,X ),
    descendente( X,A,N ),
	G is N+1.

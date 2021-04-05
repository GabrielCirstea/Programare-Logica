membru(X,[X|_]).
membru(X,[_|T]) :- membru(X,T).

% Sa observam urmatoarele particularitati ale functionarii lui setof, bagof, findall:

testsetof(L1, L2, L) :- setof(X, (membru(X,L1), membru(Y,L2), X<Y), L).

testbagof(L1, L2, L) :- bagof(X, (membru(X,L1), membru(Y,L2), X<Y), L).

testfindall(L1, L2, L) :- findall(X, (membru(X,L1), membru(Y,L2), X<Y), L).

/* Dintre aceste predicate, numai findall cuantifica existential variabilele care apar in
conditie, dar nu in termenii care sunt colectati in lista. Sintaxa pentru cuantificarea
existentiala fortata a acelor variabile:
setof(Termen, Variabile^Conditie, ListaTermeni).%colectarea termenilor fara duplicate
bagof(Termen, Variabile^Conditie, ListaTermeni).%echivalent cu: findall(Termen, Conditie, ListaTermeni).
Termenii vor fi colectati in ListaTermeni ordonati dupa valorile variabilelor din Conditie,
considerate in ordinea in care aceste variabile apar in Conditie. */

colecttotifdup(L1, L2, L) :- setof(X, Y^(membru(X,L1), membru(Y,L2), X<Y), L).

colecttoticudup(L1, L2, L) :- bagof(X, Y^(membru(X,L1), membru(Y,L2), X<Y), L).

colecttotitotcudup(L1, L2, L) :- findall(X, (membru(X,L1), membru(Y,L2), X<Y), L).

elimdup([],[]).
elimdup([H|T],[H|L]) :- not(membru(H,T)), elimdup(T,L), !.
elimdup([_|T],L) :- elimdup(T,L).

/* Interogati:
?- testsetof([1,2,2,2,3],[0,1,2,3,4,5],L).
?- testbagof([1,2,2,2,3],[0,1,2,3,4,5],L).
?- testfindall([1,2,2,2,3],[0,1,2,3,4,5],L), write(L).
?- colecttotifdup([1,2,2,2,3],[0,1,2,3,4,5],L).
?- colecttoticudup([1,2,2,2,3],[0,1,2,3,4,5],L), write(L).
?- colecttotitotcudup([1,2,2,2,3],[0,1,2,3,4,5],L), write(L).
?- colecttoticudup([1,2,2,2,3],[0,1,2,3,4,5],L), elimdup(L,M).
?- colecttotitotcudup([1,2,2,2,3],[0,1,2,3,4,5],L), elimdup(L,M).
Sa colectam si termeni compusi, cu mai multe variabile: */

colectfdup(L1,L2,L3,L4,L) :- setof(fct(X,V),
	(V,Y,Z)^(membru(X,L1), membru(Y,L2), membru(Z,L3), membru(V,L4), Y<X, X<Z), L).

/* Interogati:
?- colectfdup([1,2,2,2,3],[0,1,1,2],[0,1,2,3,4,5],[a,a,a,b,b,c],L), write(L).
?- colectfdup([1,2,2,2,3],[1,1,2],[0,1,2,3,4,5],[a,a,a,b,b,c],L), write(L).
*/



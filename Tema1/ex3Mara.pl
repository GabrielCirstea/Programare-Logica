% rotatie cu 1 elem spre stanga 
%rotesteCuOPozitieSpreStanga([1,2,3,4]) -> [2,3,4,1] 
rotesteCuOPozitieSpreStanga([H|T], R) :- append(T, [H], R).

%rotatie cu N pozitii spre stanga
rotesteCuNPozitiiSpreStanga(_,[],[]). 
rotesteCuNPozitiiSpreStanga(0, L, L). 
rotesteCuNPozitiiSpreStanga(N, [H|T], R) :- N > 0, rotesteCuOPozitieSpreStanga([H|T], RI), M is N-1, rotesteCuNPozitiiSpreStanga(M, RI, R).
% 1,2,3,4 -> 2,3,4,1 -> 3,4,1,2


%desparte o lista intr-o lista de liste:
%daca lungimea listei este divizibila cu N -> lista de liste de lungime n 
%daca lungimea listei nu este divizibila cu N -> lista de liste de lungime n si inca o lista cu maxim N-1 elemente
split(_, [], []).
split(N, List, [ A|Rez ]) :- length(List, R), R >= N, append(A, B, List), length(A, N), split(N, B, Rez).
split(N, List, [Rez]) :- length(List, R), R < N, Rez = List.

eliminaElementDinLista(X,[X|T],T).  
eliminaElementDinLista(X,[K|T],[K|S]) :- eliminaElementDinLista(X,T,S).


genereazaPermutareaListei([X|Y],Z) :- genereazaPermutareaListei(Y,W), eliminaElementDinLista(X,Z,W).  
genereazaPermutareaListei([],[]).

%daca lungimea nu e div cu N, intoarce o lista de liste:
%prima lista e o rotatie cu un element a primelor N elem, a doua e o rotatie cu 2 elemente a urmatoarelor N elem  samd
%ultima lista e o permutare a ultimelor elemente din lista initiala
rotesteListaCuLungNedivCuN([],_,[]).
rotesteListaCuLungNedivCuN([H|T],C,[R|RR]) :- T \= [], rotesteCuNPozitiiSpreStanga(C,H,R), M is C+1, rotesteListaCuLungNedivCuN(T,M,RR). 
rotesteListaCuLungNedivCuN([H|T],_,[Res]) :- T = [], genereazaPermutareaListei(H, Res).

%daca lungimea nu e div cu N, intoarce o lista de liste:
%prima lista e o rotatie cu un element a primelor N elem, a doua e o rotatie cu 2 elemente a urmatoarelor N elem  samd
rotesteListaCuLungDivCuN([],_,[]).
rotesteListaCuLungDivCuN([H|T],C,[R|RR]) :-  rotesteCuNPozitiiSpreStanga(C,H,R), M is C+1, rotesteListaCuLungDivCuN(T,M,RR). 

%primeste un N si o lista si intoarce lista de liste dupa regulile de mai sus, in functie de divizibiliatea lungimii listei la N
%exemplu: imparteInSublisteSiAplicaRotiri(3,[1,2,3,4,5,6,7,8,9,10,11],X). -> X = [[2, 3, 1], [6, 4, 5], [7, 8, 9], [10, 11]] si urmatoare solutie X = [[2, 3, 1], [6, 4, 5], [7, 8, 9], [11, 10]]
%exemplu: imparteInSublisteSiAplicaRotiri(3,[1,2,3,4,5,6,7,8,9,10,11,12],X). ->X = [[2, 3, 1], [6, 4, 5], [7, 8, 9], [11,12,10]]

imparteInSublisteSiAplicaRotiri(N, List, Out) :- length(List, R), P is mod(R,N), P = 0, split(N,List,A), rotesteListaCuLungDivCuN(A, 1, Out).
imparteInSublisteSiAplicaRotiri(N, List, Out) :- length(List, R), P is mod(R,N), P \= 0, split(N,List,A), rotesteListaCuLungNedivCuN(A, 1, Out).

%concateneaza o lista de liste 
concateneazaListaDeListe([], []) :- !.
concateneazaListaDeListe([H|T], L) :-!, concateneazaListaDeListe(H, H1), concateneazaListaDeListe(T, T1), append(H1, T1, L).
concateneazaListaDeListe(L, [L]).

permcircsl(_,[],[]).
permcircsl(N,L,M) :-  imparteInSublisteSiAplicaRotiri(N,L,Q), concateneazaListaDeListe(Q,M).

p(0,0).
p(1,1).
p(N,X) :- N>1, K is N-1, p(K,X2), X is N + X2.

adaugare([], L,L).
adaugare([H | T], L, [H|S]) :- adaugare(T,L,S).

pereche(N, X, (N,X)).
parcurge(N,[],[]).
parcurge(N,[H | T],[H2 | T2]) :- pereche(N,H,H2),Nr is N+1,write(Nr), parcurge(Nr,T,T2).
predicat([],M).
predicat(L,M) :- parcurge(1,L,M).

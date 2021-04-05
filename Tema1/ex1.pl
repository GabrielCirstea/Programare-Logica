pereche(N, X, (N,X)).
parcurge(_,[],[]).
parcurge(N,[H | T],[H2 | T2]) :- pereche(N,H,H2),Nr is N+1, parcurge(Nr,T,T2).
perindval([],[]).
perindval(L,M) :- parcurge(1,L,M).

% Druulike

% aplatizeaza o lista de liste 

linlist([], []) :- !.
linlist([H|T], L) :-!, linlist(H, H1), linlist(T, T1), append(H1, T1, L).
linlist(L, [L]).

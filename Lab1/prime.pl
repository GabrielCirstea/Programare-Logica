% prim(N)=true <=> N e numar natural prim

prim(0) :- fail.
prim(1) :- fail.
prim(N) :- integer(N), N>1, nusediv(N,2).

/* nusediv(N,D)=true <=> N nu se divide cu niciun numar natural >= D si
                                   =< decat radacina patrata a lui N */

nusediv(N,D) :- C is D*D, (C>N; C=<N, N mod D>0, Div is D+1, nusediv(N,Div)).

/* prime(N,LP)=true <=> LP = lista descrescatoare a numerelor naturale prime =< N
   primele(N,LP)=true <=> LP = lista crescatoare a numerelor naturale prime =< N
Pentru afisarea intregii liste (nu doar a primelor sale 10 elemente), interogati:
?- prime(100,LP), write(LP).
?- primele(100,LP), write(LP).
*/

prime(N,LP) :- genlist(N,L), alegprime(L,LP).

primele(N,LP) :- genlista(0,N,L), alegprime(L,LP).

% genlist(N,L)=true <=> L = lista descrescatoare a numerelor naturale =< N
% genlista(K,N,L)=true <=> L = lista crescatoare a numerelor naturale >= K si =< N

genlist(0,[0]).
genlist(N,[N|L]) :- N>0, P is N-1, genlist(P,L).

genlista(N,N,[N]).
genlista(K,N,[K|L]) :- K<N, S is K+1, genlista(S,N,L).

% alegprime(L,LP)=true <=> LP = lista numerelor naturale prime din lista L

alegprime([],[]).
alegprime([H|T],[H|M]) :- prim(H), alegprime(T,M).
alegprime([H|T],M) :- not(prim(H)), alegprime(T,M).


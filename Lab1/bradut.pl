stelute(0).
stelute(K) :- K>0, write(*), tab(1), P is K-1, stelute(P).

linii(0,_).
linii(K,N) :- K>0, PK is K-1, linii(PK,N), nl, S is N-K, tab(S), stelute(K). 

bradut(N) :- linii(N,N).

/* bradut(N) realizeaza urmatorul desen pe ecran, cu N linii, apoi intoarce true:

   * 
  * *
 * * * linia K: N-K blankuri, K perechi *+blank
* * * * N perechi *+blank

Sa realizam acest desen cu o implementare care functioneaza si in
Prologul online (editie limitata), care nu recunoaste tabulatorul
si nu scrie mai mult de un blank succesiv pe ecran: */

spatii(0).
spatii(S) :- S>0, write('-'), P is S-1, spatii(P).

steluteonline(0).
steluteonline(K) :- K>0, write(*), write(' '), PK is K-1, steluteonline(PK).

liniionline(0,_).
liniionline(K,N) :- K>0, PK is K-1, liniionline(PK,N), nl,
                    S is N-K, spatii(S), steluteonline(K). 

bradutonline(N) :- liniionline(N,N).

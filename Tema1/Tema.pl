% ex 1

pairs([H|[]], N, [(N,H)]).
pairs([H|T],N, [(N,H)|K]) :- N1 is N+1, pairs(T,N1,K).  

perindval([], []).
perindval(L,M):- pairs(L,1,M).

%ex 2

% prim(N)=true <=> N e numar natural prim

prim(0) :- fail.
prim(1) :- fail.
prim(N) :- integer(N), N>1, nusediv(N,2).

/* nusediv(N,D)=true <=> N nu se divide cu niciun numar natural >= D si
=< decat radacina patrata a lui N */
nusediv(N,D) :- C is D*D, (C>N; C=<N, N mod D>0, Div is D+1, nusediv(N,Div)).

% alegprime(L,LP)=true <=> LP = lista numerelor naturale prime din lista L
alegprime([],[]).
alegprime([H|T],[H|M]) :- prim(H), alegprime(T,M).
alegprime([H|T],M) :- not(prim(H)), alegprime(T,M).

%verifica daca lista data ca input este formata doar din cifre
numaiCifre([X|[]]) :-integer(X), X >= 0, X < 10.
numaiCifre([H | T]) :- integer(H), H >= 0, H < 10, numaiCifre(T).

%concateneaza doua liste
concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

% generam permutari
%extrage capul listei de input si il pune in lista de output 
takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).

%permuta elementele listei
perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).
perm([],[]).

% construieste un numar din lista de cifre incepand cu cifra N
faNumar([],N,N).
faNumar([H|T],N, R) :- Nr is N*10 + H, faNumar(T,Nr,R).


%getList genereaza o lista de permutari a listei de input
getList(L,Bag) :- findall(X,perm(L,X),Bag).

% contruieste numere din lista de cifre
faLista([H| []],L, R) :- faNumar(H,0,N), concat(L,[N],R).
faLista([H | T] ,L,R) :- faNumar(H,0,N), concat(L,[N],L2), faLista(T,L2,R).

% Punctul a)
primelistcf(L,R) :- numaiCifre(L), getList(L,Bag), faLista(Bag,[],Lista), alegprime(Lista,Res),
					elimdup(Res,R).

% sunt luate de la lab
stergetot(_,[],[]).
stergetot(H,[H|T],L) :- stergetot(H,T,L).
stergetot(X,[H|T],[H|L]) :- X\=H, stergetot(X,T,L).

%elimina duplicate dintr-o lista
elimdup([],[]).
elimdup([H|T],[H|L]) :- stergetot(H,T,M), elimdup(M,L).

%verifica daca un numar se gaseste intr-o lista
membru(H, [H|_]).
membru(X, [_|T]) :- membru(X,T).

%genereaza o lista de numere distincte si mai mari decat 0
genlista(0,_,[]).
genlista(N,L,[H|T]) :- N > 0, membru(H,L), P is N-1, genlista(P,L,T).

% genereaza o lista de liste cu cifre
genListe(N,L,List) :- setof(Ls,genlista(N,L,Ls),List).

% genereaza liste cu I elemente, I de la 1 la N  si le pune intr-o lista
genNListe(0,_,L,L).
genNListe(N,L,Step, List) :- N > 0, genListe(N,L,H), concat(Step,H,Ls), P is N-1, genNListe(P,L,Ls,List).

primecfnrcf(N,L,List) :- numaiCifre(L), genNListe(N,L,[],Ls), faLista(Ls, [], Lss),
						alegprime(Lss, Res), elimdup(Res,List).

%ex 3

%rotatie cu 1 elem spre stanga 
%rotesteCuOPozitieSpreStanga([1,2,3,4]) -> [2,3,4,1] 
rotesteCuOPozitieSpreStanga([H|T], R) :- append(T, [H], R).

%rotatie cu N pozitii spre stanga
rotesteCuNPozitiiSpreStanga(_,[],[]). 
rotesteCuNPozitiiSpreStanga(0, L, L). 
rotesteCuNPozitiiSpreStanga(N, [H|T], R) :- N > 0, rotesteCuOPozitieSpreStanga([H|T], RI), M is N-1, rotesteCuNPozitiiSpreStanga(M, RI, R).


%desparte o lista intr-o lista de liste:
%daca lungimea listei este divizibila cu N -> lista de liste de lungime n 
%daca lungimea listei nu este divizibila cu N -> lista de liste de lungime n si inca o lista cu maxim N-1 elemente
split(_, [], []).
split(N, List, [ A|Rez ]) :- length(List, R), R >= N, append(A, B, List), length(A, N), split(N, B, Rez).
split(N, List, [Rez]) :- length(List, R), R < N, Rez = List.


%daca lungimea nu e div cu N, intoarce o lista de liste:
%prima lista e o rotatie cu un element a primelor N elem, a doua e o rotatie cu 2 elemente a urmatoarelor N elem  samd
%ultima lista e o permutare a ultimelor elemente din lista initiala
rotesteListaCuLungNedivCuN([],_,[]).
rotesteListaCuLungNedivCuN([H|T],C,[R|RR]) :- T \= [], rotesteCuNPozitiiSpreStanga(C,H,R), M is C+1, rotesteListaCuLungNedivCuN(T,M,RR). 
rotesteListaCuLungNedivCuN([H|T],_,[Res]) :- T = [], perm(H, Res).

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

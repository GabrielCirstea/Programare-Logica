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

primeDinLista(Lista,Result) :- alegprime(Lista,Result).
numaiCifre([X|[]]) :-integer(X), X >= 0, X < 10.
numaiCifre([H | T]) :- integer(H), H >= 0, H < 10, numaiCifre(T).

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

% permutari
takeout(X,[X|R],R).
takeout(X,[F|R],[F|S]) :- takeout(X,R,S).
perm([X|Y],Z) :- perm(Y,W), takeout(X,Z,W).
perm([],[]).

% face numar din lista de cifre
% ASIGURA-TE CA SUNT DOAR CIFRE!!!
faNumar([],N,N).
faNumar([H|T],N, R) :- Nr is N*10 + H, faNumar(T,Nr,R).

% a)
getList(L,Bag) :- findall(X,perm(L,X),Bag).
% face numere din lista de cifre
faLista([H| []],L, R) :- faNumar(H,0,N), concat(L,[N],R).
faLista([H | T] ,L,R) :- faNumar(H,0,N), concat(L,[N],L2), faLista(T,L2,R).
primelistcf(L,R) :- numaiCifre(L), getList(L,Bag), faLista(Bag,[],Lista), primeDinLista(Lista,Res),
					elimdup(Res,R).

% sunt luate de la lab
stergetot(_,[],[]).
stergetot(H,[H|T],L) :- stergetot(H,T,L).
stergetot(X,[H|T],[H|L]) :- X\=H, stergetot(X,T,L).

elimdup([],[]).
elimdup([H|T],[H|L]) :- stergetot(H,T,M), elimdup(M,L).

membru(H, [H|_]).
membru(X, [_|T]) :- membru(X,T).

genlista(0,_,[]).
genlista(N,L,[H|T]) :- N > 0, membru(H,L), P is N-1, genlista(P,L,T).

% lista de liste cu cifre
genListe(N,L,List) :- setof(Ls,genlista(N,L,Ls),List).
% face liste cu I elemente, I de la 1 la N  si le pune intr-o lista
genNListe(0,_,L,L).
genNListe(N,L,Step, List) :- N > 0, genListe(N,L,H), concat(Step,H,Ls), P is N-1, genNListe(P,L,Ls,List).
% marele predicat
primecfnrcf(N,L,List) :- numaiCifre(L), genNListe(N,L,[],Ls), faLista(Ls, [], Lss),
						primeDinLista(Lss, Res), elimdup(Res,List).

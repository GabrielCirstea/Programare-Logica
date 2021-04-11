/* Alta implementare pentru predicatele ect, eordcresc, eordstrictcresc, eorddescresc,
eordstrictdescresc din fisierul sortari.pl, folosind un predicat eordarb(Lista,Ord),
care testeaza daca Lista e sortata dupa criteriul Ord: */
concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).


eordarb([],_).
eordarb([_],_).
eordarb([H,K|T],Ord) :- Termen=..[Ord,H,K], Termen, eordarb([K|T],Ord).

ect(Lista) :- eordarb(Lista,=).

eordcresc(Lista) :- eordarb(Lista,=<).

eordstrictcresc(Lista) :- eordarb(Lista,<).

eorddescresc(Lista) :- eordarb(Lista,>=).

eordstrictdescresc(Lista) :- eordarb(Lista,>).

% Sortarea dupa un criteriu arbitrar Ord prin insertie directa:

insertsort([],[],_).
insertsort([H|T],L,Ord) :- insertsort(T,M,Ord), insert(H,M,L,Ord).

insert(X,[],[X],_).
insert(X,[H|T],[H|T],Ord) :- X==H, Termen=..[Ord,H,H], not(Termen), !. %%% caz neinserare
insert(X,[H|T],[X,H|T],Ord) :- Termen=..[Ord,X,H], Termen, !.
insert(X,[H|T],[H|L],Ord) :- insert(X,T,L,Ord).

% Sortarea prin metoda bulelor:

bubblesort(L,L, Ord) :- eordarb(L,Ord), !.
bubblesort(L,S, Ord) :- bubbles(L,M, Ord), bubblesort(M,S, Ord).

bubbles([],[], _).
bubbles([X],[X], _).
bubbles([H,K|T],[H|T], Ord) :- H==K,Termen=..[Ord,H,H],not(Termen), !.
bubbles([H,K|T],[H|L], Ord) :- Termen=..[Ord,H,K],Termen, bubbles([K|T],L,Ord), !.
bubbles([H,K|T],[K|L], Ord) :- bubbles([H|T],L, Ord).

% Sortarea rapida:

quicksort([],[],_).
quicksort([H|T],L, Ord) :- taie(H,T,Stg,Dr,Ord), quicksort(Stg,S,Ord),
				quicksort(Dr,D,Ord), concat(S,[H|D],L).

taie(_,[],[],[],_).
taie(P,[H|T],S,D,Ord) :- P==H,Termen=..[Ord,H,H],not(Termen), taie(P,T,S,D,Ord), !.
taie(P,[H|T],[H|S],D,Ord) :- Termen=..[Ord,H,P],Termen, taie(P,T,S,D,Ord), !.
taie(P,[H|T],S,[H|D],Ord) :- taie(P,T,S,D,Ord).

% Sortarea prin interclasare binara:

mergesort([],[],_).
mergesort([X],[X],_).
mergesort([H,K|T],ListaSortata, Ord) :- taiejum([H,K|T],Stg,Dr), mergesort(Stg,S, Ord),
							mergesort(Dr,D, Ord), merge(S,D,ListaSortata, Ord).

taiejum([],[],[]).
taiejum([X],[X],[]).
taiejum([H,K|T],[H|S],[K|D]) :- taiejum(T,S,D).

merge(L,[],L,_).
merge([],[H|T],[H|T],_).
merge([H|T],[K|U],[H|L], Ord) :- H==K, Termen=..[Ord,H,K], not(Termen), merge(T,U,L,Ord), !.
merge([H|T],[K|U],[H|L], Ord) :- Termen=..[Ord,H,K], Termen, merge(T,[K|U],L,Ord), !.
merge([H|T],[K|U],[K|L],Ord) :- merge([H|T],U,L,Ord), !.

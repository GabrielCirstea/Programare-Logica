/* Urmatoarele predicate unare testeaza daca o lista e: constanta,
ordonata crescator, strict crescator, descrescator, strict descrescator,
respectiv alternanta, i.e. avand cresterile si descresterile alternante. */

ect([]).
ect([_]).
ect([H,H|T]) :- ect([H|T]).

eordcresc([]).
eordcresc([_]).
eordcresc([H,K|T]) :- H=<K, eordcresc([K|T]).

eordstrictcresc([]).
eordstrictcresc([_]).
eordstrictcresc([H,K|T]) :- H<K, eordstrictcresc([K|T]).

eorddescresc([]).
eorddescresc([_]).
eorddescresc([H,K|T]) :- H>=K, eorddescresc([K|T]).

eordstrictdescresc([]).
eordstrictdescresc([_]).
eordstrictdescresc([H,K|T]) :- H>K, eordstrictdescresc([K|T]).

ealtcresc([]).
ealtcresc([_]).
ealtcresc([H,K|T]) :- H=<K, ealtdescresc([K|T]).

ealtdescresc([]).
ealtdescresc([_]).
ealtdescresc([H,K|T]) :- H>=K, ealtcresc([K|T]).

ealt(L) :- ealtcresc(L); ealtdescresc(L).

/* ealt(L)=true <=> L e lista alternanta;
ealtcresc(L)=true <=> L e lista alternanta incepand cu o crestere;
ealtdescresc(L)=true <=> L e lista alternanta incepand cu o descrestere. */

% Sortarea prin insertie directa:

insertsort([],[]).
insertsort([H|T],L) :- insertsort(T,M), insert(H,M,L).

insert(X,[],[X]).
insert(X,[H|T],[X,H|T]) :- X=<H, !.
insert(X,[H|T],[H|L]) :- insert(X,T,L).

% Sortarea prin metoda bulelor:

bubblesort(L,L) :- eordcresc(L), !.
bubblesort(L,S) :- bubbles(L,M), bubblesort(M,S).

bubbles([],[]).
bubbles([X],[X]).
bubbles([H,K|T],[H|L]) :- H=<K, bubbles([K|T],L), !.
bubbles([H,K|T],[K|L]) :- bubbles([H|T],L).

% Sortarea rapida:

quicksort([],[]).
quicksort([H|T],L) :- taie(H,T,Stg,Dr), quicksort(Stg,S), quicksort(Dr,D), concat(S,[H|D],L).

taie(_,[],[],[]).
taie(P,[H|T],[H|S],D) :- H=<P, taie(P,T,S,D), !.
taie(P,[H|T],S,[H|D]) :- taie(P,T,S,D).

% Sortarea prin interclasare binara:

mergesort([],[]).
mergesort([X],[X]).
mergesort([H,K|T],ListaSortata) :- taiejum([H,K|T],Stg,Dr), mergesort(Stg,S), mergesort(Dr,D),
		                     merge(S,D,ListaSortata).

taiejum([],[],[]).
taiejum([X],[X],[]).
taiejum([H,K|T],[H|S],[K|D]) :- taiejum(T,S,D).

merge(L,[],L).
merge([],[H|T],[H|T]).
merge([H|T],[K|U],[H|L]) :- H=<K, merge(T,[K|U],L), !.
merge([H|T],[K|U],[K|L]) :- merge([H|T],U,L), !.

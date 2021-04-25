case(ListaCase) :-
	length(ListaCase, 5),
    member(casa(rosu,britanic,_,_,_), ListaCase),
    member(casa(_,spaniol,caine,_,_), ListaCase),
    vecin(casa(verde,_,_,_,cafea),casa(alb,_,_,_,_),ListaCase),
    member(casa(_,ucrainian,_,_,ceai), ListaCase),
    member(casa(_,_,melci,oldgold,_), ListaCase),
    ListaCase = [_,_,casa(_,_,_,_,lapte),_,_],
    ListaCase = [casa(_,norvegian,_,_,_)|_],
    member(casa(_,norvegian,_,_,_), ListaCase),
    vecin(casa(_,_,_,chesterfield,_),casa(_,_,vulpe,_,_), ListaCase),
    vecin(casa(galben,_,_,kool,_),casa(_,_,cal,_,_), ListaCase),
    member(casa(_,_,_,gitanes,vin), ListaCase),
    member(casa(_,japonez,_,craven,_), ListaCase),
    vecin(casa(_,norvegian,_,_,_), casa(albastru,_,_,_,_), ListaCase),
    member(casa(_,_,_,_,apa),ListaCase),
    member(casa(_,_,zebra,_,_),ListaCase).

%adevarat ddaca A si B sunt vecini in lista L 
vecin(A, B, L) :- append(_, [A,B|_], L).
vecin(A, B, L) :- append(_, [B,A|_], L).

%obtine indexul unui element dintr-o lista
index([X|_], X, 1). 
index([_|T], X, I):- index(T, X, J), I is J+1.

%cine detine zebra
cine_zebra(Z) :- case(C), member(casa(_,Z,zebra,_,_), C).

%cine prefera apa si in ce casa locuieste (numarul si culoare)
info_cine_apa(Nat,Cul,Nr) :- case(C), member(casa(Cul,Nat,_,_,apa), C), index(C,casa(Cul,Nat,_,_,apa),Nr).



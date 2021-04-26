:- op(500, fx, ~).
:- op(700, xfy, user:([^,->,v,<->])).


%din termen obtinem aborele 
arbbinexpr(T,arb(Op,LArb)) :-  T =.. [Op|L], arbexli(L,LArb).

%arbexli(L,LArb) - LArb este lista arborilor termenilor din L

arbexli([],[]).
arbexli([X|Y],[U|V]) :-  arbbinexpr(X,U), arbexli(Y,V).

%pentru apelul invers -> din arbore sa obtinem termenul 
termarbbin(T,arb(Op,LArb)) :- arbexli2(L,LArb), T=..[Op|L].

arbexli2([],[]).
arbexli2([H|T],[A|L]) :- termarbbin(H,A), arbexli2(T,L).

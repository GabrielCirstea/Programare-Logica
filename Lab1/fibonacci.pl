% fib(N,al N-lea numar din sirul lui Fibonacci)

fib(1,0).
fib(2,1).
fib(N,Z) :- N>2, PN is N-1, PPN is N-2, fib(PPN,X), fib(PN,Y), Z is X+Y.

timpfib(N) :- Init is cputime, fib(N,Z), Fin is cputime, write(Z), nl,
              Dif is Fin-Init, write(Dif), write(' secunde').

% listfib(N,sirul lui Fibonacci pana la al N-lea element al sau scris de la coada la cap)

listfib(0,[]).
listfib(1,[0]).
listfib(2,[1,0]).
listfib(N,[Z,Y,X|T]) :- N>2, PN is N-1, listfib(PN,[Y,X|T]), Z is X+Y.

% fibo(N,al N-lea numar din sirul lui Fibonacci)

fibo(N,H) :- listfib(N,[H|_]).

timpfibo(N) :- Init is cputime, fibo(N,Z), Fin is cputime, write(Z), nl,
              Dif is Fin-Init, write(Dif), write(' secunde').

% sirfib(N,sirul lui Fibonacci pana la al N-lea element al sau)

sirfib(N,S) :- listfib(N,L), inversa(L,S).

/* Valorile argumentelor de tip lista sunt intoarse de Prolog trunchiate la primele
10 elemente. Pentru afisarea completa a listelor mai lungi, interogam astfel:
?- listfib(100,Lista), write(Lista).
?- sirfib(100,SirFibonacci), write(SirFibonacci).
Dupa cum am vazut in desenarea bradutului, predicatul unar predefinit write scrie
argumentul sau pe ecran (sau intr-un fisier - vom vedea), apoi intoarce true. */

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

inversa([],[]).
inversa([H|T],L) :- inversa(T,M), concat(M,[H],L).

% fibon(N,al N-lea numar din sirul lui Fibonacci)

fibon(1,0).
fibon(2,1).
fibon(N,Z) :- N>2, auxfib(N,3,0,1,Z).

/* auxfib(N, K, al (K-2)-lea numar din sirul lui Fibonacci,
al (K-1)-lea numar din sirul lui Fibonacci, al N-lea numar din sirul lui Fibonacci) */

auxfib(N,K,X,Y,Z) :- K=N, Z is X+Y; K<N, U is X+Y, SK is K+1, auxfib(N,SK,Y,U,Z).
 
timpfibon(N) :- Init is cputime, fibon(N,Z), Fin is cputime, write(Z), nl,
              Dif is Fin-Init, write(Dif), write(' secunde').

/* Apelati predicatele timpfib, timpfibo si timpfibon pentru N luand valorile:
	1000, 5000, 10000, 50000, 100000, 500000, 1000000.
Observati diferentele dintre timpii de executie.
Pentru valorile 500000 si 1000000, timpii de executie pentru timpfib si timpfibo sunt
de ordinul minutelor, in timp ce pentru timpfibon raman de cateva secunde.
Motivul este faptul ca recursia din definitia lui fib face recalculari masive, iar, 
in fibo, pastrarea intregii liste a numerelor lui Fibonacci, desi e mai avantajoasa
decat calculul direct din fib, consuma, totusi, mult mai mult timp decat recursia cu
pastrarea doar a ultimelor doua elemente din sirul lui Fibonacci ca argumente in fibon.
*/



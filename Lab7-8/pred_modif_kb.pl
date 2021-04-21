/* Predicatele urmatoare adauga clauze (fapte sau reguli) la baza de cunostinte: "asserta" adauga o clauza la inceputul
bazei de cunostinte, iar "assertz" si "assert" o adauga la sfarsitul bazei de cunostinte.
Predicatul "retract" sterge prima aparitie a unei clauze din baza de cunostinte, iar "retractall" sterge toate aparitiile
clauzei din baza de cunostinte.
Ca exemplu, iata un predicat fib(N,F) care calculeaza al N-lea termen din sirul lui Fibonacci si ii depune valoarea in F
(al doilea argument al sau), evitand recalcularile prin folosirea lui asserta - desigur, nu assertz, pentru ca vrem ca
predicatele din dreapta regulii urmatoare sa fie satisfacute prin faptele care vor fi adaugate, nu prin recalculari.
Pentru a permite folosirea lui asserta, predicatul fib trebuie declarat ca dinamic (2 reprezinta aritatea lui fib):
*/

:- dynamic fib/2.

fib(1,0).
fib(2,1).
fib(N,F) :- N>2, PN is N-1, PPN is PN-1, fib(PPN,PPF), fib(PN,PF), F is PPF+PF, asserta(fib(N,F)).

/* Daca vrem sa si stergem clauzele adaugate din baza de cunostinte dupa efectuarea calculului, si, in plus, sa ne asiguram
ca se folosesc clauzele adaugate si nu se intra in recursia cu multe redundante (folosind cut), putem proceda astfel: */

:- dynamic fibo/2.

fibon(1,0).
fibon(2,1).
fibon(N,F) :- fibo(N,F), !.
fibon(N,F) :- N>2, PN is N-1, PPN is PN-1, fibon(PPN,PPF), fibon(PN,PF), F is PPF+PF, asserta(fibo(N,F)).

fibonacci(N,F) :- fibon(N,F), retractall(fibo(N,F)).

% Pentru a testa cum se modifica baza de cunostinte in timpul executiei:

fibonacci_test_kb(N,F) :-  findall(fibo(K1,X1),fibo(K1,X1),L1), write('inainte de executia lui fibon: '), write(L1), nl, fibon(N,F), 
		        findall(fibo(K2,X2),fibo(K2,X2),L2), write('dupa executia lui fibon: '), write(L2), nl, 
		        retractall(fibo(_,_)), findall(fibo(K3,X3),fibo(K3,X3),L3), write('dupa retractall: '), write(L3). 

/* Interogati:
?- fibonacci(11,F).
?- fibonacci_test_kb(11,F).
*/

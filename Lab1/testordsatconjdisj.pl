f(X) :- X>10, write(X), X<0.

f1(X) :- X>10, write(X), tab(1), Y is X-1, f1(Y), X<0.

g(X) :- X>10, X<0, write(X).

g1(X) :- X>10, write(X), X<0, tab(1), Y is X-1, g1(Y).

h(X) :- X<0, write('negativ'); integer(X), X mod 2 =:= 0, write('par'); write('nope').

h1(X) :- X<0, write('negativ'), !; integer(X), X mod 2 =:= 0, write('par'), !; write('nope').

k(X) :- integer(X), X mod 2 =:= 0, write('par'); X<0, write('negativ'); write('nope').

k1(X) :- integer(X), X mod 2 =:= 0, write('par'), !; X<0, write('negativ'), !; write('nope').

/* Interogati, dand ";"/"Next" pentru apelurile lui h, k:
?- f(100).   % e evaluat la false dupa scrierea lui 100 pe ecran
?- g(100).   % e evaluat la false si nu se mai scrie 100 pe ecran
?- f1(100).  % e evaluat la false dupa apelul recursiv
?- g1(100).  % e evaluat la false si nu se mai face apelul recursiv
?- h(-100).
?- k(-100).
?- h(100).
?- k(100).
?- h(99).
?- k(99).
% Dupa satisfacerea disjunctiei, se evalueaza restul acesteia doar daca mai cerem solutii.
?- h1(-100). % are o singura solutie, datorita lui cut
?- k1(-100). % are o singura solutie, datorita lui cut */

% fact(N,F)=true <=> F = N! (N factorial)

fact(N,_) :- (not(integer(N)); N<0), write('nedefinit'), !.
fact(0,1).
fact(N,F) :- N>0, M is N-1, fact(M,G), F is G*N.

/* Daca mutam predicatul N>0 la sfarsitul acestei conjunctii si, la o interogare precum:
?- fact(5,Cat).
dam ";"/"Next" dupa raspunsul Cat=120, atunci trece la evaluarea lui fact(-1,G) si da 
eroare, pentru ca, in calculul "F is G*N", argumentul G nu e instantiat. */

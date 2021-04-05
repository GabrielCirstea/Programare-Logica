/* Predicatul "fail" intotdeauna esueaza, adica e evaluat la false.
Predicatul predefinit cut ("!") are functia de a taia backtrackingul
executat pentru satisfacerea unui scop dintr-o interogare:

membru(_,[]) :- fail. %%% corect si: not(membru(_,[])).
membru(H,[H|_]).
membru(X,[_|T]) :- membru(X,T).

apartine(_,[]) :- fail. %%% corect si: not(apartine(_,[])).
apartine(H,[H|_]) :- !.
apartine(X,[_|T]) :- apartine(X,T).

/* Dati interogarile:
?- membru(a,[X,a,1,Y,a,a,2,3]).
?- apartine(a,[X,a,1,Y,a,a,2,3]).
si cereti toate variantele de satisfacere (cu ";"/"Next"). */

/* Faptele si regulile sunt aplicate in ordinea in care sunt scrise in baza de cunostinte.
De exemplu, implementarea predicatului predefinit "not" sau "\+" este:

not(P) :- P,!,fail.  /* daca P e adevarat, atunci taie backtrackingul si esueaza,
astfel ca renunta si la eventualele unificari pentru care a fost satisfacut P) */
not(_).              % in caz contrar, deci cand P e fals, e satisfacut

Avand in vedere ca un termen X e variabila ddaca X unifica, cu doua constante diferite a si b,
dar, bineinteles, cele doua unificari nu pot avea loc simultan, si nu dorim ca satisfacerea 
urmatorului predicat sa produca unificarea lui X cu a doua constanta, putem folosi predicatul
''not'' pentru a implementa un predicat care functioneaza precum cel predefinit "var": */

variabila(X) :- not(not(X=a)),not(not(X=b)).

:- ['ex1.pl'].
:- ['ex2.pl'].
sortListeNumere(Liste, Sortate) :- quicksort(Liste, Sortate, lex).
sortListeTermeni(Liste, Sortate) :- quicksort(Liste, Sortate, lexterm).

% predicat(a,b) :- sumar(a) =< sumar(b)
%
:- ['ex3.pl'].
comparaArrSum(T1,T2) :- sumar(T1,A), sumar(T2,B), A =< B.
ordoneazaArrSum(Lista, Sortata) :- quicksort(Lista,Sortata, comparaArrSum).

comparaArrMaxime(T1,T2) :- maxar(T1,A), maxar(T2,B), A =< B.
ordoneazaArrMaxime(Lista, Sortata) :- quicksort(Lista,Sortata, comparaArrMaxime).

comparaSubMax(T1,T2) :- maxsubterm(T1,A), maxsubterm(T2,B), A @=< B.
ordoneazaSubMax(Lista, Sortata) :- quicksort(Lista,Sortata, comparaArrMaxime).

% pentru testari
listaTermeni(1, [f(a),f(g,c),r(g(d(s,f),g))]).
listaTermeni(2, [x(g),f(g(fg,tren),c),r(g(d,g))]).
listaTermeni(3, [f(a)]).
listaTermeni(4, [f(v(x)), f(a), g(y)]).
listaTermeni(5, [f(v(x(r,g,f(f)))), f(a), g(y)]).

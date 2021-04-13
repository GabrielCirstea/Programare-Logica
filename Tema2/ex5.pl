:- ['ex1.pl'].

% ordoneaza "argumentele" unui termen Prolog
% aplica ordonarea recursiv pentru fiecare argument
reordterm(Termen,Termen) :- functor(Termen,_,0).
reordterm(Termen,U) :- Termen=..[H|T], parcurgeLista(T,Lista),
					quicksort(Lista,Ord,@=<), U=..[H|Ord].

% aplica ordonarea de mai sus pentru fiecare termen dintr-o lista
% de termeni
parcurgeLista([H|[]], [U]) :- reordterm(H,U).
parcurgeLista([H|T], [U|L]) :- reordterm(H,U), parcurgeLista(T,L).

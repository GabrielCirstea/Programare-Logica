:- op(500, fx, ~).
:- op(700, xfy, user:([^,->,v,<->, are,+])).

%disjunctia 
% p v q = p->(q->p)
%conjunctia
% p ^ q = ~(p->~q)
%echivalenta
% p <-> q = (p->q) ^ (q->p) = ~((p->q)->~(q->p))

 conectprim(V,V) :- atom(V), !.
 conectprim(~X, ~Z):- conectprim(X,Z).
 conectprim(X v Y,~ Z -> W) :- conectprim(X,Z), conectprim(Y,W).
 conectprim(X^Y,~(Z -> (~W))) :- conectprim(X,Z), conectprim(Y,W).
 conectprim(X->Y,Z->T) :- conectprim(X,Z), conectprim(Y,T).
 conectprim(X<->Y,~((Z -> T) -> (~(T -> Z)))) :- conectprim(X,Z), 
 												conectprim(Y,T).

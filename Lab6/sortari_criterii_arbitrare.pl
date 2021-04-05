/* Predicatul binar infixat predefinit "=..":
Termen=..[OperatorDominantTermen|ListaArgumenteOperatorDominantTermen].
Nu functioneaza sub forma: Variabila=..TotVariabila. Interogati:
?- Termen=..Lista.
?- Termen=..[H|T].
?- Termen=..[Singleton].
?- Termen=..[fct,X,a,g(V,10),20,b].
?- fct(X,a,g(V,10),20,b)=..Lista.
?- fct(X,a,g(V,10),20,b)=..[Op|Listarg].
?- fct(X,a,g(V,10),20,b)=..[Op,arg1,Arg2,Arg3,Arg4,V].
?- fct(X,a,g(V,10),20,b)=..[Op,Arg1,Arg2,Arg3,X,V].
?- fct(X,a,g(V,10),20,b)=..[Op,arg1,Arg2,Arg3,X,V].
?- constanta=..Lista.
?- Termen=..[constanta].
?- Termen=..[<,X,Y].
?- Termen=..[>=,100,10], Termen.
?- Termen=..[>=,100,1000], Termen.
*/

/* Alta implementare pentru predicatele ect, eordcresc, eordstrictcresc, eorddescresc,
eordstrictdescresc din fisierul sortari.pl, folosind un predicat eordarb(Lista,Ord),
care testeaza daca Lista e sortata dupa criteriul Ord: */

eordarb([],_).
eordarb([_],_).
eordarb([H,K|T],Ord) :- Termen=..[Ord,H,K], Termen, eordarb([K|T],Ord).

ect(Lista) :- eordarb(Lista,=).

eordcresc(Lista) :- eordarb(Lista,=<).

eordstrictcresc(Lista) :- eordarb(Lista,<).

eorddescresc(Lista) :- eordarb(Lista,>=).

eordstrictdescresc(Lista) :- eordarb(Lista,>).

% Sortarea dupa un criteriu arbitrar Ord prin insertie directa:

insertsort([],[],_).
insertsort([H|T],L,Ord) :- insertsort(T,M,Ord), insert(H,M,L,Ord).

insert(X,[],[X],_).
insert(X,[H|T],[H|T],Ord) :- X==H, Termen=..[Ord,H,H], not(Termen), !. %%% caz neinserare
insert(X,[H|T],[X,H|T],Ord) :- Termen=..[Ord,X,H], Termen, !.
insert(X,[H|T],[H|L],Ord) :- insert(X,T,L,Ord).

/* Cazul de neinserare: daca Ord e o relatie de ordine stricta, atunci termenul Ord(H,H)
(in notatie infixata, H Ord H) nu e satisfacut; in acest caz, elementul X nu va fi inserat
in lista daca e literal identic cu un element aflat deja in lista, asadar sortarea se va
efectua cu eliminarea duplicatelor.
Daca Ord e o relatie de ordine nestricta, atunci termenul Ord(H,H) este satisfacut, prin
urmare not(Ord(H,H)) e fals, asadar nu se va intalni cazul de neinserare, adica nu se va
aplica acea a doua regula din definitia lui insert, deci sortarea se va efectua fara 
	eliminarea duplicatelor.
Dati interogarile:
?- insertsort([7,1,0,5E2,-2,7,5e2,3.5,0,7],ListaSortata,>=), write(ListaSortata).
?- insertsort([7,1,0,5E2,-2,7,5e2,3.5,0,7],ListaSortata,>), write(ListaSortata).
Ordinile predefinite pe termeni Prolog arbitrari: @=<, @<, @>=, @>; acestea includ
relatiile de ordine de pe constantele numerice =<, <, >=, respectiv >.
Dati urmatoarele interogari si observati definitia recursiva a relatiilor de ordine @=<,
@<, @>=, @> pe termenii compusi: mai intai dupa aritatea operatorului dominant, apoi
lexicografic dupa numele acestui operator, apoi recursiv dupa argumentele acestui
operator, de la stanga la dreapta; observati si faptul ca, spre deosebire de constante si
operatori cu argumente, care sunt ordonati lexicografic, numele variabilelor nu conteaza:
Dati interogarile:
?- insertsort([h(ct,f(ct)),h(ct,V),fct(X),h(X,f(ct)),V,h(a,1),h(X,f(X)),g(1),Var,h(X,Y),g(ct),1,g(A),'ct',Z,'sir',f(X),binar(a,1),ct,Var,'--@-charspec-->',f(V),'ct',2.5,a,V,-1,Y,A,c,1,X,b,a],ListaSortata,@=<), write(ListaSortata).
?- insertsort([h(ct,f(ct)),h(ct,V),fct(X),h(X,f(ct)),V,h(a,1),h(X,f(X)),g(1),Var,h(X,Y),g(ct),1,g(A),'ct',Z,'sir',f(X),binar(a,1),ct,Var,'--@-charspec-->',f(V),'ct',2.5,a,V,-1,Y,A,c,1,X,b,a],ListaSortata,@<), write(ListaSortata).
*/

/* Predicat predefinit pentru sortare dupa ordinea @=<: sort(ListadeSortat,ListaSortata).
Predicat predefinit pentru sortare dupa un criteriu arbitrar Ord:
sort(TipuldeTermenidinListadeSortat,Ord,ListadeSortat,ListaSortata). Primul argument al
acestui predicat: 0 indica tipul termen Prolog, 1 indica tipul pereche de termeni Prolog etc..
Sortarile realizate de predicatul binar predefinit sort si cele realizate cu predicatul sort
predefinit de aritate 4 dupa ordini nestricte sunt stabile, adica variabilele si termenii
literal identici apar in lista sortata in ordinea in care se aflau in lista de sortat. */

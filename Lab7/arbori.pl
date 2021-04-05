/* Dam arborii binari sub forma acestor termeni construiti recursiv:
nil: arborele binar vid;
arb(Radacina, SubarboreStang, SubarboreDrept): arbore binar nevid.
   Dam arborii oarecare sub forma acestor termeni construiti recursiv:
null: arborele oarecare vid; nu e folosit in aceasta recursie, ci e un caz separat;
arb(Radacina, ListaSubarbori): arbore oarecare nevid.
   Prologul nu va confunda cele doua tipuri de arbori, pentru ca arborii binari sunt
construiti cu operatorul ternar arb, iar arborii oarecare cu operatorul binar arb. */

% Sa memoram in baza de cunostinte cativa arbori binari, sub forma arbbin(Nr,Arbore):

arbbin(1, arb(1, arb(2, arb(4, nil, nil), nil), arb(3, nil, nil))).
arbbin(2, arb(1, arb(2, arb(4, nil, nil), arb(5, nil, nil)), arb(3, nil, arb(6, nil, nil)))).
arbbin(3, arb(1, arb(2, arb(4, nil, nil), arb(5, arb(7, nil, nil), nil)), arb(3, nil, arb(6, nil, nil)))).

% si arbori oarecare, sub forma arbore(Nr,Arbore), pentru a scrie mai comod interogarile:

arbore(1, arb(1, [arb(2, []), arb(3, []), arb(4, [])])).
arbore(2, arb(1, [arb(2, []), arb(3, [arb(5, [])]), arb(4, [])])).
arbore(3, arb(1, [arb(2, [arb(7, [arb(10, [])]), arb(8, []), arb(9, [])]), arb(3, [arb(5, []), arb(6, [])]), arb(4, [])])).

/* Parcurgerile in preodine, inordine, postordine ale arborilor binari:
preord(Arbore,ListaNoduri), inord(Arbore,ListaNoduri), postord(Arbore,ListaNoduri).
Interogati:
?- arbbin(1,Arbore), preord(Arbore,ListaNoduriParcurseinPreordine).
?- arbbin(2,Arbore), inord(Arbore,ListaNoduriParcurseinInordine).
?- arbbin(3,Arbore), postord(Arbore,ListaNoduriParcurseinPostordine).
*/

preord(nil,[]).
preord(arb(Rad,Stg,Dr),ListaNoduri) :- preord(Stg,ListStg), preord(Dr,ListDr),
				       append([Rad|ListStg],ListDr,ListaNoduri).

inord(nil,[]).
inord(arb(Rad,Stg,Dr),ListaNoduri) :- inord(Stg,ListStg), inord(Dr,ListDr),
				      append(ListStg,[Rad|ListDr],ListaNoduri).

postord(nil,[]).
postord(arb(Rad,Stg,Dr),ListaNoduri) :- postord(Stg,ListStg), postord(Dr,ListDr),
	append(ListStg,ListDr,ListaNoduriSubarbori), append(ListaNoduriSubarbori,[Rad],ListaNoduri).

/* Lista frunzelor unui arbore binar: lf(Arbore,ListaFrunze).
   Inaltimea unui arbore binar: h(Arbore,Inaltime).
Interogati, ca mai sus:
?- arbbin(N,Arbore), lf(Arbore,ListaFrunze).
?- arbbin(N,Arbore), h(Arbore,Inaltime).
*/

lf(nil,[]).
lf(arb(Rad,nil,nil),[Rad]) :- !. % se trece la urmatoarea regula numai pentru noduri neterminale
lf(arb(_,Stg,Dr),ListaFrunze) :- lf(Stg,ListaFrunzeStg), lf(Dr,ListaFrunzeDr),
				 append(ListaFrunzeStg,ListaFrunzeDr,ListaFrunze).

% Maximul dintre doua numere; pentru maximul intre doi termeni, inlocuiti ">=" cu "@>=":

max(X,Y,X) :- X>=Y, !.
max(_,Y,Y).

/* Maximul dintr-o lista de numere; pentru maximul dintr-o lista de termeni,
folositi predicatul auxiliar max modificat ca mai sus: */

h(nil,0).
h(arb(_,Stg,Dr),Inalt) :- h(Stg,InaltStg), h(Dr,InaltDr),
			  max(InaltStg,InaltDr,InaltMaxSubarb), Inalt is InaltMaxSubarb+1.

/* Desenarea unui arbore binar crescand din stanga ecranului: interogati:
?- arbbin(N,Arbore), desenarbbin(Arbore).
*/

desenarbbin(ArboreBinar) :- desen(ArboreBinar,0).

desen(nil,_).
desen(arb(Rad,Stg,Dr),Deplasament) :- MailaDreapta is Deplasament+5, desen(Dr,MailaDreapta), nl,
				      tab(Deplasament), write(Rad), nl, desen(Stg,MailaDreapta).

/* Parcurgerea in adancime a unui arbore oarecare: interogati:
?- arbore(N,Arbore), df(Arbore,ListaNoduriParcurseinAdancime), write(ListaNoduriParcurseinAdancime).
*/

df(null,[]).
df(arb(Rad,[]),[Rad]).
df(arb(Rad,[Arb|ListArb]),[Rad|ListaNoduri]) :- dflist([Arb|ListArb],ListaNoduri).

dflist([],[]).
dflist([Arb|ListArb],ListaNoduri) :- df(Arb,ListaNoduriArb), dflist(ListArb,ListaNoduriListArb),
				     append(ListaNoduriArb,ListaNoduriListArb,ListaNoduri).

/* Lista frunzelor si inaltimea unui arbore oarecare: interogati:
?- arbore(N,Arbore), lf(Arbore,ListaFrunze), h(Arbore,Inaltime).
*/

lf(null,[]).
lf(arb(Rad,[]),[Rad]).
lf(arb(_,[Arb|ListArb]),ListaFrunze) :- lflist([Arb|ListArb],ListaFrunze).

lflist([],[]).
lflist([Arb|ListArb],ListaFrunze) :- lf(Arb,ListaFrunzeArb), lflist(ListArb,ListaFrunzeListArb),
				     append(ListaFrunzeArb,ListaFrunzeListArb,ListaFrunze).

maxlist([X],X).
maxlist([X,Y|T],M) :- maxlist([Y|T],N), max(X,N,M).

h(null,0).
h(arb(_,[]),1).
h(arb(_,[Arb|ListArb]),Inaltime) :- hlist([Arb|ListArb],ListaInaltimi),
				    maxlist(ListaInaltimi,InaltMaxSubarb), Inaltime is InaltMaxSubarb+1.

hlist([],[]).
hlist([Arb|ListArb],[Inaltime|ListaInaltimi]) :- h(Arb,Inaltime), hlist(ListArb,ListaInaltimi).

/* Parcurgerea in latime, i. e. pe niveluri, a unui arbore oarecare: interogati:
?- arbore(N,Arbore), bf(Arbore,ListaNoduriPeNiveluri), write(ListaNoduriPeNiveluri).
*/

bf(null,[]).
bf(arb(Rad,ListSubarb),[Rad|ListaNoduri]) :- bflist(ListSubarb,ListaNoduri).

bflist([],[]).
bflist([arb(Rad,ListSubarb)|ListArb],[Rad|ListaNoduri]) :- append(ListArb,ListSubarb,ListaArbori),
							   bflist(ListaArbori,ListaNoduri).

/* Arborele de expresie asociat unui termen: interogati:
?- arbexpr(Variabila,Arbore).
?- arbexpr(constanta,Arbore).
?- arbexpr(fct(V,g(a,b),h(7)),Arbore).
?- arbexpr(f(h(h(V)),g(a,h(b)),V,h(7),g(10,20)),Arbore), write(Arbore).
?- arbexpr(f(h(h(V)),g(a,h(b)),V,h(7),g(10,20)),Arbore), write('arborele: '), write(Arbore), nl, df(Arbore,Ldf), write('parcurgerea depth first: '), write(Ldf), nl, bf(Arbore,Lbf), write('parcurgerea breadth first: '), write(Lbf), nl, lf(Arbore,LF), write('lista frunzelor (variabile si constante): '), write(LF), nl, h(Arbore,H), write('inaltimea arborelui: '), write(H), nl.
*/

arbexpr(Termen,arb(Termen,[])) :- var(Termen), !. % Termen e variabila, deci nu putem apela Termen=..Lista
arbexpr(Termen,arb(Operator,[])) :- Termen=..[Operator], !. % Termen e constanta
arbexpr(Termen,arb(Operator,ListaArbori)) :- Termen=..[Operator|ListaArgumente],
					     listarbexpr(ListaArgumente,ListaArbori).
% Termen e termen compus cand se aplica ultima regula de mai sus 

listarbexpr([],[]).
listarbexpr([Termen|ListaTermeni],[Arb|ListArb]) :- arbexpr(Termen,Arb),
						    listarbexpr(ListaTermeni,ListArb).







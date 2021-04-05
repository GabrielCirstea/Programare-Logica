concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

/* Urmatoarele predicate testeaza apartenenta unui element la o lista.
membru(X,L) e satisfacut de atatea ori de cate ori apare X in lista L,
ceea ce se poate verifica dand ";"/"Next" la o interogarile:
?- membru(ct,[1,a,ct,10,b,ct,a,1,ct]).
?- membru(CareSuntMembrii,[1,a,ct,10,b,ct,a,1,ct]).
apartine(X,L) si apare(X,L) sunt satisfacute doar pentru prima aparitie a lui X in L. */

membru(_,[]) :- fail.   % varianta: not(membru(_,[])). Sau se poate renunta la aceasta regula.
membru(H,[H|_]).
membru(X,[_|T]) :- membru(X,T).

apartine(_,[]) :- fail.   % Putem renunta la aceasta regula sau o putem scrie ca fapt, cu "not".
apartine(H,[H|_]) :- !.   % odata gasit H in capul listei, cautarea se incheie 
apartine(X,[_|T]) :- apartine(X,T).

apare(_,[]) :- fail.   % Ca mai sus.
apare(H,[H|_]).
apare(X,[H|T]) :- X\=H, apare(X,T).   % cautam pe X in T doar daca X\=H

/* Pentru a observa de ce, spre deosebire de "apartine","apare" mai cauta solutii
dupa prima (si unica) satisfacere, putem modifica astfel aceste predicate: */

apartineafis(X,[]) :- write(X), write(' nu e in lista').
apartineafis(H,[H|T]) :- write(H), write(' apare in '), write([H|T]), !.
apartineafis(X,[H|T]) :- write(X), write(' e diferit de '), write(H), nl, apartineafis(X,T).

apareafis(X,[]) :- write(X), write('nu e in lista').
apareafis(H,[H|T]) :- write(H), write(' apare in '), write([H|T]).
apareafis(X,[H|T]) :- write(X), write(' ar trebui sa fie diferit de '), write(H), nl,
                      X\=H, apareafis(X,T).

/* Urmatoarele predicate sterg un element dintr-o lista:
stergeprima(X,L,M) si stergeprimul(X,L,M) sunt satisfacute ddaca X apare in L
	si M se obtine din L prin stergerea lui X de pe prima sa pozitie in L;
stergeultima(X,L,M) si stergeultimul(X,L,M) sunt satisfacute ddaca X apare in L
	si M se obtine din L prin stergerea lui X de pe ultima sa pozitie in L;
stergetot(X,L,M) si stergetotul(X,L,M) sunt satisfacute ddaca M se obtine din L
	prin stergerea lui X de pe toate pozitiile sale in L, indiferent daca sunt
	mai multe, una sau niciuna;
sterge(X,L,M) e satisfacut ddaca M se obtine din L prin stergerea lui X de pe oricare
	dintre pozitiile sale in L, exact o data, adica ddaca X apare in L si M se
	obtine din L prin stergerea lui X de pe exact una dintre pozitiile sale in L;
stergesaunu(X,L,M) e satisfacut ddaca M se obtine din L prin stergerea lui X de pe
	cel mult una dintre pozitiile sale in L. */

stergeprima(H,[H|T],T).
stergeprima(X,[H|T],[H|L]) :- X\=H, stergeprima(X,T,L).

stergeprimul(H,[H|T],T) :- !.
stergeprimul(X,[H|T],[H|L]) :- stergeprimul(X,T,L).

stergeultima(X,[H|T],[H|L]) :- apartine(X,T), stergeultima(X,T,L).
stergeultima(H,[H|T],T) :- not(apartine(H,T)).

stergeultimul(X,[H|T],[H|L]) :- apartine(X,T), stergeultimul(X,T,L), !.
stergeultimul(H,[H|T],T).

stergetot(_,[],[]).
stergetot(H,[H|T],L) :- stergetot(H,T,L).
stergetot(X,[H|T],[H|L]) :- X\=H, stergetot(X,T,L).

stergetotul(_,[],[]).
stergetotul(H,[H|T],L) :- stergetotul(H,T,L), !.
stergetotul(X,[H|T],[H|L]) :- stergetotul(X,T,L).

sterge(H,[H|T],T).   % acest fapt spune si ca adaugand H la T obtinem [H|T]; interogati:
		     % ?- sterge(ct,DinCeLista,[a,10,b,1,10]). si dati ";"/"Next"
sterge(X,[H|T],[H|L]) :- sterge(X,T,L).

stergesaunu(_,[],[]).   % pot sa nu sterg/adaug nimic
stergesaunu(H,[H|T],T).   % ca mai sus, stergere daca am variabila pe al 3-lea argument
                          % si adaugare daca am variabila pe al 2-lea argument
stergesaunu(X,[H|T],[H|L]) :- stergesaunu(X,T,L).

/* Urmatorul predicat elimina duplicatele dintr-o lista, transformand-o in multime,
pastrand prima aparitie a fiecarui element al listei: */

elimdup([],[]).
elimdup([H|T],[H|L]) :- stergetot(H,T,M), elimdup(M,L).

/* Urmatorul predicat elimina duplicatele dintr-o lista, transformand-o in multime,
pastrand ultima aparitie a fiecarui element al listei: */

elimdupsf([],[]).
elimdupsf([H|T],[H|L]) :- not(apartine(H,T)), elimdupsf(T,L), !.
elimdupsf([_|T],L) :- elimdupsf(T,L).

% Intersectia de multimi:

intersectie(L,M,I) :- elimdup(L,Mult), elimdup(M,Multime), inters(Mult,Multime,I).

inters([],_,[]).
inters([H|T],M,[H|L]) :- apartine(H,M), inters(T,M,L). % varianta: ! (cut) si:
inters([H|T],M,L) :- not(apartine(H,M)), inters(T,M,L). % aici fara testare de apartenenta

% Reuniunea de multimi:

reuniune(L,M,R) :- concat(L,M,C), elimdup(C,R).

% Diferenta intre multimi: L\M:

diferenta(L,M,D) :- elimdup(L,Mult), elimdup(M,Multime), dif(Mult,Multime,D).

dif([],_,[]).
dif([H|T],M,[H|L]) :- apartine(H,M), dif(T,M,L). % varianta: ! (cut) si:
dif([H|T],M,L) :- not(apartine(H,M)), dif(T,M,L). % aici fara testare de apartenenta

% Produsul cartezian intre multimi, cu, recursie in predicatul auxiliar prod:

prodcart(L,M,P) :- elimdup(L,Mult), elimdup(M,Multime), prod(Mult,Multime,P).

% Produsul cartezian intre liste, recursiv:

prod([],_,[]).
prod([H|T],M,P) :- prodsgl(H,M,L), prod(T,M,Q), concat(L,Q,P).

prodsgl(_,[],[]).
prodsgl(X,[H|T],[(X,H)|L]) :- prodsgl(X,T,L).

/* setof, bagof, findall: predicate ternare predefinite:
setof(Termen,Conditie,Multime)=true <=> Multime este multimea (i.e. lista fara duplicate a)
	valorilor lui Termen care satisfac Conditie;
bagof(Termen,Conditie,Lista)=true <=> findall(Termen,Conditie,Lista)=true <=> Lista este
	lista valorilor lui Termen care satisfac Conditie, cu fiecare valoare aparand in
	Lista de atatea ori de cate ori Termen satisface Conditie.
Orice predicat care se poate defini in Prolog (chiar si cele care folosesc calcule aritmetice,
dar nu cele care produc afisari pe ecran sau scrieri in fisiere) se poate implementa folosind
doar recursie si unificari, fara predicate de genul lui setof/bagof/findall, asa ca vom vedea si
astfel de implementari mai jos, chiar daca unele predicate se scriu foarte comod folosind
aceste predicate predefinite. */

% Produsul cartezian intre multimi, folosind membru si setof:

prodmult(L,M,P) :- setof((X,Y), (membru(X,L),membru(Y,M)), P).

% Produsul cartezian intre liste, folosind membru si bagof:

prodlist(L,M,P) :- bagof((X,Y), (membru(X,L),membru(Y,M)), P).

/* Subliste cu elementele in ordine, dar nu neaparat pe
pozitii consecutive in lista mare:*/

% testeaza corect sublistele, dar genereaza doar prefixele:

sl([],_).
sl([_|_],[]) :- fail.
sl([H|T],[H|L]) :- sl(T,L).
sl([H|T],[X|L]) :- H\=X, sl([H|T],L).

/* testeaza corect sublistele, dar le genereaza cu duplicate, intrucat
cauta [] in toate sufixele listei initiale si, pentru fiecare sufix,
genereaza o aceeasi sublista cu coada []: */

subl([],_).
subl([_|_],[]) :- fail.
subl([H|T],[H|L]) :- subl(T,L).
subl(T,[_|L]) :- subl(T,L).

% testeaza corect sublistele, si le genereaza pe toate, fara duplicate:

sublista([],_).
sublista([_|_],[]) :- fail.
sublista([H|T],[H|L]) :- sublista(T,L).
sublista([H|T],[_|L]) :- sublista([H|T],L).

/* Subliste cu elementele in ordine si pe pozitii
consecutive in lista mare, generate corect:*/

prefix([],_).
prefix([_|_],[]) :- fail.
prefix([H|T],[H|L]) :- prefix(T,L).

slconsec([],_).
slconsec([_|_],[]) :- fail.
slconsec([H|T],[X|L]) :- prefix([H|T],[X|L]) ; slconsec([H|T],L).

% sau:

sufix(L,L).
sufix(S,[_|L]) :- sufix(S,L).

sublistconsec(S,L) :- prefix(P,L), sufix(S,P).

/* daca, in loc de [H|T], scriem T mai sus,
atunci sublistele sunt generate cu duplicate */

/* Subliste cu elementele in ordine si pe pozitii consecutive in
lista mare: raspunde true corect, dar nu raspunde false (depaseste
stiva de lucru), si genereaza aceste subliste corect, dar, daca
mai cerem subliste la final, atunci depaseste stiva de lucru: */

slcs([],_).
slcs([H|T],L) :- concat(_,[H|T],M),concat(M,_,L).

slcsc(S,L) :- concat(_,S,M),concat(M,_,L).

/* daca scriam aici T in loc de [H|T] mai sus,
atunci genera aceste subliste cu duplicate */

/* o varianta similara pentru generarea prefixelor,
sufixelor, respectiv acestor bucati dintr-o lista: */

pfx(P,L) :- concat(P,_,L).

sfx(S,L) :- concat(_,S,L).

sublistcs(S,L) :- prefix(P,L), sufix(S,P).

/* subliste(L,LS)=true <=> LS e lista sublistelor lui L cu elementele
in ordine, dar nu neaparat pe pozitii consecutive in lista LS */

subliste(L,LS) :- setof(S, sublista(S,L), LS).

/* submult(S,L)=true <=> S e submultime a multimii
care se obtine din L prin eliminarea duplicatelor */

submult(S,L) :- elimdup(L,M), subliste(S,M).

/* partimult(M,P)=true <=> pmult(M,P)=true <=> P e multimea submultimilor
multimii care se obtine din M prin eliminarea duplicatelor */

partimult(M,P) :- setof(S, submult(S,M), P).

pmult(L,P) :- elimdup(L,M), subliste(M,P). 

/* parti(M,P)=true <=> P e lista/multimea sublistelor/submultimilor listei/multimii M,
dupa cum M are sau nu duplicate, unde elementele apar in subliste in ordinea in care
apar in M, dar, desigur, nu se afla neaparat pe pozitii consecutive in M.
   Generarea sublistelor fara duplicate:
partilista(L,P)=true <=> P e multimea sublistelor listei L, unde elementele apar in
subliste in ordinea in care apar in L, dar nu se afla neaparat pe pozitii consecutive in L:
*/

parti([],[[]]).
parti([H|T],P) :- parti(T,Q), adaug_elem(H,Q,L), concat(Q,L,P).

adaug_elem(_,[],[]).
adaug_elem(H,[L|LL],[[H|L]|M]) :- adaug_elem(H,LL,M).

partilista([],[[]]).
partilista([H|T],P) :- partilista(T,Q), adaug_elem(H,Q,L), reuniune(Q,L,P).

/* permcirc(L,P)=true <=> P e o permutare circulara a listei L
                          cu o singura pozitie spre stanga: */ 

permcirc([],[]).
permcirc([H|T],L) :- concat(T,[H],L).

auxpermcirc(L,L,[L]).
auxpermcirc(L,M,[M|LP]) :- L\=M, permcirc(M,N), auxpermcirc(L,N,LP).

% permutaricirc(L,LP)=true <=> LP e lista permutarilor circulare ale listei L:

permutaricirc(L,LP) :- permcirc(L,M), auxpermcirc(L,M,LP).

% permutare(L,P)=true <=> P e permutare a listei L:

permutare([],[]).
permutare([H|T],P) :- permutare(T,Q), sterge(H,P,Q).

% permutari(L,LP)=true <=> LP e lista permutarilor listei L:

permutari(L,LP) :- setof(P,permutare(L,P),LP).

% permutaresl(L,P)=true <=> P e permutare a unei subliste a listei L

permutaresl([],[]).
permutaresl([H|T],P) :- permutaresl(T,Q), stergesaunu(H,P,Q).

% permutarisl(L,LP)=true <=> LP e lista permutarilor sublistelor listei L:

permutarisl(L,LP) :- setof(P,permutaresl(L,P),LP).

% Generarea permutarilor fara setof:

permut(L,ListaPermutariL) :- auxperm(L,_,ListaPermutariL).

auxperm([],0,[[]]).
auxperm([H|T],N,LP) :- auxperm(T,LungimeT,LPT), N is LungimeT+1,
		       adaug_fiec_poz(H,0,N,LPT,LP).

adaug_fiec_poz(_,PozMax,PozMax,_,[]).
adaug_fiec_poz(X,Poz,PozMax,ListaListe,NouaListaListe) :- Poz<PozMax,
	adaug_pe_poz(X,Poz,ListaListe,LL),
	UrmPoz is Poz+1, adaug_fiec_poz(X,UrmPoz,PozMax,ListaListe,ListL),
	reuniune(LL,ListL,NouaListaListe).

adaug_pe_poz(_,_,[],[]).
adaug_pe_poz(X,Poz,[H|T],[K|U]) :- adaug(X,Poz,H,K), adaug_pe_poz(X,Poz,T,U).

adaug(X,0,L,[X|L]).
adaug(X,Poz,[H|T],[H|U]) :- Poz>0, P is Poz-1, adaug(X,P,T,U).

% Generarea permutarilor sublistelor fara setof:

permutsl(L,ListaPermutariL) :- auxpermsl(L,_,ListaPermutariL).

auxpermsl([],0,[[]]).
auxpermsl([H|T],N,LP) :- auxpermsl(T,LungimeT,LPT), N is LungimeT+1,
		       adaug_sau_nu_fiec_poz(H,0,N,LPT,LP).

adaug_sau_nu_fiec_poz(_,PozMax,PozMax,ListaListe,ListaListe). %% pastrez si listele fara noul element
adaug_sau_nu_fiec_poz(X,Poz,PozMax,ListaListe,NouaListaListe) :- Poz<PozMax,
	adaug_sau_nu_pe_poz(X,Poz,ListaListe,LL),
	UrmPoz is Poz+1, adaug_sau_nu_fiec_poz(X,UrmPoz,PozMax,ListaListe,ListL),
	reuniune(LL,ListL,NouaListaListe).

adaug_sau_nu_pe_poz(_,_,[],[]).
adaug_sau_nu_pe_poz(X,Poz,[H|T],[K|U]) :- adaug_sau_nu(X,Poz,H,K), adaug_sau_nu_pe_poz(X,Poz,T,U).

adaug_sau_nu(X,0,L,[X|L]).
adaug_sau_nu(X,Poz,[H|T],[H|U]) :- Poz>0, P is Poz-1, adaug_sau_nu(X,P,T,U).
adaug_sau_nu(_,Poz,[],[]) :- Poz>0. %% las lista neschimbata daca are lungimea mai mica
                                    %% decat pozitia pe care se adauga noul element



/* Pentru ca a scrie, de exemplu, are(ana,mere) este contraintuitiv, sa declaram 
predicatul binar "are" ca operator infixat, de precedenta 600; folosim directiva
de mai jos. Precedentele sunt opusul prioritatilor: cu cat precedenta e mai mica, 
cu atat prioritatea e mai mare, asadar operatorul e mai prioritar, leaga mai tare; 
de exemplu, atomii si termenii incadrati intre paranteze au precedenta implicita 0. */

:- op(600,xfx,are).

ana are mere.
ana are pere.
maria are cirese.
maria are pere.
victor are X :- ana are X ; maria are X.

/* Dati interogarea:
?- findall((Cine are Ce),Cine are Ce,L).
*/

% Putem declara astfel si mai multi operatori, incluzandu-i intr-o lista:

:- op(150,xfx,[implica,echivalent]).

Enunt implica _ :- not(Enunt), !.
_ implica Enunt :- Enunt.

Enunt echivalent AltEnunt :- Enunt implica AltEnunt, AltEnunt implica Enunt.

/* Interogati:
?- (10>2) implica (5>3).
?- (10>2) implica (3>5).
?- (2>10) implica (5>3).
?- (2>10) echivalent (5>3).
?- (2>10) echivalent (3>5).
*/

/* O declaratie cu operanzii reprezentati prin "x" semnifica faptul ca operatorul 
admite operanzi de precedenta strict mai mica decat 600, asadar de prioritate 
strict mai mare decat prioritatea operatorului.
Pentru a specifica faptul ca un operand poate avea precedenta mai mica sau egala 
cu a operatorului declarat, asadar prioritatea mai mare sau egala decat a acestui
operator, reprezentam operandul prin "y" intr-o astfel de declaratie: */

:- op(600,yfx,este). % operator asociativ la dreapta
:- op(600,xfy,[in,produce]). % operator asociativ la stanga

X in [X|_].
X in [_|T] :- X in T.

X in L in LL :- L in LL, X in L.

/* "in" este varianta infixata a predicatului "membru".
Urmatoarele interogari sunt analoge una alteia (dati ";"/"Next" la fiecare):
?- X in [1,2,3,4,5].
?- in(X,[1,2,3,4,5]).
Interogati:
?- findall(X,X in L in [[1,2,3],[a,b],[V,W]],ListaMembriMembriListadeListe).
*/

maria este adult este responsabil :- write('parantezarea implicita este:'), nl, fail.
(maria este adult) este responsabil :- write('(maria este adult) este responsabil'), nl.
maria este (adult este responsabil) :- write('maria este (adult este responsabil)').

ana produce sapun produce spuma :- write('parantezarea implicita este:'), nl, fail.
(ana produce sapun) produce spuma :- write('(ana produce sapun) produce spuma'), nl.
ana produce (sapun produce spuma) :- write('ana produce (sapun produce spuma)'), nl.

victor produce utilaje este inginer :- write('parantezarea implicita este:'), nl, fail.
(victor produce utilaje) este inginer :- write('(victor produce utilaje) este inginer').
victor produce (utilaje este inginer) :- write('victor produce (utilaje este inginer)').

ana produce deodorant este chimist este cosmetician :- write('parantezarea implicita este:'), nl, fail.
((ana produce deodorant) este chimist) este cosmetician :- write('((ana produce deodorant) este chimist) este cosmetician'), nl.

/* Interogati:
?- Cine este Ce este Cum. % si dati ";"/"Next"
?- Cine produce Ce produce CeAnume.
?- Cine produce CeAnume este Ce.
?- Cine produce CeAnume este Ce este SiMaiCe.
Sintaxa yfy este nepermisa, pentru ca Prologul nu ar sti sa parantezeze termeni
de forma "x operator y operator z" cu un astfel de operator.
De asemenea, termenul "victor este inginer produce utilaje" este nepermisa, 
intrucat operatorul "produce" nu admite operandul "victor este inginer", cu 
precedenta 600 (egala, desigur, cu precedenta operatorului sau dominant, "este"),
egala cu precedenta lui "produce", deci nu avem parantezarea implicita:
"(victor este inginer) produce utilaje", dar nu avem nici parantezarea implicita:
"victor este (inginer produce utilaje)", pentru ca, analog, inlaturand aceasta
paranteza, am avea termenul neparantezat "inginer produce utilaje", de precedenta
600 (precedenta operatorului sau dominant, "produce") la dreapta operatorului
"este", care nu admite la dreapta operanzi de precedenta egala cu a sa, 600. */

:- op(700,xfy,asocstg).
:- op(700,yfx,asocdr).

s1 asocstg s2 asocstg s3.

d1 asocdr d2 asocdr d3.

t1 asocdr t2 asocstg t3.

/* Interogati:
?- findall(TermenAsocStg, (Operator in [asocstg,asocdr], Termen=..[Operator,Operand1,Operand2], TermenAsocStg=..[Operator,Termen,Operand], TermenAsocStg), ListaAsocStg), write(ListaAsocStg).
?- findall(TermenAsocDr, (Operator in [asocstg,asocdr], Termen=..[Operator,Operand1,Operand2], TermenAsocDr=..[Operator,Operand,Termen], TermenAsocDr), ListaAsocDr), write(ListaAsocDr).
?- findall(TermenAsocStg, (Operator1 in [asocstg,asocdr], Operator2 in [asocstg,asocdr], Termen=..[Operator1,Operand1,Operand2], TermenAsocStg=..[Operator2,Termen,Operand], TermenAsocStg), ListaAsocStg), write(ListaAsocStg).
?- findall(TermenAsocDr, (Operator1 in [asocstg,asocdr], Operator2 in [asocstg,asocdr], Termen=..[Operator1,Operand1,Operand2], TermenAsocDr=..[Operator2,Operand,Termen], TermenAsocDr), ListaAsocDr), write(ListaAsocDr).
*/

% Operatori prefixati si postfixati:

:- op(200,xf,[e_multime,ordonata,listord]).
:- op(200,fx,listadenr).

[] e_multime.
[H|T] e_multime :- not(H in T), T e_multime.

listadenr [].
listadenr [H|T] :- number(H), listadenr T.

L listord :- listadenr L, L ordonata.

% lista de numere ordonata crescator dupa valorile absolute ale elementelor sale:

:- op(100,xfx,[are_val_abs, =#<]).

X are_val_abs X :- X>=0.
X are_val_abs ModulX :- X<0, ModulX is -X.

X =#< Y :- X are_val_abs ModulX, Y are_val_abs ModulY, ModulX =< ModulY.

[] ordonata.
[_] ordonata.
[X,Y|T] ordonata :- X =#< Y, [Y|T] ordonata. 

/* Putem declara astfel si operatori care nu sunt neaparat predicate,
adica nu au neaparat rezultatul de tip boolean: */

:- op(100,xfx,cu).
:- op(100,yf,factorial). % admite ca operand un termen cu operatorul dominant "factorial"
:- op(100,fy,succ). % admite ca operand un termen cu operatorul dominant "succ"

:- op(300,xf,ord).

[X cu Y, Z cu V | T] ord :- X =#< Z, V =#< Y, [Z cu V | T] ord.

calcul(0 factorial, 1).
calcul(N,N) :- integer(N), N>0, !.
calcul(N factorial, Nfact) :- calcul(N,Nr), P is Nr-1,
		calcul(P factorial, Pfact), Nfact is Pfact*Nr.

:- op(100,yf,!). % Prologul admite chiar si aceasta denumire de operator

calc(0 !, 1).
calc(N,N) :- integer(N), N>0, !.
calc(N !, Nfact) :- calc(N,Nr), P is Nr-1, calc(P !, Pfact), Nfact is Pfact*Nr.

/* Interogati:
?- calcul(3 factorial factorial, F).
?- calc(3 ! !, Fact).
?- calcul(3 factorial factorial factorial, F).
?- calc(3 ! ! !, Fact).
*/

/* Amintesc ca, la fel cum folosirea predicatelor setof, bagof, findall poate fi
inlocuita cu recursii simple, bazate doar pe unificare, la fel se intampla si in
cazul calculelor aritmetice.
De exemplu, sa consideram specificatia lui Peano pentru numerele naturale - care
poate fi extinsa la numere intregi, rationale etc. -, in care numerele naturale 
sunt generate pornind de la constanta zero prin aplicarea operatorului unar succesor: */

% Adunarea si inmultirea numerelor naturale generate astfel:

adun(X,zero,X).
adun(X,succ Y,succ Z) :- adun(X,Y,Z).

inmult(X,zero,zero).
inmult(X,succ Y,Z) :- inmult(X,Y,V), adun(V,X,Z).

% Lungimile listelor ca numere naturale generate astfel:

lung([],zero).
lung([_|T],succ N) :- lung(T,N).

/* Interogati:
?- adun(succ succ zero, succ succ succ zero, RezultatAdunare).
?- inmult(succ succ zero, succ succ succ zero, RezultatInmultire).
?- lung([1,2,3,4,5],Lungime).
?- lung([zero,succ zero],Lungime).
*/







 




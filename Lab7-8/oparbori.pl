/* Sa ne amintim predicatul binar infixat predefinit "=..":
Termen =.. [OperatorDominant | ListaArgumenteOperatorDominant]
Interogati:
?- ct=..Lista.
?- Termen=..[ct].
?- ct=..[OpDom|ListArg].
?- f(a,g(X),2,h(g(V)))=..Lista.
?- Termen=..[f,a,g(X),2,h(g(V))].
?- f(a,g(X),2,h(g(V)))=..[OpDom,X,V,Y,Z].
?- f(a,g(X),2,h(g(V)))=..[OpDom,X,W,Y,h(W)].
?- f(a,g(X),2,h(g(V)))=..[OpDom,X,V,X,Y].
?- f(a,g(X),2,h(g(V)))=..[OpDom,X,V,Y,Y].
?- [1,2,3,4,5]=..[OpDom|ListArg].
?- [1]=..[OpDom|ListArg].
?- []=..[OpDom|ListArg].
?- []=..Lista.
?- [1,2,3,4,5]=..[OpDom,Arg1,Arg2].
?- [1]=..[OpDom,Arg1,Arg2].
?- f(a,g(X),2,h(g(V)))=..[OpDom,Arg1,Arg2,Arg3].
?- f(a,g(X),2,h(g(V)))=..[OpDom,Arg1,Arg2,Arg3,Arg4].
?- f(a,g(X),2,h(g(V)))=..[OpDom,Arg1,Arg2,Arg3,Arg4,Arg5].
?- [1,2,3,4,5]=..[OpDom,Arg1,Arg2,Arg3|ListaAlteArg].
Sa vedem si predicatele ternare predefinite "functor" si "arg":
functor(Termen, OperatorDominant, AritateOperatorDominant)
arg(NumarArgument, Termen, Argument)
Interogati:
?- functor(f(a,g(X),2,h(g(V))), OpDom, Aritate).
?- functor(ct, OpDom, Aritate).
?- functor(Termen, f, 4).
?- functor(Termen, ct, 0).
?- functor([1,2,3,4,5], OpDom, Aritate).
?- functor([1], OpDom, Aritate).
?- functor([], OpDom, Aritate).
Interogati, si cereti toate solutiile, cu ";"/"Next":
?- arg(Nr, f(a,g(X),2,h(g(V))), Argument).
?- arg(Nr, f(a,g(X),2,h(g(V))), h(W)).
?- arg(Nr, f(a,g(X),Y,2,h(g(V)),Z), h(W)).
?- arg(Nr, f(a,g(X),2,h(g(V))), f(W)).
?- arg(Nr, f(a,g(X),Y,2,h(g(V)),Z), f(W)).
?- arg(5, f(a,g(X),2,h(g(V))), Arg).
?- arg(Nr, [10,20,30,40,50], Arg).
?- arg(Nr, [10], Arg).
?- arg(Nr, [], Arg).
?- arg(Nr, ct, Arg).
*/

:- ['arbori.pl']. /* declaratie pentru includerea bazei de cunostinte arbori.pl
in baza de cunostinte curenta, in cazul in care acestea se afla in acelasi folder;
putem da o astfel de declaratie si fara extensia fisierului:
:- [arbori].
iar, pentru baze de cunostinte din alt folder, dam si calea in astfel de declaratii:
:- ['drive://folder//subfolder//...//arbori.pl'].
*/

/* Transformarea unui arbore, fie ca e binar, fie ca e oarecare, intr-un
termen de forma arb(EtichetaRadacinii,Subarbore1,Subarbore2,...,SubarboreN),
cu arborele vid, reprezentand un caz separat, transformat in constanta arb;
in cazul arborilor binari, pentru nodurile cu un singur subarbore, se pierde
informatia cum ca acel subarbore e stang sau drept: */

transf(null,arb).
transf(nil,arb).
transf(arb(Rad,Stg,Dr),Termen) :- transf(arb(Rad,[Stg,Dr]),Termen).
transf(arb(Rad,ListaSubarb),Termen) :- transflist(ListaSubarb,ListaSubarbTransf),
					Termen=..[arb | [Rad|ListaSubarbTransf]].

transflist([],[]).
transflist([nil|ListArb],ListArbTransf) :- transflist(ListArb,ListArbTransf), !.
transflist([Arb|ListArb],[ArbTransf|ListArbTransf]) :- transf(Arb,ArbTransf), 
						transflist(ListArb,ListArbTransf).

/* Dati interogarea:
?- (arbbin(N,A), desenarbbin(A) ; arbore(N,A), write(A)), nl, sleep(2), transf(A,AT), write(AT), nl, sleep(3), fail.
Prologul preia fiecare arbore binar memorat cu predicatul arbbin si fiecare arbore
oarecare memorat cu predicatul arbore din baza de cunostinte arbori.pl, ii deseneaza
pe cei binari si ii scrie ca termeni Prolog pe cei oarecare, trece la linie noua,
face o pauza de 2 secunde, transforma fiecare dintre acesti arbori intr-un arbore
reprezentat printr-un termen Prolog ca mai sus, scrie acest termen pe ecran, face o
pauza de 3 secunde, apoi esueaza, astfel ca, incercand sa satisfaca aceasta 
interogare, trece la urmatorul arbore, pentru a satisface disjunctia de la inceputul
acestei interogari. La final esueaza, asadar nu intoarce valori pentru variabilele
din aceasta interogare; vedem valorile acestora care satisfac conjunctia care
preceda predicatul fail doar in acele afisari pe ecran. */

/* In cele ce urmeaza, folosim conventia din documentatia Prolog pentru a descrie
predicatele: argumentele precedate de "+" trebuie furnizate in interogari, iar cele
precedate de "-" sunt construite de predicatele respective.
Observati definitiile predicatelor "=..", functor si arg in documentatia Prolog:
argumentele precedate de "?" indica faptul ca putem interoga in mai multe moduri;
de exemplu, dupa cum observam din interogarile de mai sus, predicatul "=.." nu 
permite interogari de forma VariabilaptTermen=..VariabilaptLista (da eroarea 
argumente insuficient instantiate), dar admite toate celelalte moduri de interogare,
in particular descompune orice termen in lista avand drept cap operatorul dominant
si drept coada lista argumentelor acestui operator, dar si reconstituie termenii din 
astfel de liste. */
 
/* nleaelem(+N,+Lista,-Elem)=true <=> Elem este al N-lea element din lista Lista, 
unde N este un numar natural nenul, iar Lista este o lista nevida */

nleaelem(1,[H|_],H).
nleaelem(N,[_|T],X) :- N>1, P is N-1, nleaelem(P,T,X).

/* nleasubarb(+N,+Arbore,-Subarbore)=true <=> nthsubarb(+N,+Arbore,-Subarbore)=true
<=> Arbore este un arbore oarecare nevid construit ca in fisierul arbori.pl, N este
un numar natural nenul, iar Subarbore este al N-lea subarbore al radacinii lui Arbore
*/

nleasubarb(N,arb(_,ListaSubarb),Subarb) :- nleaelem(N,ListaSubarb,Subarb).

nthsubarb(N,Arb,Subarb) :- transf(Arb,ArbTransf), M is N+1, arg(M,ArbTransf,Subarb).


 




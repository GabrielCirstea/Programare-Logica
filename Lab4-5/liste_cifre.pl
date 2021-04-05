/* Lista cifrelor unui numar:
listacf(N,Lcf)=true <=> N e un numar natural, iar Lcf e lista cifrelor
lui N ordonate de la cifra unitatilor la cifra cea mai semnificativa;
listacford(N,Lcf)=true <=> N e un numar natural, iar Lcf
e lista cifrelor lui N in ordinea in care apar in N. */

listacf(N,_) :- (not(integer(N)) ; N<0), write('tip argument incorect'), !.
listacf(N,[N]) :- N<10, !.
listacf(N,[CifraUnitatilor|T]) :- CifraUnitatilor is N mod 10, M is N div 10, listacf(M,T). 

listacford(N,Lcf) :- listacf(N,L), inversa(L,Lcf).

concat([],L,L).
concat([H|T],L,[H|M]) :- concat(T,L,M).

inversa([],[]).
inversa([H|T],L) :- inversa(T,M), concat(M,[H],L).

simetrica(L) :- inversa(L,L).

% palindrom(N)=true <=> N e numar natural si e palindrom

palindrom(N) :- listacf(N,L), simetrica(L).

/* Numarul cu o anumita lista de cifre: daca L e o lista de cifre, atunci:
nrcucf(L,N)=true <=> N e numarul natural cu proprietatea ca Lcf e lista
cifrelor lui N ordonate de la cifra unitatilor la cifra cea mai semnificativa;
nrcucford(L,N)=true <=> N e numarul natural cu proprietatea ca Lcf
e lista cifrelor lui N in ordinea in care apar in N. */

nrcucf([Cifra],Cifra).
nrcucf([CifraUnitatilor,CifraZecilor|T],N) :- nrcucf([CifraZecilor|T],M),
				 N is M*10+CifraUnitatilor.

nrcucford(Lcf,N) :- inversa(Lcf,L), nrcucf(L,N).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

membru(X,[X|_]).
membru(X,[_|T]) :- membru(X,T).

% listaNelem(L,N,Lista)=true <=> Lista e o lista de lungime N formata din elemente ale listei L

listaNelem(L,1,[X]) :- membru(X,L).
listaNelem(L,N,[H|T]) :- N>1, P is N-1, listaNelem(L,P,T), membru(H,L).

/* Vom defini urmatoarele predicate si folosind setof sau findall, si prin recursii clasice,
fara folosirea acestor predicate predefinite. Amintesc ca orice predicat care foloseste setof,
bagof sau findall poate fi scris si printr-o recursie care foloseste doar unificari, nu si
astfel de predicate predefinite in Prolog care colecteaza termenii care satisfac alte predicate. */

/* listeleNelem(L,N,ListaListe)=true <=> listelecuNelem(L,N,ListaListe)=true <=>
<=> listecuNelem(L,N,ListaListe)=true <=> ListaListe e lista tuturor listelor de lungime N
formate din elemente ale listei L. */

%%% Folosind setof:

listeleNelem(L,N,ListaListe) :- setof(Lista, listaNelem(L,N,Lista), ListaListe).

%%% Recursie:

listecuNelem(L,1,ListaListe) :- transf_lista_listalistesgl(L,ListaListe).
listecuNelem(L,N,ListaListe) :- N>1, P is N-1, listecuNelem(L,P,LL),
				adaug_fiec_elem(L,LL,ListaListe).

transf_lista_listalistesgl([],[]).
transf_lista_listalistesgl([H|T],[[H]|LL]) :- transf_lista_listalistesgl(T,LL).

adaug_fiec_elem([],_,[]).
adaug_fiec_elem([H|T],LL,ListaListe) :- adaug_fiec_elem(T,LL,ListL),
					adaug_elementul(H,LL,ListList),
			           	concat(ListL,ListList,ListaListe).

adaug_elementul(_,[],[]).
adaug_elementul(X,[H|T],[[X|H]|LL]) :- adaug_elementul(X,T,LL).

%%% Varianta mixta intre recursie si folosirea lui setof:

listelecuNelem(L,1,ListaListe) :- transf_lista_listlistsgl(L,ListaListe).
listelecuNelem(L,N,ListaListe) :- N>1, P is N-1, listelecuNelem(L,P,LL),
				adaug_fiec_elem(L,LL,ListaListe).

transf_lista_listlistsgl(L,LL) :- setof([X], membru(X,L), LL).

/* adaug_fiec_elem(Lista,ListaListe,NouaListaListe)=true <=> NouaListaListe e lista de liste
obtinuta prin adaugarea cate unui element din Lista la fiecare lista din ListaListe, pentru
fiecare element al lui Lista;
   adaug_elementul(Element,ListaListe,NouaListaListe)=true <=> NouaListaListe e lista de liste
obtinuta prin adaugarea elementului Element la fiecare lista din ListaListe;
   
transf_lista_listalistesgl(Lista,ListaListe)=true <=> transf_lista_listlistsgl(Lista,ListaListe)=true <=>
<=> ListaListe e lista listelor singleton (adica avand cate un singur element) continand cate un element
din lista Lista. */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Predicat pentru memorarea unei liste de cifre in aceasta baza de cunostinte, pentru
a nu fi necesara introducerea ei in interogari: */

lista_fixa_cifre([0,1,7]).

/* Daca ListaCifre e o lista de cifre, atunci:
numerecuNcf(ListaCifre,N,ListaNr)=true <=> numcuNcf(ListaCifre,N,ListaNr) <=> 
<=> numerelecuNcf(ListaCifre,N,ListaNr) <=> numrlecuNcf(ListaCifre,N,ListaNr) <=> 
<=> ListaNr e lista numerelor naturale cu N cifre din ListaCifre (adica avand cate N cifre si
cu fiecare cifra apartinand lui ListaCifre).
   nrcuNcf(N,ListaNr)=true <=> numerecuNcf(N,ListaNr)=true <=> nrlecuNcf(N,ListaNr)=true <=>
<=> numlecuNcf(N,ListaNr)=true <=> ListaNr e lista numerelor naturale cu N cifre din ListaCifre,
unde ListaCifre e lista memorata cu predicatul lista_fixa_cifre. */

%%% Folosind setof sau findall:

numerecuNcf(Lcf,N,ListaNr) :- findall(Nr, (listaNelem(Lcf,N,ListaCf), nrcucf(ListaCf,Nr)), ListaNr).

nrcuNcf(N,ListaNr) :- lista_fixa_cifre(Lcf), numerecuNcf(Lcf,N,ListaNr).

numcuNcf(Lcf,N,ListaNr) :- setof(Nr, ListaCf^(listaNelem(Lcf,N,ListaCf), nrcucf(ListaCf,Nr)), ListaNr).

numrcuNcf(N,ListaNr) :- lista_fixa_cifre(Lcf), numcuNcf(Lcf,N,ListaNr).

/* Dati aceste interogari, pentru a vedea de ce avem nevoie de cuantificarea existentiala a
variabilei ListaCf in implementarea predicatelor anterioare:
?- setof(Nr, (listaNelem([0,2,5],2,ListaCf), nrcucf(ListaCf,Nr)), ListaNr).
?- lista_fixa_cifre(Lcf), setof(Nr, (listaNelem(Lcf,2,ListaCf), nrcucf(ListaCf,Nr)), ListaNr).
?- bagof(Nr, (listaNelem([0,2,5],2,ListaCf), nrcucf(ListaCf,Nr)), ListaNr).
?- lista_fixa_cifre(Lcf), bagof(Nr, (listaNelem(Lcf,2,ListaCf), nrcucf(ListaCf,Nr)), ListaNr).
*/

%%% Recursiv:

numerelecuNcf(Lcf,N,ListaNr) :- listecuNelem(Lcf,N,LL), transf_listecf_listanr(LL,ListaNr).

transf_listecf_listanr([],[]).
transf_listecf_listanr([Lcf|ListaLcf],[H|T]) :- nrcucf(Lcf,H), transf_listecf_listanr(ListaLcf,T).

nrlecuNcf(N,ListaNr) :- lista_fixa_cifre(Lcf), numerelecuNcf(Lcf,N,ListaNr).

/* Daca ListaListeCifre e o lista de liste de cifre, atunci:
transf_listecf_listanr(ListaListeCifre,ListaNr)=true <=> ListaNr e lista obtinuta din ListaListeCifre
prin inlocuirea fiecarei liste ListaCifre din ListaListeCifre cu numarul avand lista de cifre ListaCifre. */

%%% Variante mixte intre recursie si folosirea lui setof sau findall:

numrlecuNcf(Lcf,N,ListaNr) :- listelecuNelem(Lcf,N,LL), transf_listecf_listanr(LL,ListaNr).

numlecuNcf(N,ListaNr) :- lista_fixa_cifre(Lcf), numrlecuNcf(Lcf,N,ListaNr).

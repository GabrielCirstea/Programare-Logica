:- ['arbori.pl'].   % vom folosi parcurgerea in inordine din aceasta baza de cunostinte

% predicat pentru sortare cu arbori binari de cautare:

sortarbcaut(Lista, ListaSortata) :- insertlist(Lista, nil, Arbore), inord(Arbore, ListaSortata).

/* predicat pentru inserarea unei liste de numere intr-un arbore binar de cautare
astfel incat arborele cu noile noduri sa ramana arbore binar de cautare: */

insertlist([], Arbore, Arbore).
insertlist([H|T], Arbore, ArboreNou) :- insert(H, Arbore, Arb), insertlist(T, Arb, ArboreNou).

/* predicat pentru inserarea unui numar intr-un arbore binar de cautare
astfel incat arborele cu noile noduri sa ramana arbore binar de cautare: */

insert(X, nil, arb(X,nil,nil)).
insert(X, arb(Rad,Stg,Dr), arb(Rad,Stang,Dr)) :- X=<Rad, insert(X,Stg,Stang), !.
insert(X, arb(Rad,Stg,Dr), arb(Rad,Stg,Drept)) :- insert(X,Dr,Drept).

/* inseram elementul in subarborele stang daca e mai mic sau egal decat eticheta radacinii,
asadar arborele binar de cautare creat va fi nestrict la stanga */

/* random_between(+L,+U,-R): predicat ternar predefinit pentru generarea unui numar intreg
			  pseudoaleator cuprins intre L si U;
randseq(+K,+N,-ListaNrAleatoare): predicat ternar predefinit pentru generarea unei liste de 
			        K numere naturale pseudoaleatoare cuprinse intre 1 si N.
Putem interoga:
?- randseq(100,1000,Lista), write(Lista), nl, sortarbcaut(Lista, ListaSortata), write(ListaSortata).
atom_concat(A,B,Atom), atomic_concat(+A,+B,-Atom): predicate ternar predefinite pentru concatenarea
		a doi atomi, respectiv doua elemente de tip atomic A si B, obtinand un atom Atom.
A se vedea in documentatia online a SWI-Prolog predicatele predefinite pentru conversii
intre atomi, numere si siruri de caractere. */

cale('d://temporar//').
extensie('.doc').

:- dynamic numefis/2.   % numefis(DescriereContinut,NumeFisier)

numefis(arbbincaut,'d://temporar//arbori_binari_de_cautare.doc').
numefis(liste_sortate,'d://temporar//liste_sortate.doc').

% Predicat pentru crearea unui fisier cu liste generate aleator si memorarea numelui acestuia:

fisculiste(N,NrListe) :- atomic_concat(NrListe,'_liste_nr_mmici_decat_',Nume), atomic_concat(Nume,N,NumeFis),
		   cale(Cale), atom_concat(Cale,NumeFis,CaleNumeFis),
		   extensie(Extensie), atom_concat(CaleNumeFis,Extensie,CaleNumeFisExtensie),
		   assert(numefis(liste,CaleNumeFisExtensie)),
		   told, tell(CaleNumeFisExtensie), genliste(N,NrListe), told.

genliste(_,0).
genliste(N,NrListe) :- NrListe>1, M is N div 10, random_between(0,M,K), randseq(K,N,Lista), write(Lista), write('.'), nl,
		  PredNrListe is NrListe-1, genliste(N,PredNrListe).

/* Predicat pentru citirea din fisierul cu liste generate aleator si sortarea cu arbori binari de cautare a fiecarei liste
din acest fisier, scriind arborii binari de cautare si listele sortate in fisierele de mai sus: */

sortcufis :- seen, numefis(liste,FisListe), see(FisListe), citsisort, seen.

/* Intrucat scriem in doua fisiere alternativ, folosim in locul lui tell predicatul unar predefinit append, care deschide
fisierul pentru scriere si muta cursorul la sfarsitul fisierului, astfel ca datele din fisier se adauga, nu se suprascriu: */

citsisort :- read(Lista), is_list(Lista),
	 insertlist(Lista, nil, Arbore), numefis(arbbincaut,FisArb), append(FisArb), write(Arbore), write('.'), nl, told, 
	 inord(Arbore, ListaSortata), numefis(liste_sortate,FisLS), append(FisLS), write(ListaSortata), write('.'), nl, told, 
	 citsisort.

/* is_list(Termen): predicat unar predefinit care testeaza daca argumentul sau este lista; poate fi inlocuit cu:
	Termen=[] ; Termen=[_|_] */

/* Interogati:
?- fisculiste(1000,10).
?- sortcufis.
Daca, dupa executia unui predicat care scrie in fisiere, nu puteti vizualiza continutul acelor fisiere cand le deschideti,
atunci dati comanda told sau inchideti Prologul, si abia dupa aceea deschideti fisierele pentru a vedea rezultatul scrierii. */
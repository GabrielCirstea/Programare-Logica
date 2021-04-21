/* Joc de x si 0 jucator contra jucator.
Putem juca si alte jocuri, eventual cu alta dimensiune a tablei si cu alte simboluri de pus in locatiile vacante de pe tabla.
Putem implementa aceste jocuri si in forma jucator contra calculator. */

:- dynamic config/1.
:- dynamic jucator/1.

/* Memoram configuratia curenta sub forma: config([Linia1,Linia2,Linia3]). Alte variante:
:- dynamic config/3.   % pentru a retine configuratia sub forma: config(Linia1,Linia2,Linia3).
:- dynamic linia/2.   % pentru a retine configuratia sub forma: linia(1,Linia1). linia(2,Linia2). linia(3,Linia3).
Memoram simbolul cu care joaca jucatorul curent (x sau 0) sub forma: jucator(Simbol). */

/* Predicatul zeroar "start" incepe jocul: retrage din baza de cunostinte configuratia finala a tablei din jocul anterior
si orice alta configuratie memorata, precum si simbolul curent ramas din jocul anterior si orice alt simbol memorat,
apoi adauga la baza de cunostinte configuratia initiala a tablei, pe care o afiseaza pe ecran, si simbolul curent x: */

start :- retractall(config(_)), assert(config([[v,v,v],[v,v,v],[v,v,v]])), arata_tabla, retractall(jucator(_)), assert(jucator(x)).

/* Marcam locatiile neocupate de pe tabla prin constanta v, dar le afisam sub forma ' .'.
Desigur, putem marca locatiile vide chiar prin atomul ' .' sau sirul de caractere " .". */

arata_tabla :- config(ListaLinii), afiseaza(ListaLinii).

afiseaza([]).
afiseaza([Linia | ListaLinii]) :- afis_linia(Linia), nl, afiseaza(ListaLinii).

afis_linia([]).
afis_linia([Simbol | ListaSimboluri]) :- (Simbol=v, write(' .'), ! ; write(Simbol)), afis_linia(ListaSimboluri).

/* Varianta de scriere a predicatului unar afis_linia, separand disjunctia pe mai multe randuri:
afis_linia([]).
afis_linia([v | ListaSimboluri]) :- write(' .'), !, afis_linia(ListaSimboluri).
afis_linia([Simbol | ListaSimboluri]) :- write(Simbol), afis_linia(ListaSimboluri).
*/

/* Mutarile vor fi date sub forma pune(Simbol,Linie,Coloana). Jocul se va desfasura in maniera urmatoare:
?- start.
?- pune(x,2,1).
?- pune(0,2,2).
?- pune(x,3,3).
s. a. m. d.. */

pune(Simbol,_,_) :- jucator(SimbolCurent), Simbol\=SimbolCurent,
	              write('mutare gresita: este la mutare jucatorul '), write(SimbolCurent), nl, !,
	              arata_tabla. %%% daca Simbol nu e un simbol de joc sau nu e la mutare jucatorul care joaca cu Simbol,
	      %%% atunci scriem eroarea si nu modificam nici configuratia curenta, nici simbolul curent, iar, in caz contrar:
pune(_,Linie,Coloana) :- not((integer(Linie), integer(Coloana), Linie>0, Coloana>0, Linie<4, Coloana<4)), !, %%% (VerifCoord)
		      write('mutare gresita: liniile si coloanele sunt numerotate de la 1 la 3'), nl, arata_tabla. %%% daca 
			%%% aceste coordonate nu se afla pe tabla, atunci scriem eroarea, altfel testam mutarea:
pune(Simbol,Linie,Coloana) :-	config(ListaLinii), mutare(Simbol,Linie,Coloana,ListaLinii,NouaListaLinii), !, %%% daca aceste
			      %%% coordonate marcheaza o locatie neocupata, atunci efectuam mutarea: schimbam
			retractall(config(_)), asserta(config(NouaListaLinii)), arata_tabla, %%% configuratia curenta,
			not(test_castig(NouaListaLinii,Simbol)), %%% iar, daca aceasta nu e o configuratie de castig
			not(test_remiza(NouaListaLinii)), %%% si jocul nu s-a incheiat nici cu umplerea tablei,
			schimba_jucator(Simbol). %%% atunci se schimba simbolul cu care joaca jucatorul curent
pune(_,_,_) :- arata_tabla. %%% daca mutarea a fost incorecta, atunci afisam din nou configuratia curenta, neschimbata;
				%%% important este doar ca predicatul "pune" sa fie satisfacut si in acest caz,
				%%% pentru ca demo-ul de mai jos sa ruleze pana la sfarsitul fisierului cu mutari

% Predicatul pentru efectuarea mutarilor: mutare(Simbol, Linie, Coloana, ConfiguratieCurenta, NouaConfiguratie):

% mutare(_,_,_,[],[]). %%% pentru ca linia curenta satisface conditia din (VerifCoord), recursia nu ajunge aici
mutare(Simbol,Linie,Coloana,[LiniaCurenta | ListaLinii],[LiniaCurenta | NouaListaLinii]) :- Linie > 1, !, PredLinie is Linie-1,
						mutare(Simbol,PredLinie,Coloana,ListaLinii,NouaListaLinii). 
mutare(Simbol,1,Coloana,[LiniaCurenta | ListaLinii],[NouaLinieCurenta | ListaLinii]) :- 
						muta(Simbol,Coloana,LiniaCurenta,NouaLinieCurenta).

% muta(_,_,[],[]). %%% intrucat coloana curenta satisface conditia din (VerifCoord), recursia nu ajunge aici
muta(Simbol, Coloana, [Simb | ListSimb] , [Simb | NouaListSimb]) :- Coloana >1, !, PredColoana is Coloana-1, 
						            muta(Simbol,PredColoana,ListSimb,NouaListSimb).
muta(Simbol, 1, [v | ListaSimboluri], [Simbol | ListaSimboluri]) :- !. %%% daca locatia e vida, atunci mutarea e corecta
muta(_,_,_,_) :- write('mutare gresita: locatie ocupata'), nl, arata_tabla, fail. %%% in caz contrar, scriem eroarea si predicatul
							%%% muta, asadar si predicatul mutare, intoarce false

% Predicatul pentru schimbarea simbolului cu care joaca jucatorul curent:

schimba_jucator(JucatorCurent) :- retractall(jucator(_)), schimba(JucatorCurent,UrmJucator), assert(jucator(UrmJucator)).

schimba(x,0).
schimba(0,x).

/* test_castig(Configuratie,Simbol)=true <=> Configuratie este o configuratie castigatoare
pentru jucatorul care joaca cu Simbol: */

test_castig(ListaLinii, Simbol) :- (test_linii(ListaLinii,Simbol) ; test_coloane(ListaLinii,Simbol) ; test_diagonale(ListaLinii,Simbol)), 
			 write('a castigat jucatorul '), write(Simbol), retractall(config(_)).

% ectlin(Lista, Simbol)=true <=> toate elementele listei Lista sunt egale (de fapt unifica) cu Simbol:

ectlin([],_).
ectlin([Simbol | ListaSimboluri], Simbol) :- ectlin(ListaSimboluri, Simbol).

% test_linii(ListaListe,Simbol)=true <=> una dintre listele din ListaListe are toate elementele egale cu Simbol:

test_linii([Linia1, Linia2, Linia3],Simbol) :- ectlin(Linia1,Simbol) ; ectlin(Linia2,Simbol) ; ectlin(Linia3,Simbol).

% test_coloane(Configuratie,Simbol)=true <=> una dintre coloanele din Configuratie are toate elementele egale cu Simbol:

test_coloane([[S11,S12,S13], [S21,S22,S23], [S31,S32,S33]],Simbol) :- ectlin([S11,S21,S31],Simbol) ; ectlin([S12,S22,S32],Simbol) ;
						             ectlin([S13,S23,S33],Simbol).

% test_diagonale(Configuratie,Simbol)=true <=> o diagonala din Configuratie are toate elementele egale cu Simbol:

test_diagonale([[S11,_,S13], [_,S22,_], [S31,_,S33]],Simbol) :- ectlin([S11,S22,S33],Simbol); ectlin([S13,S22,S31],Simbol).

/* test_remiza(Configuratie)=true <=> toate locatiile din Configuratie sunt ocupate;
atunci jocul s-a incheiat cu o remiza, pentru ca acest test este efectuat dupa testul de castig: */

test_remiza([Linia1, Linia2, Linia3]) :- not(exista_locatie_vida(Linia1) ; exista_locatie_vida(Linia2) ; exista_locatie_vida(Linia3)), 
			           write('remiza'), retractall(config(_)).

exista_locatie_vida([]) :- fail.
exista_locatie_vida([v|_]) :- !.
exista_locatie_vida([_|Locatii]) :- exista_locatie_vida(Locatii).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Predicate predefinite pentru citire din fisiere si scriere in fisiere:
   see(NumeFisier): deschiderea unui fisier pentru citire; acesta trebuie sa fie un fisier text (.txt, .rtf, .doc etc.) continand
termeni Prolog succedati de punct si separati prin blankuri sau trecere la linie noua;
   read(Termen): citirea cate unui termen din fisierul deschis pentru citire;
   seen: inchiderea fisierului deschis pentru citire;
   tell(NumeFisier): deschiderea (si, eventual, crearea) unui fisier pentru scriere; putem afisa orice intr-un astfel de fisier;
   told: inchiderea fisierului deschis pentru scriere.
Fisierul mutari_xsi0.txt, din folderul d:\temporar, utilizat mai jos, contine termeni de forma pune(Simbol,Linie,Coloana),
care vor fi folositi pentru un demo al jocului de x si 0, lansat cu unul dintre predicatele zeroare startdemo, startdemofis
si varstartdemofis: */

startdemo :- seen, start, see('d://temporar//mutari_xsi0.txt'), demo, seen.

demo :- read(Mutare), functor(Mutare,pune,3), write(Mutare), sleep(2), nl, Mutare, demo. %%% citim termenii, rand pe rand,
	%%% din acest fisier, iar, cat timp acesti termeni au ca operator dominant predicatul ternar pune, asadar indica o
	%%% mutare, scriem aceasta mutare pe ecran, apoi lasam o pauza de 2 secunde, apoi executam aceasta mutare

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

startdemofis :- seen, see('d://temporar//mutari_xsi0.txt'), citeste_lista_mutari(ListaMutari), seen,
	        told, tell('d://temporar//demo_xsi0.txt'), start, demofis(ListaMutari), told.

citeste_lista_mutari(ListaMutari) :- read(Mutare), %%% citim termenii din fisierul cu mutari si ii memoram in ListaMutari
	(functor(Mutare,pune,3), !, citeste_lista_mutari(LMutari), ListaMutari=[Mutare | LMutari] ; ListaMutari=[]).

demofis([]). %%% apoi executam mutarile citite, scriindu-le in fisierul demo_xsi0.txt din folderul d:\temporar
demofis([Mutare | ListaMutari]) :- write(Mutare), nl, Mutare, demofis(ListaMutari).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

varstartdemofis :- seen, see('d://temporar//mutari_xsi0.txt'),  told, tell('d://temporar//vardemo_xsi0.txt'), 
	             start, demofis, told, seen. %%% deschidem fisierul cu mutari pentru citire si fisierul vardemo_xsi0.txt
				      %%% din folderul d:\temporar pentru scriere, apoi executam:

demofis :- read(Mutare), functor(Mutare,pune,3), write(Mutare), nl, Mutare, demofis. %%% predicat care face acelasi lucru
		%%% ca predicatul demo, mai putin lasarea pauzelor de cate 2 secunde dupa scrierea fiecarei mutari

/* Daca, dupa executia unui predicat care scrie in fisiere, nu puteti vizualiza continutul acelor fisiere cand le deschideti,
atunci dati comanda told sau inchideti Prologul, si abia dupa aceea deschideti fisierele pentru a vedea rezultatul scrierii. */

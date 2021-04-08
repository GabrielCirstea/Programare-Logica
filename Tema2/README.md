# Tema 2

Aici ar trebui sa fie tema 2 la pl

## Ex1

De facut sortari pe ordine arbitrara, ordinea se da ca parametru (ex; <, >, >=, =<).

* insertion
* bubble
* quick

Trebuie facut si Merge

## Ex2

Listele au acceasi lungime?

Ce se intampla daca lungimile sunt dicerite?

Vrem ca L < M?(pentru ordinea lexicografica)

## Ex3

Din cauza apelurilor recursive este nevoie de acel '!'(semn de exclamare) la
sfarsitul functiilor sumar/2 si maxar/2, pentru a opri returnarea rezultatului
in mod repetat.

### sumar

Face suma aritatiilor termeniilor, adica numarul de argumente din functie

* sumar 
	* functor/3 ne da aritatea acestui termen
	* pentru fiecare element/argument calculam aritatea tot cu sumar
	* daca functor/3 returneaza Aritate 0, atunci termenul este o constanta
sau variabila
* parcurgeArgSum - parcurge lista de argumente
	* pentru fiecare argument dintr-ul termen Prolog apeleaza sumar/2 si ii afla
aritatea
	* returneaza suma aritatiilor optinute
	* se opreste pana in index 0

### maxar

Predicat care afla "argumetnul" cu cele mai multe argumente dintr-un termen Prolog

* maxar
	* folosim tot functor/3 pentru aritate
	* daca functor/3 returneaza Aritate 0, atunci termenul este o constanta
sau variabila
* parcurgeArgMax
	* pentru fiecare argumetn dintr-ul termen Prolog apeleaza maxar
	* returneaza maximul dintre rezultatele optiune
	* se opreste pana in index 0

### maxsubterm

Termenul cel mai mare in ordinea standard a termenilor prolog din argumentele
unui termen........

* maxsubterm
	* formeaza lista termeniilor dintr-un termen folosind operatorul **=..**
	* sorteaza lista respectiva si selecteaza primul element
	* in cerinta se specifa mazimul in raport cu ordinea **@=<**, am folosit ordinea
**@>=**(opusul) pentru a avea maximul la inceputul listei
* parcurgeArgSub
	* pentru fiecare argument, apeleaza maxsubterm
	* foloseste quicksort pentru a pastra mereu cel mai mare termen gasit 
* cuvantul cheie este **quicksort**

Se poate ca implementarea cu quicksort sa nu fie bune, intrucat la exercitiul 4
cere o ordinare a termenilor dupa ordinea **@=<**, care aici este facuta cu quicksort

De asemenea, nu stiu cat de stabile sunt sortarile de la laborator pentru operatiile
de ordine cu **@**.

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

### sumar

Face suma aritatiilor termeniilor, adica numarul de argumente din functie

* sumar 
	* functor/3 ne da aritatea acestui termen
	* pentru fiecare element/argument calculam aritatea tot cu sumar
* parcurgeArgSum - parcurge lista de argumente
	* pentru fiecare argument dintr-ul termen Prolog apeleaza sumar/2 si ii afla
aritatea
	* returneaza suma aritatiilor optinute

### maxar

Predicat care afla "argumetnul" cu cele mai multe argumente dintr-un termen Prolog

* maxar
	* folosim tot functor/3 pentru aritate
* parcurgeArgMax
	* pentru fiecare argumetn dintr-ul termen Prolog apeleaza maxar
	* returneaza maximul dintre rezultatele optiune

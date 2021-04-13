# Tema 2

Aici ar trebui sa fie tema 2 la pl

## Ex1

De facut sortari pe ordine arbitrara, ordinea se da ca parametru (ex; <, >, >=, =<).

* insertion
* bubble
* quick
* merge sort

## Ex2

### lex

Pentru 2 liste de numere, verifica daca elementele din prima sunt mai mici decat
elementele corespunzatoare din a doua lista.

* pentru fiecare element din lista se verifica daca acesta este numar, si se
compara cu elementul corespunzator din cealalta lista
* daca a doua lista este mai lunga decat prima, se verifica daca are numai numere
	* cu predicatul **verint/1**
* daca prima lista este mai lunga decat a doua, atunci nu sunt in ordine lexicografica

### lexterm

Analog cu lex, doar ca aici listele contin termeni prolog

Aici facem operatorii sa poata fi folositi si cu notatie infixata

```
:- op(500, xfx, [lex, lexterm]).
```

## Ex3

Din cauza apelurilor recursive este nevoie de acel '!'(semn de exclamare) la
sfarsitul functiilor sumar/2 si maxar/2, pentru a opri returnarea rezultatului
in mod repetat.

### sumar

sumar(Termen, Suma) - Suma este suma aritatiilor lui Termen plus termenilor
acestuia

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

maxar(Termen, Max) - Max este cea mai mare aritate dintre aritatea Termen-ului
si aritatiiler celorlalti termeni ai sai

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

maxsubterm(Termen, MaxTerm) - returneaza in MaxTerm, termenul maxim din ordinea
prolog pe termeni

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

## Ex4

### sortariListeNumere

Doar apeleaza o sortare pe lista respectiva, folosind lex/2 ca operator pentru
ordine

### sirtListeTermeni

Analog cu anteriorul predicat, dar foloseste lexterm/2 pentru ordine

### ordoneazaArrSum

Ordoneaza o lista de termeni prolog, duma suma aritatiilor acestora, date de 
sumar/2

* comparaArrSum - foloseste sumar/2 pentru a stabili daca 2 termeni se afla in
ordinea buna
	* este folosit pe post de operator de ordine in sortare

### ordoneazaArrMaxime

Ordoneaza o lista de termeni prolog dupa aritatea maxima a acestora sau a
subtermenilor

Este asemanator cu predicatul anterior, dar foloseste maxar pentru a stabili ordinea

* comparaArrMaxime
	* calculeaza aritatea maxima a termenilor si le compara

### ordoneazaSubMax

Ordoneaza o lista crescator dupa subtermenul maxim

* foloseste comparaSubMax ca operator de ordine in sortare
* comparaSubMax/2
	* afla termenii maximi din 2 subtermeni primiti ca argumente si ii compara

listaTermeni este un predicat in care am pus cateva liste de termeni pentru
testarea predicatelor

Predicatele nu au fost testate in totalitate, testele curente au asigurat o minima
functionalitate


## Ex5

### reodterm

Ordoneaza termenii/argumentele unui termen

Un argument f(T1,T2,T3...) devine f(U1,U2,U3,...)

Unde U1, U2, U3, au fost sortati de asemenea

* se foloseste operatorul
```
=..
```
pentru a se desface termenul intr-o lista in care sa avem argumentele acestuia

* se ordoneaza lista
* se aplica recursiv sortarea pe fiecare element din lista
* se reasambleaza termenul
```
TermenNou=..[Operator|ListaSortata]
```

### parcurgeLista

* parcurge lista de termeni si apeleaza reordterm pentru fiecare element

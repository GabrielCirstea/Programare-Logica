% functor/3
% arg/3

% sumar(Termen, SumaAritati) - in suma aritati returneaza suma tuturor aritatiilor
% termenilor din Termen + aritatea lui Termen
sumar([], 0).
sumar(Term, 0) :- functor(Term,_,0).
% ia aritatea astiua, apoi parcurge argumentele si calculeaza-le aritatiile
sumar(Termen,SumaAritati) :- functor(Termen,_,Arr), parcurgeArgSum(Termen,Arr,Aritati),
				SumaAritati is Arr+Aritati, !.
parcurgeArgSum(_,0,0) :- !.
% pentru fiecare argument, apeleaza sumar/2
parcurgeArgSum(Termen,N,Aritate) :- arg(N,Termen,Op), sumar(Op,Arr), P is N-1,
								parcurgeArgSum(Termen,P,Arr2), Aritate is Arr+Arr2.

% maxar(Termen, Max) - returneaza in Max, aritatea maxima dintre aritatea lui
% Termen si aritatiile toturo termenilor acestuia
maxar(Term, 0) :- functor(Term,_,0).
maxar(Termen, AritateMaxima) :- functor(Termen,_,Arr), parcurgeArgMax(Termen,Arr,MaxAritate),
				AritateMaxima is max(Arr, MaxAritate), !.
parcurgeArgMax(_,0,0) :- !.
parcurgeArgMax(Termen,N,MaxAritate) :- arg(N,Termen,Arg),maxar(Arg,Arr),
				P is N-1, parcurgeArgMax(Termen,P,Arr2), MaxAritate is max(Arr,Arr2).

:- ['./ex1.pl'].

% returneaza in SubtermenMaxim cel mai mare termen, in ordinea stabilita de
% prolog
maxsubterm(Termen,SubtermenMaxim) :- functor(Termen,_,Arr),Termen=..[_|List],
						parcurgeArgSub(Termen,Arr,MaxSub),
						quicksort([Termen,MaxSub|List],[SubtermenMaxim|_],@>=),!.

parcurgeArgSub(Termen,0,Termen).
parcurgeArgSub(Termen,N,SubtermenMaxim) :- arg(N, Termen, Arg), maxsubterm(Arg,Max),
				P is N-1, parcurgeArgMax(Termen,P,Max2),quicksort([Termen,Max,Max2],[SubtermenMaxim|_],@>=).


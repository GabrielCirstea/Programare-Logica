% functor/3
% arg/3

sumar([], 0).
sumar(Term, 0) :- functor(Term,_,0).
% ia aritatea astiua, apoi parcurge argumentele si calculeaza-le aritatiile
sumar(Termen,SumaAritati) :- functor(Termen,_,Arr), parcurgeArgSum(Termen,Arr,Aritati),
				SumaAritati is Arr+Aritati, !.
parcurgeArgSum(_,0,0) :- !.
% pentru fiecare argument, apeleaza sumar/2
parcurgeArgSum(Termen,N,Aritate) :- arg(N,Termen,Op), sumar(Op,Arr), P is N-1,
								parcurgeArgSum(Termen,P,Arr2), Aritate is Arr+Arr2.

maxar(Term, 0) :- functor(Term,_,0).
maxar(Termen, AritateMaxima) :- functor(Termen,_,Arr), parcurgeArgMax(Termen,Arr,MaxAritate),
				AritateMaxima is max(Arr, MaxAritate), !.
parcurgeArgMax(_,0,0) :- !.
parcurgeArgMax(Termen,N,MaxAritate) :- arg(N,Termen,Arg),maxar(Arg,Arr),
				P is N-1, parcurgeArgMax(Termen,P,Arr2), MaxAritate is max(Arr,Arr2).

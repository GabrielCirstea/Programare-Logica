/* listacf(N,Lcf)=true <=> N e un numar natural, iar Lcf e lista cifrelor
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

/* Daca L e o lista de cifre, atunci:
nrcucf(L,N)=true <=> N e numarul natural cu proprietatea ca Lcf e lista
cifrelor lui N ordonate de la cifra unitatilor la cifra cea mai semnificativa;
nrcucford(L,N)=true <=> N e numarul natural cu proprietatea ca Lcf
e lista cifrelor lui N in ordinea in care apar in N. */

nrcucf([Cifra],Cifra).
nrcucf([CifraUnitatilor,CifraZecilor|T],N) :- nrcucf([CifraZecilor|T],M),
					      N is M*10+CifraUnitatilor.

nrcucford(Lcf,N) :- inversa(Lcf,L), nrcucf(L,N).

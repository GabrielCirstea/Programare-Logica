% primeste un numar natural Numar si construieste in ListaNrPrime 
% lista numerelor naturale prime mai mici sau egale cu Numar
ciur(Numar,ListaNrPrime):- genlistanr(Numar,L), ciuruieste(L,ListaNrPrime).    
    
% primeste un numar natural Numar si construieste in ListaNr 
% lista numerelor naturale mai mari sau egale cu 2 si mai mici sau egale cu Numar
% descrescator
genlistanrdesc(2,[2]).
genlistanrdesc(Nr,[H|T]) :- H is Nr,N is Nr-1, genlistanrdesc(N,T).

% crescator
genlistanr(Nr,L):- genlistanrdesc(Nr,LR), rev(LR,L,[]).

% inverseaza o lista
rev([],X,X).
rev([H|T],X,A) :- rev(T,X,[H|A]).

ciuruieste([],[]).
ciuruieste([Nr|Lista],[Nr|C]):- filtreaza(Nr,Lista,LF), ciuruieste(LF,C).

% obtine in ListaFiltrata lista obtinuta prin eliminarea multiplilor lui Nr din Lista   
filtreaza(_,[],[]).
filtreaza(Nr,[H|T],LF):- M is mod(H,Nr), M=0, filtreaza(Nr,T,LF).
filtreaza(Nr,[H|T],[H|LF]):- M is mod(H,Nr), M\=0, filtreaza(Nr,T,LF).

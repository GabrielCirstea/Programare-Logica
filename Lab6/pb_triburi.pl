membru(H,[H|_]).
membru(X,[_|T]) :- membru(X,T).

/* Un predicat predefinit care functioneaza la fel ca predicatul membru de mai sus: membru.
A se vedea si predicatele predefinite length si append, care functioneaza la fel ca 
predicatele lung, respectiv concat din lectiile anterioare de laborator. */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O solutie pentru problema cu triburile din Seminarul II cu valorile booleene {false,true}
% (implementare care functioneaza numai in Prologul desktop):

implica(V,W) :- not(V);W.

echivalent(V,W) :- implica(V,W), implica(W,V).

enuntalfa(B,C) :- echivalent((B,C), C).

enuntbeta(A,B,C) :- implica((A,C), not(implica((B,C), A))).

enuntgamma(A,B) :- echivalent(not(B), (A;B)). 

enuntaeqalfa(A,B,C) :- echivalent(A, enuntalfa(B,C)).

enuntbeqbeta(A,B,C) :- echivalent(B, enuntbeta(A,B,C)).

enuntceqgamma(A,B,C) :- echivalent(C, enuntgamma(A,B)).

triplet_solutie(A,B,C) :- membru(A,[false,true]), membru(B,[false,true]), membru(C,[false,true]),
			  enuntaeqalfa(A,B,C), enuntbeqbeta(A,B,C), enuntceqgamma(A,B,C).

triplet_nonsolutie(A,B,C) :- membru(A,[false,true]), membru(B,[false,true]), membru(C,[false,true]),
			     not((enuntaeqalfa(A,B,C), enuntbeqbeta(A,B,C), enuntceqgamma(A,B,C))).

/* Daca nu incadram conjunctia care da argumentul lui "not" intr-o pereche de paranteze suplimentara,
Prologul ar fi interpretat scrierea respectiva ca fiind 3 argumente furnizate predicatului "not". */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% O solutie pentru problema cu triburile din Seminarul II cu {0,1} ca valori booleene:

neg(V,N) :- N is 1-V.

conj(V,W,C) :- C is V*W.

disj(V,W,D) :- D is V+W-V*W.

implic(V,W,1) :- V=<W.
implic(1,0,0).

echiv(V,V,1).
echiv(V,W,0) :- V=\=W.

/* Varianta:
implic(V,W,I) :- neg(V,N), disj(N,W,I).

echiv(V,W,E) :- implic(V,W,I), implic(W,V,J), conj(I,J,E). */

alfa(B,C,Alfa) :- conj(B,C,Conj), echiv(Conj,C,Alfa).

beta(A,B,C,Beta) :- conj(A,C,ConjAC), conj(B,C,ConjBC), implic(ConjBC,A,Implic), neg(Implic,Neg),
		    implic(ConjAC,Neg,Beta).

gamma(A,B,Gamma) :- neg(B,Neg), disj(A,B,Disj), echiv(Neg,Disj,Gamma).

echivA(A,B,C) :- alfa(B,C,Alfa), echiv(Alfa,A,1).

echivB(A,B,C) :- beta(A,B,C,Beta), echiv(Beta,B,1).

echivC(A,B,C) :- gamma(A,B,Gamma), echiv(Gamma,C,1).

solutie(A,B,C) :- membru(A,[0,1]), membru(B,[0,1]), membru(C,[0,1]),
		  echivA(A,B,C), echivB(A,B,C), echivC(A,B,C).

nonsolutie(A,B,C) :- membru(A,[0,1]), membru(B,[0,1]), membru(C,[0,1]),
		     not((echivA(A,B,C), echivB(A,B,C), echivC(A,B,C))).


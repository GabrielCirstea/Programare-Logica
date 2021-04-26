move(1,X,Y,_,[[X,Y]]) :- write('Muta inelul de pe '), write(X), write(' pe '), write(Y), nl.

%In L obtinem lista mutarilor - lista de liste de lungime 2 de forma [stiva de pe care pleaca, stiva pe care ajunge]
%?- nth0(1,L,x,[1,2,3]).
%L = [1, x, 2, 3].
move(N,X,Y,Z,L) :- N>1, M is N-1, move(M,X,Z,Y,L1), move(1,X,Y,_,L2), move(M,Z,Y,X,L3),append(L1,L2,L4),append(L4,L3,L).

afiseaza([[H1|H2]|T],[HA|TA],Lb,Lc,N):-  H1=a, H2=[b], 
    aducelungN([HA|TA],N,A1),aducelungN(Lb,N,B1), aducelungN(Lc,N,C1),
    ultpunct(A1,A2),ultpunct(B1,B2),ultpunct(C1,C2),
    printcol(A2,B2,C2),nl, nth0(0,Lb1,HA,Lb), sleep(1), afiseaza(T,TA,Lb1,Lc,N).

afiseaza([[H1|H2]|T],[HA|TA],Lb,Lc,N):-  H1=a, H2=[c],  
    aducelungN([HA|TA],N,A1),aducelungN(Lb,N,B1), aducelungN(Lc,N,C1),
    ultpunct(A1,A2),ultpunct(B1,B2),ultpunct(C1,C2),
    printcol(A2,B2,C2),nl,nth0(0,Lc1,HA,Lc), sleep(1),afiseaza(T,TA,Lb,Lc1,N).

afiseaza([[H1|H2]|T],La,[HB|TB],Lc,N):-  H1=b, H2=[a], 
    aducelungN(La,N,A1), aducelungN([HB|TB],N,B1), aducelungN(Lc,N,C1),
    ultpunct(A1,A2),ultpunct(B1,B2),ultpunct(C1,C2),
    printcol(A2,B2,C2),nl,nth0(0,La1,HB,La), sleep(1),afiseaza(T,La1,TB,Lc,N).

afiseaza([[H1|H2]|T],La,[HB|TB],Lc,N):-  H1=b, H2=[c],  
    aducelungN(La,N,A1), aducelungN([HB|TB],N,B1), aducelungN(Lc,N,C1),
    ultpunct(A1,A2),ultpunct(B1,B2),ultpunct(C1,C2),
    printcol(A2,B2,C2),nl,nth0(0,Lc1,HB,Lc), sleep(1),afiseaza(T,La,TB,Lc1,N).

afiseaza([[H1|H2]|T],La,Lb,[HC|TC],N):-  H1=c, H2=[a],  
    aducelungN(La,N,A1),aducelungN(Lb,N,B1), aducelungN([HC|TC],N,C1), 
    ultpunct(A1,A2),ultpunct(B1,B2),ultpunct(C1,C2),
    printcol(A2,B2,C2),nl,nth0(0,La1,HC,La),sleep(1), afiseaza(T,La1,Lb,TC,N).

afiseaza([[H1|H2]|T],La,Lb,[HC|TC],N):-  H1=c, H2=[b], 
    aducelungN(La,N,A1), aducelungN(Lb,N,B1), aducelungN([HC|TC],N,C1),
    ultpunct(A1,A2),ultpunct(B1,B2),ultpunct(C1,C2),
    printcol(A2,B2,C2),nl,nth0(0,Lb1,HC,Lb),sleep(1), afiseaza(T,La,Lb1,TC,N).

afiseaza([],La,Lb,Lc,N):- aducelungN(La,N,A1), aducelungN(Lb,N,B1), aducelungN(Lc,N,C1),
    ultpunct(A1,A2),ultpunct(B1,B2),ultpunct(C1,C2),
    printcol(A2,B2,C2).

%Primeste o lista si o aduce lista la lungime N, adaugand in fata ' '
%de exemplu L=[1,2] N=3 -> [' ', 1, 2]

aducelungN(L,N,L):- length(L,N).
aducelungN(L,N,LL):- length(L,M), M < N, append([' '],L,L1), aducelungN(L1,N,LL).

%Daca ultima pozitie dintr-o lista e ' ' o schimba cu '.'
ultpunct(L,L) :- ultelem(X,L), X \= ' '.
ultpunct(L,LL) :- ultelem(X,L), X = ' ', length(L,N), M is N-1, inlocindex(M,L,'.',LL).
    
%Ultimul element dintr-o lista    
ultelem(X,[X]).
ultelem(X, [_|L]) :-ultelem(X, L).    

%Inlocuieste un element intr-o lista de la un anumit index
inlocindex(I, L, E, LR) :- nth0(I, L, _, R), nth0(I, LR, E, R).

%Printeaza 3 liste de aceeasi lungime ca trei coloane 
printcol([],[],[]).
printcol([HA|TA],[HB|TB],[HC|TC]) :-  write(HA),write(' '), write(HB),write(' '), write(HC),nl,printcol(TA,TB,TC).

%de la EX2
%primeste un numar natural Numar si construieste in ListaNr 
%lista numerelor naturale mai mari sau egale cu 2 si mai mici sau egale cu Numar
%descrescator
genlistanrdesc(1,[1]).
genlistanrdesc(Nr,[H|T]) :- H is Nr,N is Nr-1, genlistanrdesc(N,T).

%crescator
genlistanr(Nr,L):- genlistanrdesc(Nr,LR), rev(LR,L,[]).

%inverseaza o lista
rev([],X,X).
rev([H|T],X,A) :- rev(T,X,[H|A]).


hanoi(N) :- move(N,a,b,c,L), genlistanr(N,L1), afiseaza(L,L1,[],[],N). 

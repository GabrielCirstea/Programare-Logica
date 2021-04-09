% lex(L,M) -> L este mai mica sau egala decat M in ordine lexicografica
% L,M liste de numere 
%
% lex([],[]).
% lex([],[H|T]):- integer(H), lex([],T).


lex([],[]).
lex([],H):- verint(H).
lex([H|T],[H1|T1]):-  integer(H), integer(H1), H =< H1, lex(T,T1).

% verifica ca lista e o lista de numere
verint([H|[]]):- integer(H).
verint([H|T]):- integer(H), verint(T).


% lexterm(L,M) -> L este mai mica sau egala decat M in ordine lexicografica
% L,M liste de termeni
lexterm([],_).
lexterm([H|T],[H1|T1]):- H @=< H1, lexterm(T,T1).

% facem predicatele sa poata fi folosite si in forma infixata
:- op(500, xfx, [lex, lexterm]).

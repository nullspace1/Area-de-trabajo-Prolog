triada((X,Y,Z)):-
    between(1,9,X),
    between(1,9,Y),
    between(1,9,Z).

triadaUniforme((X,Y,Z)):-
    triada((X,Y,Z)),
    X==Y,
    Y==Z,
    X==Z.

simbolo(s).
simbolo(r).
simbolo(m).
simbolo(d).

simbolos((X,Y)):-
    simbolo(X),
    simbolo(Y).

operacion(X,Y,s,R):-
R is X+Y.

operacion(X,Y,r,R):-
    R is X-Y.

operacion(X,Y,m,R):-
    R is X*Y.

operacion(X,Y,d,R):-
    R is X/Y.

asocia((X,Y,Z),(A,B),Resultado):-
    triadaUniforme((X,Y,Z)),
    simbolos((A,B)),
    operacion(X,Y,A,Res),
    operacion(Res,Z,B,Resultado).

numeroUqbariano(Numero):-
    between(1,1000,Numero),
    forall(triadaUniforme(T),asocia(T,_,Numero)).
    
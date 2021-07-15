conjunto(x,[1,0]).

esFuncion(X,Funcion):-
    conjunto(X,Elementos),
    length(Elementos,Len),
    LenCompatible is Len^2,
    length(Funcion,LenCompatible),
    todosPosiblesElementos(Funcion,Elementos),
    not(hayRepes(Funcion)).   

esGrupo(X,Funcion):-
    esFuncion(X,Funcion),
    not(noAsocia(Funcion)),
    hayidentidad(Funcion),
    inversos(Funcion,X).

operacion(Funcion,X,Y,Z):-
    esFuncion(_,Funcion).
    member((X,Y,Z),Funcion).

inversos(Funcion,X):-
    conjunto(X,Cjto),
    forall(member(T,Cjto),inverso(Funcion,T,_)).

inverso(Funcion,T,X):-
    identidad(E,Funcion),
    operacion(Funcion,T,X,E),
    operacion(Funcion,X,T,E).

hayIdentidad(Funcion):-
    identidad(Elem,Funcion).

identidad(Elem,Funcion):-
    forall(member((Z,Elem,Resultado),Funcion),Resultado==Z),
    forall(member((Elem,_,Resultado),Funcion),Resultado == Z).


    

noRepiteElementos([X|Demas]):-
    not(member(X,Demas)),
    noRepiteElementos(Demas).

noRepiteElementos([]).

hayRepes(Funcion):-
    member((X,Y,Z),Funcion),
    member((X,Y,T),Funcion),
    Z \= T.


todosPosiblesElementos([X|Demas],Conjunto):-
    esPosibleElemento(Conjunto,X),
    todosPosiblesElementos(Demas,Conjunto),
    not(member(X,Demas)).

todosPosiblesElementos([],_).


esPosibleElemento(Cjto,(A,B,C)):-
    member(A,Cjto),
    member(B,Cjto),
    member(C,Cjto).
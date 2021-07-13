conjunto(x,[1,0]).

esFuncion(X,Funcion):-
    conjunto(X,Elementos),
    length(Elementos,Len),
    LenCompatible is Len^2,
    length(Funcion,LenCompatible),
    todosPosiblesElementos(Funcion,Elementos),
    not(hayRepes(Funcion)).   

esGrupo(X,Funcion):-
    

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
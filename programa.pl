cjto(x,[uno,cero]).

esMiembro(Elemento,Conjunto):-
    cjto(Conjunto,Set),
    member(Elemento,Set).

operacion(f,uno,uno,cero).
operacion(f,uno,cero,uno).
operacion(f,cero,cero,cero).
operacion(f,cero,uno,uno).

esGrupo(Conjunto,Operacion):-
    operacionCerrada(Conjunto,Operacion),
    hayIdentidad(Conjunto,Operacion),
    asocia(Conjunto,Operacion),
    hayInversos(Conjunto,Operacion).

operacionCerrada(Conjunto,Operacion):-
not(noCierra(Conjunto,Operacion)).

noCierra(Conjunto,Operacion):-
    esMiembro(Elemento,Conjunto),
    esMiembro(OtroElemento,Conjunto),
    operacion(Operacion,Elemento,OtroElemento,Resultado),
    not(esMiembro(Resultado,Conjunto)).

hayIdentidad(Conjunto,Operacion):-
    esMiembro(Identidad,Conjunto),
    esIdentidad(Identidad,Conjunto,Operacion).

esIdentidad(Identidad,Conjunto,Operacion):-
    esMiembro(Identidad,Conjunto),
    forall(esMiembro(Elemento,Conjunto),operacion(Operacion,Identidad,Elemento,Elemento)),
    forall(esMiembro(Elemento,Conjunto),operacion(Operacion,Elemento,Identidad,Elemento)).

asocia(Conjunto,Operacion):-
    not(noAsocia(Conjunto,Operacion)).

noAsocia(Conjunto,Operacion):-
    esMiembro(X,Conjunto),
    esMiembro(Y,Conjunto),
    esMiembro(Z,Conjunto),
    operacion(Operacion,X,Y,ResultadoXY),
    operacion(Operacion,ResultadoXY,Z,ResultadoXYyZ),
    operacion(Operacion,Y,Z,ResultadoYZ),
    operacion(Operacion,X,ResultadoYZ,ResultadoXyYZ),
    ResultadoXYyZ \= ResultadoXyYZ.

hayInversos(Conjunto,Operacion):-
    forall(esMiembro(X,Conjunto),tieneInverso(X,Operacion,Conjunto)).

tieneInverso(X,Operacion,Conjunto):-
    esMiembro(Inverso,Conjunto),
    esIdentidad(Identidad,Conjunto,Operacion),
    operacion(Operacion,X,Inverso,Identidad),
    operacion(Operacion,Inverso,X,Identidad).






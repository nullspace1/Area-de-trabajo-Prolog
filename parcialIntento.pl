herramienta(ana, circulo(50,3)).

herramienta(ana, cuchara(40)).

herramienta(beto, circulo(20,1)).

herramienta(beto, libro(inerte)).

herramienta(cata, libro(vida)).

herramienta(cata, circulo(100,5)).


%% Parte 1

tiene(ana,[agua, vapor, tierra, hierro]).
tiene(beto,[agua, vapor, tierra, hierro]).
tiene(cata,[fuego,tierra,agua,aire]).

haceFaltaPara(pasto,[agua, tierra]).
haceFaltaPara(hierro,[fuego, agua, tierra]).
haceFaltaPara(huesos,[pasto,agua]).
haceFaltaPara(presion,[hierro,vapor]).
haceFaltaPara(plastico,[huesos, presion]).
haceFaltaPara(silicio,[tierra]).
haceFaltaPara(playStation,[silicio,hierro,plastico]).
haceFaltaPara(vapor,[agua,fuego]).

esElemental(Elemento):-
    haceFaltaPara(_,Cjto),
    member(Elemento, Cjto),
    not(haceFaltaPara(Elemento,_)).

esElemental(Elemento):-
    tiene(_,Cjto),
    member(Elemento,Cjto),
    not(haceFaltaPara(Elemento,_)).

esElemento(Elem):-
    haceFaltaPara(Elem,_).


esElemento(Elem):-
    esElemental(Elem).

jugador(Jugador):-
    tiene(Jugador,_).    


tieneIngredientesPara(Jugador,Elemento):-
    tiene(Jugador,CosasQueTiene),
    esElemento(Elemento),
    haceFaltaPara(Elemento,CosasQueFaltan),
    forall(member(Y,CosasQueFaltan),member(Y,CosasQueTiene)).

estaVivo(fuego).
estaVivo(agua).
estaVivo(Elemento):-
    haceFaltaPara(Elemento,Cjto),
    member(X,Cjto),
    estaVivo(X).

puedeConstruir(Jugador,Elemento):-
    tieneIngredientesPara(Jugador,Elemento),
    herramienta(Jugador,Herramienta),
    messirve(Herramienta,Elemento).


messirve(libro(vida),Elemento):-
    estaVivo(Elemento).

messirve(libro(inerte),Elemento):-
    esElemento(Elemento),
    not(estaVivo(Elemento)).

messirve(cuchara(_),Elemento):-
    esElemental(Elemento).

messirve(cuchara(Long),Elemento):-
    haceFaltaPara(Elemento,CosasQueFaltan),
    Capacidad is Long/10, 
   length(CosasQueFaltan,Longitud),
   Longitud < Capacidad.

messirve(circulo(Diametro,Nivel),Elemento):-
    haceFaltaPara(Elemento,CosasQueFaltan),
    Capacidad is (Diametro/100)*Nivel,
    length(CosasQueFaltan,Longitud),
    Longitud < Capacidad.

todoPoderoso(Jugador):-
    jugador(Jugador),
    tiene(Jugador,Elementos),
    forall(esElemental(X),member(X,Elementos)),
    herramienta(Jugador,Herramienta),
    forall(haceFaltaPara(X,_),messirve(Herramienta,X)).

quienGana(Jugador):-
    jugador(Jugador),
    forall(jugador(OtroJugador),construyeMenosOIgual(OtroJugador,Jugador)).

construyeMenosOIgual(Menos,Mas):-
    jugador(Menos),
    jugador(Mas),
    findall(CosasMas,puedeConstruir(Mas,CosasMas),ListaMas),
    findall(CosasMenos,puedeConstruir(Menos,CosasMenos),ListaMenos),
    length(ListaMas,LongitudMas),
    length(ListaMenos,LongitudMenos),
    LongitudMas >= LongitudMenos.  

puedeLlegarATener(Jugador,Elemento):-
    jugador(Jugador),
    puedeConstruir(Jugador,Elemento).

puedeLlegarATener(Jugador,Elemento):-
    jugador(Jugador),
    haceFaltaPara(Elemento,X),
    forall(member(Z,X),loTieneOPuedeLlegarATener(Jugador,Z)).

loTieneOPuedeLlegarATener(Jugador,Elemento):-
    esElemental(Elemento),
    tiene(Jugador,Lista),
    member(Elemento,Lista).

loTieneOPuedeLlegarATener(Jugador,Elemento):-
    puedeLlegarATener(Jugador,Elemento).


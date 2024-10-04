:- dynamic(riesgo/2).
:- dynamic(inversion/4).
:- dynamic(riesgo_usuario/2).
:- dynamic(caracteristicasDeseadasUsuario/1).
:- dynamic(caracteristicasNoDeseadasUsuario/1).

% Inicia el programa
inicio:-cargarConocimiento, preguntar_riesgo.

% 1) Carga las bases de conocimiento en memoria
cargarConocimiento :-
	retractall(riesgo(_,_)),
    retractall(inversion(_,_,_,_)),
	retractall(riesgo_usuario(_,_)), 
    retractall(caracteristicasDeseadasUsuario(_)), 
    retractall(caracteristicasNoDeseadasUsuario(_)),
	consult("bd_riesgos.pl"),
    consult("bd_inversiones.pl")
.

% Loopea el input hasta que el usuario ingrese un riesgo valido
preguntar_riesgo:- 
riesgo(RiesgoID,Medida), 
write('Estas dispuesto a asumir un riesgo '), write(Medida), write(' en tu inversion? [s/n]: '),
 read(Decision), 
 validar_decision(RiesgoID,Medida,Decision), 
 preguntar_riesgo
.

% Cuando no queden riesgos por validar, se fija si el usuario tiene algun riesgo asignado, si es asi, continua 
preguntar_riesgo:- 
    riesgo_usuario(_,_),
    writeln('Ok! Ahora sabiendo el riesgo que estas dispuesto a asumir, continuemos con otras preguntas.'), nl,
    mostrar_menu_caracteristicas_deseadas
.

% Cuando no queden riesgos por validar, y el usuario no tiene ningun riesgo asignado, se le informa que no se puede continuar
preguntar_riesgo:- not(riesgo_usuario(_,_)), writeln('Lamento no poder ayudarte, todas las inversiones disponibles implican un minimo de riesgo.').

% Valida la decision del usuario, si es 's' se asume que esta dispuesto a asumir el riesgo y se elimina el riesgo de memoria
validar_decision(RiesgoID,Medida,Decision):-
    Decision='s', 
    retract(riesgo(RiesgoID,_)), 
    assert(riesgo_usuario(RiesgoID,Medida))
.

% Valida la decision del usuario, si es 'n' se asume que no esta dispuesto a asumir el riesgo y se elimina el riesgo y las inversiones asociadas al mismo
validar_decision(RiesgoID,_,Decision):- 
    Decision='n', 
    retract(riesgo(RiesgoID,_)), 
    retractall(inversion(_,RiesgoID,_,_))
.

% Clausula de fin de preguntar_riesgo
validar_decision(_,_,_).

% Menu para elegir características deseadas
mostrar_menu_caracteristicas_deseadas :-
    writeln("Selecciona las características deseadas (ingresa el número):"),
    writeln("1. Alta liquidez"),
    writeln("2. Bajo riesgo"),
    writeln("3. Largo plazo"),
    writeln("4. Medio plazo"),
    writeln("5. Corto plazo"),
    writeln("6. Commodities"),
    writeln("7. Renta fija"),
    writeln("8. Renta variable"),
    writeln("0. Finalizar selección"),
    leer_caracteristicas_deseadas
.

% Leer las características deseadas desde el menú
leer_caracteristicas_deseadas :-
    write("Ingresa tu opción: "),
    read(Opcion),
    procesar_opcion_deseada(Opcion).

% Procesar la opción ingresada
procesar_opcion_deseada(1) :- assert(caracteristicasDeseadasUsuario('alta liquidez')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(2) :- assert(caracteristicasDeseadasUsuario('bajo riesgo')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(3) :- assert(caracteristicasDeseadasUsuario('largo plazo')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(4) :- assert(caracteristicasDeseadasUsuario('medio plazo')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(5) :- assert(caracteristicasDeseadasUsuario('corto plazo')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(6) :- assert(caracteristicasDeseadasUsuario('commodities')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(7) :- assert(caracteristicasDeseadasUsuario('renta fija')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(8) :- assert(caracteristicasDeseadasUsuario('renta variable')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(0) :- mostrar_menu_caracteristicas_no_deseadas, !.
procesar_opcion_deseada(_) :- writeln("Opción no válida, intenta de nuevo."), leer_caracteristicas_deseadas.

% Menu para elegir características no deseadas
mostrar_menu_caracteristicas_no_deseadas :-
    writeln("Selecciona las características NO deseadas (ingresa el número):"),
    writeln("1. Alta liquidez"),
    writeln("2. Bajo riesgo"),
    writeln("3. Largo plazo"),
    writeln("4. Medio plazo"),
    writeln("5. Corto plazo"),
    writeln("6. Commodities"),
    writeln("7. Renta fija"),
    writeln("8. Renta variable"),
    writeln("0. Finalizar selección"),
    leer_caracteristicas_no_deseadas
.

% Leer las características no deseadas desde el menú
leer_caracteristicas_no_deseadas :-
    write("Ingresa tu opción: "),
    read(Opcion),
    procesar_opcion_no_deseada(Opcion).

% Procesar la opción ingresada
procesar_opcion_no_deseada(1) :- assert(caracteristicasNoDeseadasUsuario('alta liquidez')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(2) :- assert(caracteristicasNoDeseadasUsuario('bajo riesgo')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(3) :- assert(caracteristicasNoDeseadasUsuario('largo plazo')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(4) :- assert(caracteristicasNoDeseadasUsuario('medio plazo')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(5) :- assert(caracteristicasNoDeseadasUsuario('corto plazo')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(6) :- assert(caracteristicasNoDeseadasUsuario('commodities')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(7) :- assert(caracteristicasNoDeseadasUsuario('renta fija')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(8) :- assert(caracteristicasNoDeseadasUsuario('renta variable')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(0) :- mostrar_resumen_caracteristicas, !.
procesar_opcion_no_deseada(_) :- writeln("Opción no válida, intenta de nuevo."), leer_caracteristicas_no_deseadas.

% Mostrar resumen de las características ingresadas
mostrar_resumen_caracteristicas :-
    writeln("Tus características deseadas son: "),
    listar_caracteristicas_deseadas,
    writeln("Tus características NO deseadas son: "),
    listar_caracteristicas_no_deseadas,
    preguntar_presupuesto.

% Listar características deseadas
listar_caracteristicas_deseadas :-
    findall(Caracteristica, caracteristicasDeseadasUsuario(Caracteristica), Lista),
    listar(Lista).

% Listar características no deseadas
listar_caracteristicas_no_deseadas :-
    findall(Caracteristica, caracteristicasNoDeseadasUsuario(Caracteristica), Lista),
    listar(Lista).

% Función auxiliar para listar elementos
listar([]).
listar([H|T]) :-
    write("- "), writeln(H),
    listar(T).

% 4) Pregunta al usuario cuanto esta dispuesto a invertir, busca las inversiones en base al monto y el riesgo, y las muestra
preguntar_presupuesto:-
    write("Cuanto estas dispuesto a invertir? (monto en USD): "),
    read(Monto), nl,
    recomendar_inversion(Monto)
.

% Busca las inversiones recomendables en base al riesgo y presupuesto
recomendar_inversion(Presupuesto):-
    Presupuesto > 0,
    findall([Inversion, Caracteristicas], 
            (recomendable([Inversion, Caracteristicas], Presupuesto)), 
            ListaRecomendable),
    findall([Inversion, Caracteristicas], 
            (recomendable([Inversion, Caracteristicas], Presupuesto), caracteristicas_compatibles(Caracteristicas)), 
            Lista),
    resultado_final(Lista)
.

% Si el presupuesto ingresado no es valido, se lo informa y vuelve a preguntar
recomendar_inversion(_):-writeln("Por favor, ingrese un monto valido"), nl, preguntar_presupuesto.

% Funcion que evalua si una inversion es recomendable en base al riesgo y el presupuesto
recomendable([NombreInversion, Caracteristicas], Presupuesto):-
    riesgo_usuario(Riesgo, _),
    inversion(NombreInversion, Riesgo, MinimoAInvertir, Caracteristicas), 
    MinimoAInvertir =< Presupuesto
.

% Evalúa si las características de la inversión son compatibles con las preferencias del usuario
caracteristicas_compatibles(Caracteristicas):-
    findall(Deseada, caracteristicasDeseadasUsuario(Deseada), ListaDeseadas),
    intersection(Caracteristicas, ListaDeseadas, Coincidencias),
    Coincidencias \= [],
    findall(NoDeseada, caracteristicasNoDeseadasUsuario(NoDeseada), ListaNoDeseadas),
    intersection(Caracteristicas, ListaNoDeseadas, []).

% Si se encuentran inversiones recomendadas, se informa y se listan
resultado_final(Lista):-
    writeln("Te recomiendo alguna de las siguientes inversiones: "),
    listar_recomendaciones(Lista),
    writeln("Espero que mi asesoramiento te haya sido util")
.

% Si no se encuentran inversiones recomendadas, lo informa
resultado_final([]):-writeln("Perdon, no encontre inversiones para vos"), nl.

% Lista las inversiones recomendadas
listar_recomendaciones([[H1, H2] | T]):-
	write("- "), writeln(H1),
    write("Caracteristicas: "), writeln(H2), nl,
    listar_recomendaciones(T)
.

% Clausula de fin de preguntar_presupuesto
listar_recomendaciones([]).

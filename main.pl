:- dynamic(riesgo/2).
:- dynamic(inversion/4).
:- dynamic(riesgo_usuario/2).

% No implementado todavia
% :- dynamic(caracteristicasDeseadasUsuario/1).
% :- dynamic(caracteristicasNoDeseadasUsuario/1).

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
    preguntar_presupuesto
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


% 2) Pregunta al usuario cuanto esta dispuesto a invertir, busca las inversiones en base al monto y el riesgo, y las muestra
preguntar_presupuesto:-
    write("Cuanto estas dispuesto a invertir? (monto en USD): "),
    read(Monto), nl,
    recomendar_inversion(Monto)
.

% Busca las inversiones recomendables en base a los riesgos cargados anteriormente y el presupuesto ingresado
recomendar_inversion(Presupuesto):-
    Presupuesto > 0,
    findall([Inversion, Caracteristicas], recomendable([Inversion, Caracteristicas], Presupuesto), Lista),
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
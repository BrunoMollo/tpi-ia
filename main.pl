:- dynamic(riesgo/2).
:- dynamic(inversiones/4).
:- dynamic(riesgoUsuario/2).
:- dynamic(caracteristicasDeseadasUsuario/1).
:- dynamic(caracteristicasNoDeseadasUsuario/1).


clearScreen :-
	write('\e[H\e[2J').

cargarConocimiento :-
	retractall(riesgo(_,_)),retractall(inversiones(_,_,_)),
	retractall(riesgo_usuario(_,_)), retractall(caracteristicasDeseadasUsuario(_)), retractall(caracteristicasNoDeseadasUsuario(_)),
	consult('./bd_riesgos.pl'),consult('./bd_inversiones.pl').



validar_riesgo:- riesgo(RiesgoID,Medida), write('Estas dispuesto a asumir un riesgo '), write(Medida), write(' en tu inverison? [s/n]: '),
 read(Decision), validar_decision(RiesgoID,Medida,Decision), validar_riesgo.

validar_riesgo:- riesgo_usuario(_,_), writeln('Ok! Ahora que se el riesgo que estas dispuesto a asumir, continuemos con otras preguntas.').

validar_riesgo:- not(riesgo_usuario(_,_)), writeln('Lamento no poder ayudarte, todas las inversiones disponibles implican un minimo de riesgo.').

validar_decision(RiesgoID,Medida,Decision):-Decision='s', retract(riesgo(RiesgoID,_)), assert(riesgo_usuario(RiesgoID,Medida)).

validar_decision(RiesgoID,_,Decision):- Decision='n', retract(riesgo(RiesgoID,_)), retractall(inversiones(_,RiesgoID,_)).

validar_decision(_,_,_).


preguntar_monto(Decision) :-
    writeln("Cuanto estas dispuesto a invertir? (monto en dolares)"),
    read(Decision)
.

puede_invertir(Inversion, Monto_disponible):- 
  inversion_minima(Inversion, Monto_requerido),
  Monto_disponible>= Monto_requerido
.

recomendable(Inversion, Riesgo, Monto):- 
    riesgo(Inversion, Riesgo),
    puede_invertir(Inversion, Monto) 
.

recomendar_inversion(Riesgo, Monto):-
    findall(Inversion, recomendable(Inversion, Riesgo, Monto), Lista),
    resultado_final(Lista)
.

resultado_final([]):-writeln("Perdon, no encontre inversiones para vos"), nl.

resultado_final(Lista):-
    writeln("Te recomendamos las siguientes inversiones: "),
    listar_recomendaciones(Lista),
    writeln("Espero que este asesoramiento te haya sido util")
.


listar_recomendaciones([H | T]):-
	write("- "),writeln(H),
    listar_recomendaciones(T)
.

listar_recomendaciones([]).



recomendame:-cargarConocimiento,validar_riesgo.

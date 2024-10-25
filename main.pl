:- dynamic(riesgo/2).
:- dynamic(inversion/4).
:- dynamic(riesgo_usuario/2).
:- dynamic(caracteristicasDeseadasUsuario/1).
:- dynamic(caracteristicasNoDeseadasUsuario/1).
:- dynamic(meta_financiera/1).
:- dynamic(ingresos_usuario/1).
:- dynamic(tiene_deudas/0).
:- dynamic(riesgo_tolerancia/1).

% Inicia el programa
inicio :- 
    cargarConocimiento, 
    mostrar_menu_metas_financieras, 
    preguntar_situacion_economica,
    cuestionario_riesgo,
    mostrar_menu_caracteristicas_deseadas.

% Carga las bases de conocimiento en memoria
cargarConocimiento :-
	retractall(riesgo(_,_)),
    retractall(inversion(_,_,_,_)),
	retractall(riesgo_usuario(_,_)), 
    retractall(caracteristicasDeseadasUsuario(_)), 
    retractall(caracteristicasNoDeseadasUsuario(_)),
    retractall(meta_financiera(_)),
    retractall(ingresos_usuario(_)),
    retractall(tiene_deudas),
    retractall(riesgo_tolerancia(_)),
	consult("bd_riesgos.pl"),
    consult("bd_inversiones.pl")
.

% Pregunta sobre metas financieras
mostrar_menu_metas_financieras :-
    writeln("Selecciona tu meta financiera principal:"),
    writeln("1. Ahorrar para un proyecto personal"),
    writeln("2. Ahorrar para un viaje"),
    writeln("3. Crear un fondo de emergencia"),
    writeln("4. Comprar una propiedad"),
    writeln("5. Ahorrar para la jubilación"),
    writeln("0. Omitir"),
    leer_meta_financiera
.

leer_meta_financiera :-
    write("Ingresa tu opción: "),
    read(Opcion),
    procesar_opcion_meta(Opcion).

procesar_opcion_meta(1) :- assert(meta_financiera('ahorrar para un proyecto personal')), writeln("Meta guardada: Ahorrar para un proyecto personal"), !.
procesar_opcion_meta(2) :- assert(meta_financiera('ahorrar para un viaje')), writeln("Meta guardada: Ahorrar para un viaje"), !.
procesar_opcion_meta(3) :- assert(meta_financiera('crear un fondo de emergencia')), writeln("Meta guardada: Crear un fondo de emergencia"), !.
procesar_opcion_meta(4) :- assert(meta_financiera('comprar una propiedad')), writeln("Meta guardada: Comprar una propiedad"), !.
procesar_opcion_meta(5) :- assert(meta_financiera('ahorrar para la jubilación')), writeln("Meta guardada: Ahorrar para la jubilación"), !.
procesar_opcion_meta(0) :- writeln("Opción omitida."), !.
procesar_opcion_meta(_) :- writeln("Opción no válida, intenta de nuevo."), leer_meta_financiera.

% Pregunta sobre situación económica
preguntar_situacion_economica :-
    write("¿Cuáles son tus ingresos mensuales aproximados en USD? "),
    read(Ingresos), nl,
    assert(ingresos_usuario(Ingresos)),
    write("¿Tienes deudas? (s/n): "),
    read(Deudas),
    procesar_deudas(Deudas).

procesar_deudas('s') :- assert(tiene_deudas), writeln("Deuda registrada."), !.
procesar_deudas('n') :- writeln("No tienes deudas."), !.
procesar_deudas(_) :- writeln("Opción no válida, intenta de nuevo."), preguntar_situacion_economica.

% Cuestionario de tolerancia al riesgo
cuestionario_riesgo :-
    writeln("¿Cómo te sentirías si tu inversión pierde un 10% en un año?"),
    writeln("1. Me preocuparía mucho y vendería"),
    writeln("2. Me sentiría incómodo pero no vendería"),
    writeln("3. No me preocuparía"),
    read(Respuesta),
    procesar_riesgo_avanzado(Respuesta).

procesar_riesgo_avanzado(1) :- assert(riesgo_usuario(1, 'bajo')), writeln("Tolerancia al riesgo: Bajo"), !.
procesar_riesgo_avanzado(2) :- assert(riesgo_usuario(2, 'medio')), writeln("Tolerancia al riesgo: Medio"), !.
procesar_riesgo_avanzado(3) :- assert(riesgo_usuario(3, 'alto')), writeln("Tolerancia al riesgo: Alto"), !.
procesar_riesgo_avanzado(_) :- writeln("Opción no válida, intenta de nuevo."), cuestionario_riesgo.

% Menú para características deseadas
mostrar_menu_caracteristicas_deseadas :-
    writeln("Selecciona las características deseadas (ingresa el número):"),
    writeln("1. Alta liquidez"),
    writeln("2. Largo plazo"),
    writeln("3. Medio plazo"),
    writeln("4. Corto plazo"),
    writeln("5. Commodities"),
    writeln("6. Renta fija"),
    writeln("7. Renta variable"),
    writeln("0. Finalizar selección"),
    leer_caracteristicas_deseadas
.

% Leer las características deseadas
leer_caracteristicas_deseadas :-
    write("Ingresa tu opción: "),
    read(Opcion),
    procesar_opcion_deseada(Opcion).

procesar_opcion_deseada(1) :- assert(caracteristicasDeseadasUsuario('alta liquidez')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(2) :- assert(caracteristicasDeseadasUsuario('largo plazo')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(3) :- assert(caracteristicasDeseadasUsuario('medio plazo')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(4) :- assert(caracteristicasDeseadasUsuario('corto plazo')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(5) :- assert(caracteristicasDeseadasUsuario('commodities')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(6) :- assert(caracteristicasDeseadasUsuario('renta fija')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(7) :- assert(caracteristicasDeseadasUsuario('renta variable')), leer_caracteristicas_deseadas.
procesar_opcion_deseada(0) :- mostrar_menu_caracteristicas_no_deseadas, !.
procesar_opcion_deseada(_) :- writeln("Opción no válida, intenta de nuevo."), leer_caracteristicas_deseadas.

% Menú para características no deseadas
mostrar_menu_caracteristicas_no_deseadas :-
    writeln("Selecciona las características NO deseadas (ingresa el número):"),
    writeln("1. Alta liquidez"),
    writeln("2. Largo plazo"),
    writeln("3. Medio plazo"),
    writeln("4. Corto plazo"),
    writeln("5. Commodities"),
    writeln("6. Renta fija"),
    writeln("7. Renta variable"),
    writeln("0. Finalizar selección"),
    leer_caracteristicas_no_deseadas
.

% Leer las características no deseadas
leer_caracteristicas_no_deseadas :-
    write("Ingresa tu opción: "),
    read(Opcion),
    procesar_opcion_no_deseada(Opcion).

procesar_opcion_no_deseada(1) :- assert(caracteristicasNoDeseadasUsuario('alta liquidez')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(2) :- assert(caracteristicasNoDeseadasUsuario('largo plazo')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(3) :- assert(caracteristicasNoDeseadasUsuario('medio plazo')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(4) :- assert(caracteristicasNoDeseadasUsuario('corto plazo')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(5) :- assert(caracteristicasNoDeseadasUsuario('commodities')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(6) :- assert(caracteristicasNoDeseadasUsuario('renta fija')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(7) :- assert(caracteristicasNoDeseadasUsuario('renta variable')), leer_caracteristicas_no_deseadas.
procesar_opcion_no_deseada(0) :- mostrar_resumen_caracteristicas, !.
procesar_opcion_no_deseada(_) :- writeln("Opción no válida, intenta de nuevo."), leer_caracteristicas_no_deseadas.

% Muestra el resumen de características
mostrar_resumen_caracteristicas :-
    writeln("Tus características deseadas son: "),
    listar_caracteristicas_deseadas,
    writeln("Tus características NO deseadas son: "),
    listar_caracteristicas_no_deseadas,
    preguntar_presupuesto.

listar_caracteristicas_deseadas :-
    findall(Caracteristica, caracteristicasDeseadasUsuario(Caracteristica), Lista),
    listar(Lista).

listar_caracteristicas_no_deseadas :-
    findall(Caracteristica, caracteristicasNoDeseadasUsuario(Caracteristica), Lista),
    listar(Lista).

listar([]).
listar([H|T]) :-
    write("- "), writeln(H),
    listar(T).

% Pregunta el presupuesto del usuario
preguntar_presupuesto:-
    write("¿Cuánto estás dispuesto a invertir? (monto en USD): "),
    read(Monto), nl,
    recomendar_inversion(Monto)
.

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

recomendar_inversion(_):-writeln("Por favor, ingrese un monto válido"), nl, preguntar_presupuesto.

recomendable([NombreInversion, Caracteristicas], Presupuesto):-
    riesgo_usuario(Riesgo, _),
    inversion(NombreInversion, Riesgo, MinimoAInvertir, Caracteristicas), 
    MinimoAInvertir =< Presupuesto
.

caracteristicas_compatibles(Caracteristicas):-
    findall(Deseada, caracteristicasDeseadasUsuario(Deseada), ListaDeseadas),
    intersection(Caracteristicas, ListaDeseadas, Coincidencias),
    Coincidencias \= [],
    findall(NoDeseada, caracteristicasNoDeseadasUsuario(NoDeseada), ListaNoDeseadas),
    intersection(Caracteristicas, ListaNoDeseadas, []).


resultado_final([]):-writeln("Perdón, no encontré inversiones para vos"), nl.

resultado_final(Lista):-
    writeln("Te recomiendo alguna de las siguientes inversiones: "),
    listar_recomendaciones(Lista),
    writeln("Espero que mi asesoramiento te haya sido útil")
.

listar_recomendaciones([[H1, H2] | T]):-
	write("- "), writeln(H1),
    write("Características: "), writeln(H2), nl,
    listar_recomendaciones(T)
.

listar_recomendaciones([]).

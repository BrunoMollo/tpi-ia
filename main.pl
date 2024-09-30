
riesgo("Criptomonedas",alto).
riesgo("Acciones",alto).
riesgo("Bonos del Tesoro", medio).
riesgo("Comparar Dolares", bajo).
riesgo("Fondos Mutuos",medio).
riesgo("Cuentas de Ahorro",bajo).


inversion_minima("Acciones", 1).
inversion_minima("Bonos del Tesoro", 100).
inversion_minima("Comparar Dolares", 100).
inversion_minima("Fondos Mutuos", 500).
inversion_minima("Cuentas de Ahorro", 1).



preguntar_riesgo(Decision) :-
    writeln("Que riesgo estas dispuesto a asumir? (bajo, medio, alto)"),
    read(Decision)
.

preguntar_monto(Decision) :-
    writeln("Cuanto estas dispuesto a invertir? (monto en dolares)"),
    read(Decision)
.

puede_inverir(Inversion, Monto_disponible):- 
  inversion_minima(Inversion, Monto_requerido),
  Monto_disponible>= Monto_requerido
.

recomendable(Inversion, Riesgo, Monto):- 
    riesgo(Inversion, Riesgo),
    puede_inverir(Inversion, Monto) 
.

recomendar_inversion(Riesgo, Monto):-
    findall(Inversion, recomendable(Inversion, Riesgo, Monto), Lista),
    resultado_final(Lista)
.

resultado_final([]):-writeln("Perdon, no encontre inversiones para vos"), nl.

resultado_final(Lista):-
    writeln("Te recomendamos las siguientes inversiones: "),
    listar_recomendaciones(Lista),
    writeln("Espero que este asesorameinto te haya sido de utilidad")
.


listar_recomendaciones([H | T]):-
	write("- "),writeln(H),
    listar_recomendaciones(T)
.

listar_recomendaciones([]).

main:- 
  preguntar_riesgo(Riesgo),
  preguntar_monto(Monto),
  recomendar_inversion(Riesgo, Monto),
  nl.

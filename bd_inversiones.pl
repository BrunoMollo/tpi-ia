:- dynamic(inversiones/2).

% inversion(nombre,idRiesgo,minimoAInvertir)
% riesgo bajo
inversion("Comprar dolares",1,100).
inversion("Cuentas de ahorro",1,1).


% riesgo medio
inversion("Fondos mutuos",2,500).
inversion("Bonos del tesoro",2,100).


% riesgo alto
inversion("Criptomonedas",3,10).
inversion("Acciones",3,1).

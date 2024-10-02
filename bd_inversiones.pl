:- dynamic(inversiones/4).

% inversion(nombre,idRiesgo,minimoAInvertir,[caracteristicas])
% riesgo bajo
inversion("Comprar dolares",1,100,["corto plazo", "commodities", "alta liquidez", "mercado monetario"]).

inversion("Cuentas de ahorro",1,1,["corto plazo","renta fija", "alta liquidez","mercado monetario"]).


% riesgo medio
inversion("Fondos mutuos",2,500,["largo plazo", "renta variable", "alta luquidez", "mercado de capitales"]).

inversion("Bonos del tesoro",2,100, ["plazo variable", "renta fija", "baja liquidez", "mercado de capitales"]). % es de plazo fijo segun el vencimiento.


% riesgo alto
inversion("Criptomonedas",3,10,["plazo variable","renta variable", "derivados", "inversiones especulativas", "alta liquidez", "mercado de capitales"]). % plazo variable segun estrategia que se elija.

inversion("Acciones",3,1,["largo plazo", "renta variable", "inversiones de crecimiento", "alta liquidez", "mercado de capitales"]).

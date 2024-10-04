:- dynamic(inversion/4).

% inversion(nombreInversion, riesgoId, minimoAInvertir, [lista de caracteristicas])
inversion('Acciones Apple', 3, 1000, ['alta liquidez', 'largo plazo']).
inversion('Bonos del Tesoro', 1, 500, ['bajo riesgo', 'largo plazo']).
inversion('Fondo de Inversion en Real Estate', 2, 2000, ['medio riesgo', 'medio plazo']).
inversion('Fondos comunes de inversion', 2, 800, ['alta liquidez', 'medio plazo']).
inversion('Comprar dolares', 1, 300, ['corto plazo', 'commodities', 'alta liquidez', 'mercado monetario']).
inversion('Cuentas de ahorro', 1, 200, ['corto plazo', 'renta fija', 'alta liquidez', 'mercado monetario']).

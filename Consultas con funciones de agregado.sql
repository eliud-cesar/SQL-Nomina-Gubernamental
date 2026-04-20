go
use NominaGob


-- USO DE COUNT ()
-- Contar cuántos empleados hay en cada dependencia pero que solo tenga mas de 1 empleado.
SELECT d.nombre_dependencia, COUNT(*) AS total_empleados
FROM Empleados e
JOIN Dependencias D ON d.id_dependencia = e.id_dependencia
GROUP BY d.nombre_dependencia
HAVING COUNT(*) > 1

-- Devuelve los empleados totales que hay en cada puesto pero sean igual o menor a 2 empleados.
SELECT e.id_puesto, p.titulo_puesto, COUNT(*) AS total_empleados
FROM Empleados e
JOIN Puestos p ON p.id_puesto = e.id_puesto
GROUP BY p.titulo_puesto, e.id_puesto
HAVING COUNT(*) <= 2;


-- USO DE SUM() 
-- Sumar el total de montos registrados en la nómina por cada empleado pero solo los que ganaron mas de $850,000.
SELECT e.nombres, d.id_empleado, SUM(monto) AS total_pagado
FROM Detalle_Nomina d
JOIN Empleados e ON e.id_empleado = d.id_empleado
GROUP BY d.id_empleado, e.nombres
HAVING SUM(monto) > 850000
ORDER BY d.id_empleado

-- Calcula cuánto gasta cada dependencia en sueldos base y muestra solo las que superan $20,000.
SELECT D.nombre_dependencia, SUM(P.sueldo_base) AS nomina_total
FROM Dependencias D
JOIN Empleados E ON D.id_dependencia = E.id_dependencia
JOIN Puestos P ON E.id_puesto = P.id_puesto
GROUP BY D.nombre_dependencia
HAVING SUM(P.sueldo_base) > 20000;


-- USO DE AVG()
-- Calcular el sueldo base promedio por cada nivel salarial pero solo los que superen los $10,000.
SELECT nivel_salarial, AVG(sueldo_base) AS promedio_nivel
FROM Puestos
GROUP BY nivel_salarial
HAVING AVG(sueldo_base) > 10000

-- Calcula el monto promedio ganado por empleado, que solo superen los $1,700.
SELECT e.nombres, AVG(monto) as Sueldo_Ganado_Promedio
FROM Detalle_Nomina d
JOIN Empleados e ON d.id_empleado = e.id_empleado
GROUP BY e.nombres
HAVING AVG(monto) > 1700


-- USO DE MIN()
-- Encontrar la fecha de ingreso más antigua por cada estatus (Activo, Baja, Licencia) pero solo aquellas que fueron en el 2012 en adelante.
SELECT estatus, MIN(fecha_ingreso) AS fecha_mas_antigua
FROM Empleados
GROUP BY estatus
HAVING MIN(fecha_ingreso) > '2012-01-01'

-- Para verificar que los rangos de los puestos estén bien configurados según su nivel.
SELECT nivel_salarial, MIN(sueldo_base) AS sueldo_min_nivel
FROM Puestos
GROUP BY nivel_salarial
HAVING MIN(sueldo_base) >= 5000; -- Filtrar niveles muy bajos


-- USO DE MAX()
-- Mostrar conceptos cuyo pago máximo registrado haya sido superior a $3,190.
SELECT dn.id_concepto, c.descripcion, c.tipo, MAX(monto) AS pago_alto
FROM Detalle_Nomina dn
JOIN Conceptos c ON dn.id_concepto = c.id_concepto
GROUP BY c.descripcion, c.tipo, dn.id_concepto
HAVING MAX(monto) > 3190;

-- Saber el monto maximo que recibio cada empleado por el concepto de pago de "sueldo base" pero que hayan sido mas de $3,150
SELECT DN.id_empleado, e.nombres, C.descripcion, MAX(DN.monto) AS pago_maximo
FROM Conceptos C
JOIN Detalle_Nomina DN ON C.id_concepto = DN.id_concepto
JOIN Empleados e ON e.id_empleado = dn.id_empleado
WHERE C.descripcion = 'Sueldo Base'
GROUP BY DN.id_empleado, C.descripcion, e.nombres
HAVING MAX(DN.monto) > 3150

-- ejemplo de toda la tabla
-- select * from Detalle_Nomina where id_concepto = 1
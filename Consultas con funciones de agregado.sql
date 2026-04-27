go
use NominaGob


-- USO DE COUNT ()
-- Contar cuántos empleados hay en cada dependencia pero que solo tenga mas de 1 empleado.
SELECT d.nombre_dependencia, COUNT(*) AS total_empleados
FROM Empleados e
JOIN Dependencias D ON d.id_dependencia = e.id_dependencia
GROUP BY d.nombre_dependencia
HAVING COUNT(*) >1

select * from Dependencias
select * from Empleados

-- Devuelve los empleados totales que hay en cada puesto pero sean igual o menor a 2 empleados.
SELECT e.id_puesto, p.titulo_puesto, COUNT(*) AS total_empleados
FROM Empleados e
JOIN Puestos p ON p.id_puesto = e.id_puesto
GROUP BY p.titulo_puesto, e.id_puesto
HAVING COUNT(*) > 2;


-- USO DE SUM() 
-- Sumar el total de montos registrados en la nómina por cada empleado pero solo 
-- los que ganaron mas de $850,000.
SELECT e.nombres,  SUM(monto) AS total_pagado
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
HAVING AVG(sueldo_base) <= 10000

-- Calcula el monto promedio ganado por empleado, que solo superen los $1,700.
SELECT e.nombres, AVG(monto) as Sueldo_Ganado_Promedio
FROM Detalle_Nomina d
JOIN Empleados e ON d.id_empleado = e.id_empleado
GROUP BY e.nombres
HAVING AVG(monto) <= 1700


-- USO DE MIN()
-- Encontrar la fecha de ingreso más antigua por cada estatus (Activo, Baja, Licencia) 
--pero solo aquellas que fueron en el 2012 en adelante.
SELECT estatus, MIN(fecha_ingreso) AS fecha_mas_antigua
FROM Empleados
GROUP BY estatus
HAVING MIN(fecha_ingreso) >= '2012-01-01'

-- Muestra el menor presupuesto anual de las dependencias
-- agrupadas por el nivel salarial más frecuente de sus empleados,
-- filtrando solo los grupos con presupuesto mínimo menor a $3,000,000.
SELECT
    P.nivel_salarial,
    MIN(D.presupuesto_anual) AS menor_presupuesto,
    COUNT(E.id_empleado)    AS total_empleados
FROM Dependencias D
JOIN Empleados E  ON E.id_dependencia = D.id_dependencia
JOIN Puestos P    ON P.id_puesto     = E.id_puesto
GROUP BY P.nivel_salarial
HAVING MIN(D.presupuesto_anual) < 3000000.00
ORDER BY menor_presupuesto ASC;


-- USO DE MAX()
-- Detecta, por cada período de nómina y tipo de concepto
-- (Percepción / Deducción), cuál fue el monto individual
-- más alto registrado. Solo muestra los que superan $2,800.
SELECT
    PN.id_periodo,
    PN.fecha_inicio,
    PN.fecha_fin,
    C.tipo,
    MAX(DN.monto) AS pago_pico,
    COUNT(DN.id_detalle) AS registros_en_periodo
FROM Detalle_Nomina DN
JOIN Periodos_Nomina PN ON PN.id_periodo  = DN.id_periodo
JOIN Conceptos C       ON C.id_concepto = DN.id_concepto
GROUP BY
    PN.id_periodo,
    PN.fecha_inicio,
    PN.fecha_fin,
    C.tipo
HAVING MAX(DN.monto) >= 3150.00
ORDER BY pago_pico DESC;

-- Identifica el descuento individual más alto que recibió
-- cada empleado, pero solo considerando conceptos de tipo
-- 'Deducción'. Filtra a quienes su peor descuento superó $1,500.
SELECT
    E.id_empleado,
    E.nombres + ' ' + E.apellidos AS nombre_completo,
    E.estatus,
    MAX(DN.monto)  AS mayor_deduccion,
    COUNT(DN.id_detalle) AS total_deducciones
FROM Detalle_Nomina DN
JOIN Empleados E  ON E.id_empleado  = DN.id_empleado
JOIN Conceptos C  ON C.id_concepto  = DN.id_concepto
WHERE C.tipo = 'Deducción'
GROUP BY
    E.id_empleado,
    E.nombres,
    E.apellidos,
    E.estatus
HAVING MAX(DN.monto) > 1500.00
ORDER BY mayor_deduccion DESC;
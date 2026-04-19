-- SCRIPT PARA LA 5000 INSERCIONES

DECLARE @contador INT = 1;

WHILE @contador <= 5000
BEGIN
    INSERT INTO Detalle_Nomina (id_periodo, id_empleado, id_concepto, monto, fecha_registro)
    VALUES (
        (ABS(CHECKSUM(NEWID())) % 10) + 1, -- ID Periodo aleatorio entre 1 y 10
        (ABS(CHECKSUM(NEWID())) % 10) + 1, -- ID Empleado aleatorio entre 1 y 10
        (ABS(CHECKSUM(NEWID())) % 10) + 1, -- ID Concepto aleatorio entre 1 y 10
        (ABS(CHECKSUM(NEWID())) % 3000) + 200, -- Monto aleatorio
        GETDATE()
    );
    SET @contador = @contador + 1;
END;

-- COMPROBACION DE LA 5000 INSERCIONES
SELECT COUNT(*) AS Total_de_Registros
FROM Detalle_Nomina

-- OBTENER LAS PRIMERAS 500 INSERCIONES
SELECT TOP (500) *
FROM Detalle_Nomina

-- CONSULTA PARA OBTENER EL DETALLE DE UN SOLO EMPLEADO A PARTIR DE UNA RESTRICCION (INNER JOIN)
SELECT 
    E.nombres, 
    E.apellidos, 
    D.id_detalle, 
    D.id_periodo, 
    C.descripcion AS Concepto, 
    D.monto, 
    D.fecha_registro
FROM Empleados E
INNER JOIN Detalle_Nomina D ON E.id_empleado = D.id_empleado
INNER JOIN Conceptos C ON D.id_concepto = C.id_concepto
WHERE E.id_empleado = 10;

-- 1 = 578 -- GANADOR DE MAS REGISTROS
-- 2 = 485
-- 3 = 493
-- 4 = 546
-- 5 = 470
-- 6 = 503
-- 7 = 479
-- 8 = 529
-- 9 = 507
-- 10 = 510

-- CONSULTA PARA LOS TOP 5 EMPLEADOS QUE HAN GANADO MAS
SELECT TOP 5 
    E.id_empleado,
    E.nombres, 
    E.apellidos, 
    SUM(D.monto) AS Total_Acumulado
FROM Empleados E
INNER JOIN Detalle_Nomina D ON E.id_empleado = D.id_empleado
GROUP BY E.id_empleado, E.nombres, E.apellidos
ORDER BY Total_Acumulado DESC;

-- CONSULTA DONDE EL MONTO SEA 200
SELECT *
FROM Detalle_Nomina
WHERE monto = 200
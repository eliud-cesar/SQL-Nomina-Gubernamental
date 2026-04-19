-- QUERY DE INSERCIONES

-- TABLA DE DEPENDENCIAS
INSERT INTO Dependencias(nombre_dependencia, presupuesto_anual) VALUES 
('Secretaría de Finanzas', 5000000.00),
('Recursos Humanos', 1200000.00),
('Coordinación Jurídica', 950000.00),
('Secretaria de la Marina', 2500000.00),
('Comunicación Social', 800000.00),
('Obras Públicas', 4500000.00),
('Servicios Municipales', 1500000.00),
('Secretaria de Seguridad y Proteccion Ciudadana', 6000000.00),
('Secretaria de Defensa Nacional', 2200000.00),
('Protección Civil', 900000.00);

-- COMPROBACION
select * from Dependencias


-- TABLA DE PUESTOS
INSERT INTO Puestos (titulo_puesto, nivel_salarial, sueldo_base) VALUES 
('Director General', 'Nivel 1', 65000.00),
('Jefe de Departamento', 'Nivel 2', 38000.00),
('Coordinador A', 'Nivel 3', 25000.00),
('Analista Especializado', 'Nivel 4', 18000.00),
('Auxiliar Administrativo', 'Nivel 5', 12000.00),
('Secretario Particular', 'Nivel 2', 35000.00),
('Subdirector Regional', 'Nivel 3', 28000.00),
('Supervisor de Obra', 'Nivel 4', 20000.00),
('Técnico en Sistemas', 'Nivel 5', 14000.00),
('Chofer Administrativo', 'Nivel 6', 9500.00);

-- COMPROBACION
select * from Puestos


-- TABLA DE EMPLEADOS
INSERT INTO Empleados (rfc, nombres, apellidos, fecha_ingreso, estatus, id_dependencia, id_puesto) VALUES 
('PERJ800101HDF', 'Juan', 'Pérez Jiménez', '2015-01-10', 'Activo', 1, 1),
('GARM920512MGR', 'María', 'García Ruiz', '2018-03-15', 'Activo', 2, 5),
('LOPA751120HSP', 'Alberto', 'López Parra', '2010-06-01', 'Activo', 3, 4),
('SOTM880228MNE', 'Mónica', 'Soto Méndez', '2020-09-20', 'Activo', 4, 8),
('RIVA950714HJL', 'Arturo', 'Rivas Luna', '2021-02-01', 'Activo', 6, 10),
('MORL901231MKL', 'Lucía', 'Morales Kuri', '2019-11-15', 'Activo', 2, 9),
('CAST820405HMM', 'Tomás', 'Casas Mireles', '2012-08-30', 'Licencia', 9, 1),
('GOMY940812MNN', 'Yolanda', 'Gómez Nava', '2022-01-10', 'Activo', 10, 6),
('HERR770303HPP', 'Roberto', 'Hernández Paz', '2014-05-22', 'Activo', 7, 3),
('DIAE850615MJJ', 'Elena', 'Díaz Juárez', '2017-10-01', 'Activo', 10, 5);

-- COMPROBACION
select * from Empleados


-- TABLA DE CONCEPTOS DE NOMINA
INSERT INTO Conceptos (descripcion, tipo, es_fijo) VALUES 
('Sueldo Base', 'Percepción', 1),
('Bono de Despensa', 'Percepción', 1),
('Bono de Antigüedad', 'Percepción', 0),
('Impuesto sobre la Renta (ISR)', 'Deducción', 1),
('Seguro Social (IMSS/ISSSTE)', 'Deducción', 1),
('Cuota Sindical', 'Deducción', 0),
('Apoyo a Transporte', 'Percepción', 1),
('Prima Vacacional', 'Percepción', 0),
('Fondo de Ahorro', 'Deducción', 1),
('Préstamo Habitacional', 'Deducción', 0);

-- COMPROBACION
select * from Conceptos


-- TABLA DE PERIODOS DE NOMINA
INSERT INTO Periodos_Nomina (fecha_inicio, fecha_fin, estado) VALUES 
('2024-03-01', '2024-03-15', 'Abierto'),
('2024-03-16', '2024-03-31', 'Abierto'),
('2024-04-01', '2024-04-15', 'Abierto'),
('2024-04-16', '2024-04-30', 'Abierto'),
('2024-05-01', '2024-05-15', 'Abierto'),
('2024-05-16', '2024-05-31', 'Abierto'),
('2024-06-01', '2024-06-15', 'Abierto'),
('2024-06-16', '2024-06-30', 'Abierto'),
('2024-07-01', '2024-07-15', 'Abierto'),
('2024-07-16', '2024-07-31', 'Abierto');

-- COMPROBACION
select * from Periodos_Nomina
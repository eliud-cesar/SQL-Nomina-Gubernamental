
CREATE DATABASE NominaGob;
GO
USE NominaGob;
GO

--TABLA DE DEPENDENCIAS
CREATE TABLE Dependencias (
    id_dependencia INT PRIMARY KEY IDENTITY(1,1),
    nombre_dependencia NVARCHAR(100) NOT NULL UNIQUE,
    presupuesto_anual DECIMAL(18, 2) NOT NULL CHECK (presupuesto_anual >= 0)
);

--TABLA DE PUESTOS
CREATE TABLE Puestos (
    id_puesto INT PRIMARY KEY IDENTITY(1,1),
    titulo_puesto NVARCHAR(100) NOT NULL,
    nivel_salarial NVARCHAR(10) NOT NULL,
    sueldo_base DECIMAL(18, 2) NOT NULL CHECK (sueldo_base > 0)
);

-- 4. TABLA DE EMPLEADOS
CREATE TABLE Empleados (
    id_empleado INT PRIMARY KEY IDENTITY(1,1),
    rfc NVARCHAR(13) NOT NULL UNIQUE,
    nombres NVARCHAR(100) NOT NULL,
    apellidos NVARCHAR(100) NOT NULL,
    fecha_ingreso DATE NOT NULL DEFAULT GETDATE(),
    estatus NVARCHAR(20) CHECK (estatus IN ('Activo', 'Baja', 'Licencia')) DEFAULT 'Activo',
    id_dependencia INT,
    id_puesto INT,
    -- Llaves Foráneas
    CONSTRAINT FK_Empleado_Depto FOREIGN KEY (id_dependencia) 
        REFERENCES Dependencias(id_dependencia) ON DELETE SET NULL,
    CONSTRAINT FK_Empleado_Puesto FOREIGN KEY (id_puesto) 
        REFERENCES Puestos(id_puesto) ON DELETE SET NULL
);

-- 5. TABLA DE CONCEPTOS
CREATE TABLE Conceptos (
    id_concepto INT PRIMARY KEY IDENTITY(1,1),
    descripcion NVARCHAR(100) NOT NULL,
    tipo NVARCHAR(20) CHECK (tipo IN ('Percepción', 'Deducción')) NOT NULL,
    es_fijo BIT NOT NULL DEFAULT 1
);

-- 6. TABLA DE PERIODOS DE NÓMINA
CREATE TABLE Periodos_Nomina (
    id_periodo INT PRIMARY KEY IDENTITY(1,1),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    estado NVARCHAR(20) CHECK (estado IN ('Abierto', 'Cerrado', 'Pagado')) DEFAULT 'Abierto'
);

-- 7. TABLA DE DETALLE DE NÓMINA
CREATE TABLE Detalle_Nomina (
    id_detalle INT PRIMARY KEY IDENTITY(1,1),
    id_periodo INT NOT NULL,
    id_empleado INT NOT NULL,
    id_concepto INT NOT NULL,
    monto DECIMAL(18, 2) NOT NULL,
    fecha_registro DATETIME DEFAULT GETDATE(),
    -- Llaves Foráneas
    CONSTRAINT FK_Detalle_Periodo FOREIGN KEY (id_periodo) 
        REFERENCES Periodos_Nomina(id_periodo),
    CONSTRAINT FK_Detalle_Empleado FOREIGN KEY (id_empleado) 
        REFERENCES Empleados(id_empleado),
    CONSTRAINT FK_Detalle_Concepto FOREIGN KEY (id_concepto) 
        REFERENCES Conceptos(id_concepto)
);
GO
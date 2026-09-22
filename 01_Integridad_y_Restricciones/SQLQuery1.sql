create database Ejercicio1_clase3;

-------------------------------------------------
------- TABLAS, CAMPOS, TIPO DE DATO ------------
-------------------------------------------------

--Crear una tabla Clientes con los siguientes campos:
--Id (Entero )
--Nombre (Cadena de Texto hasta 50 caracteres)
--Nombre2 (Cadena de Texto hasta 50 caracteres)
--Apellido (Cadena de Texto hasta 50 caracteres)
--FechaCreacion (fecha/hora)
--Sexo (Cadena de texto de 1 carácter)

create table Clientes (
	id int not null,
	nombre char(50),
	apellido char(50),
	fechaCreacion datetime,
	sexo CHAR(1)

)
/*
2. Consultar información de la base de datos
Ejecutar los procedimientos almacenados:

SP_Tables ? Para obtener información de las tablas de la base de datos.
SP_Columns ? Para obtener información sobre las columnas de la tabla Clientes.
*/

SP_Tables;

SP_Columns "Clientes";

--3. NULL/NOT NULL: Crear una tabla Clientes con los siguientes campos:

--Id ?? Entero y Obligatorio
--Nombre ?? Cadena de Texto hasta 50 caracteres y Obligatorio
--Nombre2 ?? Cadena de Texto hasta 50 caracteres y Opcional
--Apellido ?? Cadena de Texto hasta 50 caracteres y Obligatorio
--Insertar datos de prueba y chequear el funcionamiento

create table clientes2(
Id int not null,
mombre char(50) not null,
mombre2 char(50) null,
apellido char(50) not Null,
)

--prueba
INSERT INTO clientes2(Id,mombre,mombre2,apellido)
VALUES (1,'Johan',NULL,'Cruyff')

INSERT INTO clientes2(Id,mombre,mombre2,apellido)
VALUES (1,'Diego','Armando','Maradora')

select * from clientes2

-- 4. DEFAULT: Recrear la tabla Clientes con los siguientes campos:
	--Id 🡪 Entero y Obligatorio
	--Nombre 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
	--Nombre2 🡪 Cadena de Texto hasta 50 caracteres y Opcional
	--Apellido 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
	--FechaCreacion 🡪 fecha/hora, Obligatorio y por defecto la fecha/hora actual
	--Insertar datos de prueba y chequear el funcionamiento


--5. IDENTITY: Recrear la tabla Clientes con los siguientes campos:
	--Id 🡪 Entero, Obligatorio y que se autoincremente de 1 en 1
	--Nombre 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
	--Nombre2 🡪 Cadena de Texto hasta 50 caracteres y Opcional
	--Apellido 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
	--FechaCreacion 🡪 fecha/hora, Obligatorio y por defecto la fecha/hora actual
	--Insertar datos de prueba y chequear el funcionamiento
	-- Eliminar tabla si ya existe
DROP TABLE IF EXISTS Clientes;

-- Crear tabla
CREATE TABLE Clientes (
    Id INT IDENTITY(1,1) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Nombre2 VARCHAR(50) NULL,
    Apellido VARCHAR(50) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
);

-- Insertar datos de prueba
INSERT INTO Clientes (Nombre, Nombre2, Apellido)
VALUES
('Juan', 'Carlos', 'Perez'),
('Maria', NULL, 'Gomez'),
('Pedro', 'Luis', 'Rodriguez'),
('Lucia', NULL, 'Fernandez');

-- Consultar tabla
SELECT *
FROM Clientes;

--6. Campo Calculado: Recrear la tabla Clientes con los siguientes campos:

	--Id 🡪 Entero, Obligatorio y que se autoincremente de 2 en 2 y comience en 4
	--Nombre 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
	--Nombre2 🡪 Cadena de Texto hasta 50 caracteres y Opcional
	--Apellido 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
	--FechaCreacion 🡪 fecha/hora, Obligatorio y por defecto la fecha/hora actual
	--NombreCompleto 🡪 Concatenación de Nombre, Nombre2 y Apellido
	--Insertar datos de prueba y chequear el funcionamiento

DROP TABLE IF EXISTS Clientes;

CREATE TABLE Clientes (
    Id INT IDENTITY(4,2) NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Nombre2 VARCHAR(50) NULL,
    Apellido VARCHAR(50) NOT NULL,
    FechaCreacion DATETIME NOT NULL DEFAULT GETDATE(),
    NombreCompleto AS CONCAT(Nombre, ' ', Nombre2, ' ', Apellido)
);

INSERT INTO Clientes (Nombre, Nombre2, Apellido)
VALUES
('Juan', 'Carlos', 'Perez'),
('Maria', NULL, 'Gomez'),
('Pedro', 'Luis', 'Rodriguez'),
('Lucia', NULL, 'Fernandez');

SELECT *
FROM Clientes;

--7. Check: Recrear la tabla Clientes con los siguientes campos:

--Id 🡪 Entero, Obligatorio y que se autoincremente de 2 en 2 y comience en 4
--Nombre 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
--Nombre2 🡪 Cadena de Texto hasta 50 caracteres y Opcional
--Apellido 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio
--FechaCreacion 🡪 fecha/hora, Obligatorio y por defecto la fecha/hora actual
--NombreCompleto 🡪 Concatenación de Nombre, Nombre2 y Apellido
--Sexo 🡪 Cadena de texto de 1 carácter que sea “F” o “M”
--Insertar datos de prueba y chequear el funcionamiento

ALTER TABLE Clientes ADD Sexo CHAR(1);

ALTER TABLE Clientes
ADD CONSTRAINT CK_Clientes_Sexo
CHECK (Sexo IN ('M', 'F'));

INSERT INTO Clientes (Nombre, Nombre2, Apellido, Sexo)
VALUES
('Juan', 'Carlos', 'Perez', 'M'),
('Maria', NULL, 'Gomez', 'F'),
('Pedro', 'Luis', 'Rodriguez', 'M'),
('Lucia', NULL, 'Fernandez', 'F');

--8. PRIMARY KEY: Crear la tabla Editorial con los siguientes campos:

	--Id 🡪 Entero, Obligatorio

	--Nombre 🡪 Cadena de Texto hasta 50 caracteres y Obligatorio

	--Idioma 🡪 Cadena de Texto de 3caracteres y Opcional

	--Insertar datos de prueba y chequear el funcionamiento

CREATE TABLE Editorial (
	Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL,
	Idioma VARCHAR(3),
)

INSERT INTO Editorial (Nombre, Idioma)
VALUES
('Planeta', 'ESP'),
('Penguin Random House', 'ESP'),
('HarperCollins', 'ENG'),
('Alfaguara', NULL);

SELECT * FROM Editorial;

--UNIQUE: Crear la tabla NombresUnicos con los siguientes campos:

--Nombre 🡪 Cadena de Texto hasta 50 caracteres, Obligatorio y Único

--Insertar datos de prueba y chequear el funcionamiento

-- Crear tabla
CREATE TABLE NombresUnicos (
    Nombre VARCHAR(50) NOT NULL UNIQUE
);

-- Insertar datos de prueba
INSERT INTO NombresUnicos (Nombre)
VALUES
('Juan'),
('Maria'),
('Pedro'),
('Lucia');

-- Consultar
SELECT *
FROM NombresUnicos;

-- Probar UNIQUE
INSERT INTO NombresUnicos (Nombre)
VALUES ('Juan');

-- ============================================
-- TABLA LIBRO
-- ============================================

CREATE TABLE Libro (
    Id INT NOT NULL,
    IdEditorial INT NULL,
    Titulo VARCHAR(50) NULL,
    Area VARCHAR(4) NULL,

    CONSTRAINT PK_Libro
        PRIMARY KEY (Id),

    CONSTRAINT FK_Libro_Editorial
        FOREIGN KEY (IdEditorial)
        REFERENCES Editorial(Id)
);


-- ============================================
-- DATOS DE PRUEBA
-- ============================================

INSERT INTO Libro (Id, IdEditorial, Titulo, Area)
VALUES
(1, 1, 'SQL Server desde cero', 'DATA'),
(2, 2, 'Python para todos', 'PROG'),
(3, 3, 'Power BI avanzado', 'BI');


-- ============================================
-- LIBRO SIN EDITORIAL
-- ============================================

INSERT INTO Libro (Id, IdEditorial, Titulo, Area)
VALUES
(4, NULL, 'Libro sin editorial', 'DATA');


-- ============================================
-- EDITORIAL QUE NO EXISTE
-- ============================================

INSERT INTO Libro (Id, IdEditorial, Titulo, Area)
VALUES
(5, 99, 'Libro de prueba', 'DATA');


-- ============================================
-- MODIFICAR EDITORIAL CON LIBROS
-- 1er INTENTO
-- ============================================

UPDATE Editorial
SET Id = 10
WHERE Id = 1;


-- ============================================
-- MODIFICAR LIBRO A EDITORIAL INEXISTENTE
-- ============================================

UPDATE Libro
SET IdEditorial = 99
WHERE Id = 1;


-- ============================================
-- ELIMINAR EDITORIAL CON LIBROS
-- 1er INTENTO
-- ============================================

DELETE FROM Editorial
WHERE Id = 1;


-- ============================================
-- MODIFICAR FOREIGN KEY
-- ============================================

ALTER TABLE Libro
DROP CONSTRAINT FK_Libro_Editorial;

ALTER TABLE Libro
ADD CONSTRAINT FK_Libro_Editorial
FOREIGN KEY (IdEditorial)
REFERENCES Editorial(Id)
ON UPDATE CASCADE
ON DELETE CASCADE;


-- ============================================
-- MODIFICAR EDITORIAL CON LIBROS
-- 2do INTENTO
-- ============================================

UPDATE Editorial
SET Id = 10
WHERE Id = 1;


-- ============================================
-- ELIMINAR EDITORIAL CON LIBROS
-- 2do INTENTO
-- ============================================

DELETE FROM Editorial
WHERE Id = 10;
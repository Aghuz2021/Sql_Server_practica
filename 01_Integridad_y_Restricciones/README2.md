# 🗄️ Práctica SQL Server — Integridad y Restricciones

Repositorio de práctica orientado al aprendizaje de **SQL Server** y **T-SQL**, enfocado en la creación de tablas, definición de tipos de datos y aplicación de restricciones para garantizar la **integridad de los datos**.

---

## 🎯 Objetivo

El objetivo de esta práctica es aprender a crear y modificar estructuras de bases de datos utilizando **SQL Server**, aplicando diferentes restricciones para controlar los datos almacenados.

Durante los ejercicios se trabajan:

* Tipos de datos
* `NULL` / `NOT NULL`
* `DEFAULT`
* `IDENTITY`
* Campos calculados
* `CHECK`
* `PRIMARY KEY`
* `UNIQUE`
* `FOREIGN KEY`
* `UPDATE CASCADE`
* `DELETE CASCADE`

Además, se realizan pruebas con datos válidos e inválidos mediante operaciones `INSERT`, `UPDATE` y `DELETE`.

---

## 🧰 Tecnologías utilizadas

![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-red?style=for-the-badge\&logo=microsoftsqlserver\&logoColor=white)

* **SQL Server**
* **T-SQL**
* **SQL Server Management Studio (SSMS)**
* **Git / GitHub**

---

# 📚 Índice

* [1. Creación de la tabla Clientes](#1-creación-de-la-tabla-clientes)
* [2. NULL / NOT NULL](#2-null--not-null)
* [3. DEFAULT](#3-default)
* [4. IDENTITY](#4-identity)
* [5. Campo Calculado](#5-campo-calculado)
* [6. CHECK](#6-check)
* [7. PRIMARY KEY](#7-primary-key)
* [8. UNIQUE](#8-unique)
* [9. FOREIGN KEY](#9-foreign-key)
* [10. UPDATE CASCADE y DELETE CASCADE](#10-update-cascade-y-delete-cascade)
* [11. Conceptos aprendidos](#11-conceptos-aprendidos)
* [12. Estructura del proyecto](#12-estructura-del-proyecto)

---

# 1. Creación de la tabla Clientes

Crear una tabla llamada `Clientes` con los siguientes campos:

| Campo           | Tipo        |
| --------------- | ----------- |
| `Id`            | Entero      |
| `Nombre`        | VARCHAR(50) |
| `Nombre2`       | VARCHAR(50) |
| `Apellido`      | VARCHAR(50) |
| `FechaCreacion` | DATETIME    |
| `Sexo`          | VARCHAR(1)  |

### Procedimientos almacenados

Ejecutar los siguientes procedimientos:

```sql
EXEC SP_Tables;
```

Permite obtener información sobre las tablas de la base de datos.

```sql
EXEC SP_Columns;
```

Permite obtener información sobre las columnas de las tablas.

---

# 2. NULL / NOT NULL

Recrear la tabla `Clientes` aplicando restricciones de obligatoriedad.

| Campo      | Características           |
| ---------- | ------------------------- |
| `Id`       | Entero y obligatorio      |
| `Nombre`   | VARCHAR(50) y obligatorio |
| `Nombre2`  | VARCHAR(50) y opcional    |
| `Apellido` | VARCHAR(50) y obligatorio |

### Conceptos

```sql
NOT NULL
```

Indica que el campo es obligatorio.

```sql
NULL
```

Permite que el campo no tenga un valor.

### Actividades

* Crear la tabla.
* Insertar datos de prueba.
* Insertar registros sin `Nombre2`.
* Intentar insertar registros sin `Nombre`.
* Intentar insertar registros sin `Apellido`.
* Verificar los errores generados por SQL Server.

---

# 3. DEFAULT

Recrear la tabla `Clientes` agregando una fecha de creación automática.

| Campo           | Características                               |
| --------------- | --------------------------------------------- |
| `Id`            | INT, obligatorio                              |
| `Nombre`        | VARCHAR(50), obligatorio                      |
| `Nombre2`       | VARCHAR(50), opcional                         |
| `Apellido`      | VARCHAR(50), obligatorio                      |
| `FechaCreacion` | DATETIME, obligatorio y con valor por defecto |

Configurar:

```sql
FechaCreacion DATETIME NOT NULL DEFAULT GETDATE()
```

### Objetivo

Utilizar `DEFAULT` para asignar automáticamente la fecha y hora actual cuando no se proporciona un valor.

### Ejemplo

```sql
INSERT INTO Clientes (Id, Nombre, Apellido)
VALUES (1, 'Juan', 'Perez');
```

La columna `FechaCreacion` se completa automáticamente.

---

# 4. IDENTITY

Recrear la tabla `Clientes` utilizando un identificador autoincremental.

| Campo           | Características                             |
| --------------- | ------------------------------------------- |
| `Id`            | INT, obligatorio y autoincremental          |
| `Nombre`        | VARCHAR(50), obligatorio                    |
| `Nombre2`       | VARCHAR(50), opcional                       |
| `Apellido`      | VARCHAR(50), obligatorio                    |
| `FechaCreacion` | DATETIME, obligatorio y `DEFAULT GETDATE()` |

Utilizar:

```sql
IDENTITY(1,1)
```

### Resultado esperado

```text
1
2
3
4
5
...
```

### Objetivo

Aprender a generar automáticamente los identificadores de los registros.

---

# 5. Campo Calculado

Recrear la tabla `Clientes`.

| Campo            | Características               |
| ---------------- | ----------------------------- |
| `Id`             | INT, `IDENTITY(4,2)`          |
| `Nombre`         | VARCHAR(50), obligatorio      |
| `Nombre2`        | VARCHAR(50), opcional         |
| `Apellido`       | VARCHAR(50), obligatorio      |
| `FechaCreacion`  | DATETIME, `DEFAULT GETDATE()` |
| `NombreCompleto` | Campo calculado               |

Utilizar:

```sql
IDENTITY(4,2)
```

Esto significa:

* `4` → valor inicial.
* `2` → incremento.

Resultado:

```text
4
6
8
10
12
...
```

### Campo calculado

Crear `NombreCompleto` concatenando:

```text
Nombre + Nombre2 + Apellido
```

Ejemplo:

```text
Nombre: Juan
Nombre2: Carlos
Apellido: Perez

NombreCompleto:
Juan Carlos Perez
```

Una posible implementación:

```sql
NombreCompleto AS CONCAT(Nombre, ' ', Nombre2, ' ', Apellido)
```

---

# 6. CHECK

Recrear la tabla `Clientes` agregando el campo `Sexo`.

| Campo            | Características                 |
| ---------------- | ------------------------------- |
| `Id`             | `IDENTITY(4,2)`                 |
| `Nombre`         | VARCHAR(50), obligatorio        |
| `Nombre2`        | VARCHAR(50), opcional           |
| `Apellido`       | VARCHAR(50), obligatorio        |
| `FechaCreacion`  | DATETIME, `DEFAULT GETDATE()`   |
| `NombreCompleto` | Campo calculado                 |
| `Sexo`           | VARCHAR(1), solamente `F` o `M` |

Crear una restricción:

```sql
CHECK (Sexo IN ('F', 'M'))
```

### Valores permitidos

| Valor | Resultado   |
| ----- | ----------- |
| `F`   | ✅ Válido    |
| `M`   | ✅ Válido    |
| `X`   | ❌ No válido |
| `A`   | ❌ No válido |

### Ejemplo

```sql
ALTER TABLE Clientes
ADD CONSTRAINT CK_Clientes_Sexo
CHECK (Sexo IN ('F', 'M'));
```

---

# 7. PRIMARY KEY

Crear la tabla `Editorial`.

| Campo    | Características          |
| -------- | ------------------------ |
| `Id`     | INT, obligatorio         |
| `Nombre` | VARCHAR(50), obligatorio |
| `Idioma` | VARCHAR(3), opcional     |

Definir `Id` como clave primaria:

```sql
PRIMARY KEY
```

### Ejemplo

```sql
CREATE TABLE Editorial (
    Id INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Idioma VARCHAR(3) NULL
);
```

### Objetivo

La `PRIMARY KEY` permite identificar de manera única cada registro de la tabla.

### Actividades

* Crear la tabla.
* Insertar datos de prueba.
* Consultar los registros.
* Intentar insertar valores duplicados.
* Intentar insertar valores `NULL`.
* Analizar las restricciones de la clave primaria.

---

# 8. UNIQUE

Crear la tabla `NombresUnicos`.

| Campo    | Características                  |
| -------- | -------------------------------- |
| `Nombre` | VARCHAR(50), obligatorio y único |

Crear la restricción:

```sql
UNIQUE
```

### Ejemplo

```sql
CREATE TABLE NombresUnicos (
    Nombre VARCHAR(50) NOT NULL UNIQUE
);
```

### Valores válidos

```text
Juan
Maria
Pedro
Lucia
```

Intentar insertar nuevamente:

```text
Juan
```

generará un error porque el valor ya existe.

### Objetivo

Evitar valores duplicados dentro de una columna.

---

# 9. FOREIGN KEY

Crear la tabla `Libro`.

| Campo         | Características               |
| ------------- | ----------------------------- |
| `Id`          | INT, obligatorio              |
| `IdEditorial` | INT, opcional y clave foránea |
| `Titulo`      | VARCHAR(50), opcional         |
| `Area`        | VARCHAR(4), opcional          |

`IdEditorial` debe referenciar:

```text
Editorial.Id
```

### Ejemplo

```sql
CREATE TABLE Libro (
    Id INT NOT NULL PRIMARY KEY,
    IdEditorial INT NULL,
    Titulo VARCHAR(50) NULL,
    Area VARCHAR(4) NULL,

    CONSTRAINT FK_Libro_Editorial
        FOREIGN KEY (IdEditorial)
        REFERENCES Editorial(Id)
);
```

### Relación

```text
Editorial
    │
    │ Id
    ▼
Libro.IdEditorial
```

### Actividades

* Crear la tabla `Libro`.
* Insertar libros con editoriales existentes.
* Insertar un libro sin editorial.
* Intentar insertar un libro con una editorial inexistente.
* Modificar un libro a una editorial inexistente.
* Intentar modificar una editorial con libros asociados.
* Intentar eliminar una editorial con libros asociados.
* Modificar una editorial sin libros asociados.
* Eliminar una editorial sin libros asociados.

---

# 10. UPDATE CASCADE y DELETE CASCADE

Modificar la relación entre `Libro` y `Editorial` para utilizar acciones en cascada.

Primero eliminar la restricción existente:

```sql
ALTER TABLE Libro
DROP CONSTRAINT FK_Libro_Editorial;
```

Luego crear nuevamente la relación:

```sql
ALTER TABLE Libro
ADD CONSTRAINT FK_Libro_Editorial
FOREIGN KEY (IdEditorial)
REFERENCES Editorial(Id)
ON UPDATE CASCADE
ON DELETE CASCADE;
```

---

## UPDATE CASCADE

Permite actualizar automáticamente las claves foráneas relacionadas.

Ejemplo:

```text
Editorial
Id = 1

Libro
IdEditorial = 1
```

Si ejecutamos:

```sql
UPDATE Editorial
SET Id = 10
WHERE Id = 1;
```

El valor relacionado se actualizará automáticamente:

```text
Libro.IdEditorial

1 → 10
```

---

## DELETE CASCADE

Permite eliminar automáticamente los registros relacionados.

Ejemplo:

```text
Editorial 1
│
├── Libro 1
├── Libro 2
└── Libro 3
```

Al ejecutar:

```sql
DELETE FROM Editorial
WHERE Id = 1;
```

También se eliminarán los libros asociados.

> ⚠️ **Importante:** `DELETE CASCADE` debe utilizarse con cuidado, ya que puede eliminar múltiples registros relacionados automáticamente.

---

# 11. Conceptos aprendidos

## Tipos de datos

```text
INT
VARCHAR
CHAR
DATETIME
```

## Integridad de campos

```text
NULL
NOT NULL
DEFAULT
IDENTITY
CHECK
Campo calculado
```

## Integridad de filas

```text
PRIMARY KEY
UNIQUE
```

## Integridad referencial

```text
FOREIGN KEY
ON UPDATE CASCADE
ON DELETE CASCADE
```

## Operaciones SQL

```sql
CREATE TABLE
ALTER TABLE
INSERT
SELECT
UPDATE
DELETE
```

---

# 12. Estructura del proyecto

```text
sql-server-integridad/
│
├── README.md
│
├── 01_creacion_clientes.sql
├── 02_null_not_null.sql
├── 03_default.sql
├── 04_identity.sql
├── 05_campo_calculado.sql
├── 06_check.sql
├── 07_primary_key.sql
├── 08_unique.sql
├── 09_foreign_key.sql
└── 10_cascade.sql
```

---

# 📊 Resumen de conceptos

| Concepto         | Descripción                                    |
| ---------------- | ---------------------------------------------- |
| `NULL`           | Permite que una columna no tenga valor         |
| `NOT NULL`       | Obliga a que la columna tenga un valor         |
| `DEFAULT`        | Establece un valor automáticamente             |
| `IDENTITY`       | Genera valores numéricos automáticamente       |
| Campo calculado  | Obtiene un valor a partir de otras columnas    |
| `CHECK`          | Limita los valores permitidos                  |
| `PRIMARY KEY`    | Identifica de forma única cada registro        |
| `UNIQUE`         | Evita valores duplicados                       |
| `FOREIGN KEY`    | Relaciona dos tablas                           |
| `UPDATE CASCADE` | Propaga cambios en las claves relacionadas     |
| `DELETE CASCADE` | Elimina registros relacionados automáticamente |


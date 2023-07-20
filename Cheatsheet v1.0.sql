--- SQL
-- DDL -> Lenguaje de Definicion de Datos
-- Crear DB
CREATE DATABASE empresa;

-- Mostrar todas las DB's disponibles
SHOW DATABASES;

-- Eliminar una DB
DROP DATABASE empresa;

-- Utilizar o seleccionar una DB
USE empresa;

-- mostrar todas las tablas de la DB seleccionada
SHOW TABLES;


-- ver detalle de una tabla
DESC empleados;

-- crear una tabla
CREATE TABLE empleados (
    ci_id INT, 
    nombre VARCHAR(20) NOT NULL, 
    appaterno VARCHAR(30) NOT NULL,
    apmaterno VARCHAR(30),
    dtnacimiento DATE NOT NULL,
    salario NUMERIC(8,2) NOT NULL,
    direccion VARCHAR(150),
    sexo VARCHAR(1),
    dpto_id INT,
    supervisor_id INT,
    PRIMARY KEY(ci_id)
    );

CREATE TABLE departamentos(
    numero_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL UNIQUE,
    admin_id INT,
    dtInicio DATE
);

CREATE TABLE dpto_ubicaciones(
    dpto_id INT,
    ubicacion VARCHAR(50),
    PRIMARY KEY (dpto_id, ubicacion)
);

-- Modificar la estructura de una tabla
-- ALTER
ALTER TABLE dpto_ubicaciones 
ADD PRIMARY KEY(dpto_id, ubicacion);

-- AGREGAR LLAVES FORANEAS
ALTER TABLE dpto_ubicaciones
ADD FOREIGN KEY (dpto_id) REFERENCES departamentos(numero_id);

ALTER TABLE empleados
ADD FOREIGN KEY (supervisor_id) REFERENCES empleados(ci_id);

-- FIN DDL

-- DML --> Lenguaje de Manipulacion de Datos
-- Insertar datos en una tabla
-- total
INSERT INTO empleados VALUES(1,'Juan','Perez','Perez','1990-05-22',1500, 'Av. Banzer 2do anillo','M',null,null);

--parcial
INSERT INTO empleados(appaterno,nombre,ci_id,salario,dtnacimiento) VALUES('Mendez','Luis',2,2000.52,'1998-09-04');
INSERT INTO empleados(ci_id) VALUES (3);

--Actualizar los datos
-- UPDATE
UPDATE departamentos SET admin_id = 2, dtInicio = now() WHERE numero_id = 1;

-- Eliminar datos
-- DELETE
DELETE FROM dpto_ubicaciones;
SELECT * FROM departamentos WHERE numero_id > 99;

-- VER LOS DATOS DE UNA TABLA
-- SELECT
SELECT * FROM empleados;

-- CONSULTAS SQL

-- SELECT -- columnas 
-- FROM -- tabla(s)
-- WHERE  -- filas

-- ver el salario de empleados
SELECT ci_id, snombre, sappaterno, nsalario
FROM empleados
WHERE dpto_id = 1;

-- Ordenar los resultados agregamos ORDER BY nombre [ASC | DESC]

SELECT ci_id, snombre, sappaterno, nsalario
FROM empleados
WHERE dpto_id = 1
ORDER BY nsalario DESC;


-- ver el salario de empleados de Sistemas mayor a 1000 Bs.
SELECT ci_id, snombre, sappaterno, nsalario, dpto_id
FROM empleados
WHERE dpto_id = 4 OR (nsalario > 1000 AND nsalario < 2000);


-- UPDATE - Aumentar un 20% al salario de todos los empleados que son controlados por algun supervisor
UPDATE empleados
SET nsalario = nsalario + (nsalario  * 0.2) 
WHERE supervisor_id IS NOT NULL;

-- VISUALIZAR EL INCREMENTO DEL 20% - RENOMBRAR COLUMNAS
SELECT ci_id, snombre, sappaterno, nsalario, (nsalario * 0.2) AS incremento ,nsalario * 1.2 AS total
FROM empleados
WHERE supervisor_id IS NOT NULL;


-- SQL - Obtener todos los empleados nacidos entre 1995 y 2002
select ci_id, snombre, sappaterno, dtNacimiento
 from empleados
 where dtNacimiento >= '1995-01-01' and dtNacimiento < '2003-01-01';

select ci_id, snombre, sappaterno, dtNacimiento
 from empleados
 where dtNacimiento BETWEEN '1995-01-01' AND '2003-01-01';


-- LIKE -- BUSCAR FRAGMENTOS EN TEXTO
SELECT * FROM empleados WHERE sappaterno LIKE 'A%';
SELECT * FROM empleados WHERE sappaterno LIKE '%A%';
SELECT * FROM empleados WHERE sappaterno NOT LIKE '%A%';


-- COMBINACION DE TABLAS
-- 1) Producto cartesiano
SELECT empleados.ci_id, empleados.snombre, empleados.dpto_id, departamentos.numero_id ,departamentos.snombre
FROM empleados, departamentos
WHERE empleados.dpto_id = departamentos.numero_id;

SELECT E.ci_id, E.snombre, E.dpto_id, D.numero_id ,D.snombre
FROM empleados E, departamentos D
WHERE E.dpto_id = D.numero_id;

SELECT E.ci_id, E.snombre, E.dpto_id, D.numero_id ,D.snombre
FROM empleados E JOIN departamentos D ON E.dpto_id = D.numero_id;

-- Obtener todos los empleados que pertenecen al departamento de 'Sistemas'
SELECT E.ci_id, E.snombre, E.dpto_id, D.numero_id ,D.snombre
FROM empleados E, departamentos D
WHERE E.dpto_id = D.numero_id AND D.snombre = 'sistemas';

SELECT E.ci_id, E.snombre, E.dpto_id, D.numero_id ,D.snombre
FROM empleados E JOIN departamentos D ON E.dpto_id = D.numero_id
WHERE D.snombre = 'Sistemas';


-- 2) JOIN

-- Obtener todos los empleados del departamento de sistemas que trabajan en algun proyecto
SELECT A.ci_id, A.snombre, A.dpto_id, B.proyecto_id 
FROM empleados A 
JOIN trabajos B on A.ci_id = B.empleado_id 
WHERE A.dpto_id = 1;

select E.ci_id, E.snombre, E.dpto_id,D.numero_id ,D.snombre, T.proyecto_id 
FROM empleados E, trabajos T, departamentos D 
WHERE E.dpto_id = D.numero_id and E.ci_id=T.empleado_id AND D.snombre = 'sistemas' ;

select E.snombre, E.sappaterno, D.snombre as Departamento
from empleados E 
Join trabajos T on E.ci_id = T.empleado_id
Join Departamentos D on E.dpto_id = D.numero_id 
where D.snombre = 'Sistemas';

-- Obtener todos los empleados del departamento de sistemas que trabajan en algun proyecto
-- con las siguientes cabeceras (CI, nombre, apellido, nombre_dpto, nombre_proyecto)
select E.ci_id, CONCAT(E.snombre,' ', E.sappaterno) as empleado, D.snombre as Departamento, P.snombre as proyecto
from empleados E 
Join trabajos T on E.ci_id = T.empleado_id
Join Departamentos D on E.dpto_id = D.numero_id 
JOIN proyectos P ON P.numero_id=T.proyecto_id
JOIN familiares F ON F.empleado_id=E.ci_id
where D.snombre = 'Sistemas';

-- Obtener todos los empleados que trabajan en algun proyecto que NO pertenecen al departamento de sistemas
-- con las siguientes cabeceras (CI, nombre, apellido, nombre_dpto, nombre_proyecto)

select E.ci_id, CONCAT(E.snombre,' ', E.sappaterno) as empleado, D.snombre as Departamento, P.snombre as proyecto
from empleados E 
Join trabajos T on E.ci_id = T.empleado_id
Join Departamentos D on E.dpto_id = D.numero_id 
JOIN proyectos P ON P.numero_id=T.proyecto_id
JOIN familiares F ON F.empleado_id=E.ci_id
where D.snombre <> 'Sistemas';


-- EXCLUIR DATOS --> NOT IN, NOT EXISTS, LEFT|RIGHT JOIN
-- Obtener todos los empleados que trabajan en algun proyecto que NO tienen familiares
-- con las siguientes cabeceras (CI, nombre, apellido, nombre_dpto, nombre_proyecto)

-- NOT IN --> eliminar registros en base a una lista

SELECT * FROM empleados WHERE ci_id NOT IN (2,4,5,7);

-- empleados que no tienen familiares
SELECT * FROM empleados
WHERE ci_id NOT IN (SELECT empleado_id FROM familiares)

select E.ci_id, CONCAT(E.snombre,' ', E.sappaterno) as empleado, P.snombre as proyecto
from empleados E 
Join trabajos T on E.ci_id = T.empleado_id
JOIN proyectos P ON P.numero_id=T.proyecto_id
WHERE E.ci_id NOT IN (SELECT empleado_id FROM familiares);

--EJEMPLO NOT IN
--  -- OBTENER TODOS LOS EMPLEADOS QUE NO TRABAJAN EN UN PROYECTO
SELECT * FROM empleados E
WHERE E.ci_id NOT IN (SELECT empleado_id FROM trabajos);

-- NOT EXISTS
SELECT * FROM empleados E
WHERE NOT EXISTS (SELECT * FROM trabajos WHERE empleado_id=E.ci_id);

-- JOINS
-- INNER JOIN
SELECT E.ci_id, CONCAT(E.snombre,' ',E.sappaterno) as empleado, E.dpto_id, D.numero_id, D.snombre as departamento
FROM empleados E JOIN departamentos D ON E.dpto_id = D.numero_id;

-- LEFT JOIN - RIGHT JOIN
SELECT E.ci_id, CONCAT(E.snombre,' ',E.sappaterno) as empleado, E.dpto_id, D.numero_id, D.snombre as departamento
FROM empleados E LEFT JOIN departamentos D ON E.dpto_id = D.numero_id;

SELECT E.ci_id, CONCAT(E.snombre,' ',E.sappaterno) as empleado, E.dpto_id, D.numero_id, D.snombre as departamento
FROM empleados E LEFT JOIN departamentos D ON E.dpto_id = D.numero_id
WHERE D.numero_id IS NULL;


-- DISTINCT - ELIMINAR DUPLICADOS
SELECT DISTINCT empleado_id FROM trabajos order by 1 asc;

-- FUNCIONES (COUNT, SUM, MAX, MIN, AVG)
-- COUNT
SELECT COUNT(*) FROM empleados;


-- Mostrar el total de empleados por departamento ( formato: nombre_dpto, total_empleados)
SELECT dpto_id, COUNT(*) 
FROM empleados
GROUP BY dpto_id;

SELECT D.snombre as nombre_dpto, COUNT(*) as total_empleados
FROM empleados E LEFT JOIN departamentos D ON E.dpto_id = D.numero_id
GROUP BY D.numero_id;

SELECT COALESCE(D.snombre,'- -ninguno- -') as nombre_dpto, COUNT(*) as total_empleados
FROM empleados E LEFT JOIN departamentos D ON E.dpto_id = D.numero_id
GROUP BY D.numero_id;


-- Obtener el total de sueldos por departamento, el formato debe indicar el codigo del departamento,
-- el nombre de departamento y el total de salarios pagados. 

SELECT D.snombre as departamento, SUM(nsalario)
FROM empleados E JOIN departamentos D ON E.dpto_id=D.numero_id
GROUP BY D.numero_id

SELECT D.snombre, X.total
FROM departamentos D JOIN (
    SELECT dpto_id,SUM(nsalario) as total
    FROM empleados
    GROUP BY dpto_id ) X
ON D.numero_id = X.dpto_id

-- TOTAL DE SUELDOS POR DEPARTAMENTO ENTRE 3000 y 7000 Bs.

SELECT D.snombre as departamento, SUM(nsalario)
FROM empleados E JOIN departamentos D ON E.dpto_id=D.numero_id
GROUP BY D.numero_id
HAVING SUM(nsalario) BETWEEN 3000 AND 7000


SELECT D.snombre, X.total
FROM departamentos D JOIN (
    SELECT dpto_id,SUM(nsalario) as total
    FROM empleados
    GROUP BY dpto_id ) X
ON D.numero_id = X.dpto_id
WHERE X.total > 3000 AND X.total < 7000

-- Obtener el nombre y apellido de cada empleado, e indicar el total de empleados a su cargo.

SELECT CONCAT(S.snombre,' ',S.sappaterno) as supervisor, CONCAT(E.snombre,' ',E.sappaterno) as empleado
FROM empleados S JOIN empleados E ON S.ci_id = E.supervisor_id;

-- Cuenta los registros, incluidos los que no supervisan a nadie
SELECT CONCAT(S.snombre,' ',S.sappaterno) as supervisor, COUNT(*)
FROM empleados S LEFTJOIN empleados E ON S.ci_id = E.supervisor_id
GROUP BY CONCAT(S.snombre,' ',S.sappaterno);

-- Al hacer la funcion COUNT en una columna, si encuentra valores nulos, los contará como 0
SELECT CONCAT(S.snombre,' ',S.sappaterno) as supervisor, COUNT(E.ci_id)
FROM empleados S LEFT JOIN empleados E ON S.ci_id = E.supervisor_id
GROUP BY CONCAT(S.snombre,' ',S.sappaterno);


SELECT CONCAT(S.snombre,' ',S.sappaterno) as supervisor, COUNT(E.ci_id)
FROM empleados S LEFT JOIN empleados E ON S.ci_id = E.supervisor_id
GROUP BY CONCAT(S.snombre,' ',S.sappaterno)
HAVING COUNT(E.ci_id) >= 2;

-- MAX, MIX, AVG

SELECT MAX(nsalario) FROM empleados;
-- Obtener los datos del empleado con el salario máximo

SELECT *
FROM empleados
WHERE nsalario = (SELECT MAX(nsalario) FROM empleados);

-- Saber los empleados que tienen un sueldo mayor al promedio

SELECT *
FROM empleados
WHERE nsalario > (SELECT AVG(nsalario) FROM empleados);
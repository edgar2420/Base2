--1) Adicionar una restricción check en la tabla tasa_cambios para que no permita el registro
--de valores negativos.
SELECT * FROM tasa_cambios;
ALTER TABLE tasa_cambios add constraint check_tasacambio check (valor > 1);
--2) Crear un procedimiento almacenado para iniciar una nueva gestión(numero), al
--momento de crear la nueva gestión, las otras gestiones deberán pasar a un estado inactivo,
--siendo la nueva gestión la única activa
CREATE OR REPLACE FUNCTION nuevagestion(p_codigo integer, p_fecha date, p_moneda character, e_moneda numeric) 
RETURNS void AS
$BODY$
BEGIN
INSERT INTO gestiones VALUES(2021,true);
END;
$BODY$
LANGUAGE plpgsql;
--3) Crear un procedimiento almacenado para ingresar una tasa de cambio (moneda, valor),
--la fecha será asignada por el sistema
SELECT * FROM tasa_cambios;
CREATE OR REPLACE FUNCTION InsertarCambio(p_codigo integer, p_fecha date, p_moneda character, p_valor numeric)
RETURNS void AS
$BODY$
BEGIN
INSERT INTO tasa_cambio values(p_codigo, p_fecha,p_valor);
END;
$BODY$
LANGUAGE plpgsql;
--4) Crear una tabla de log genérica para recibir datos de cualquier tabla(tabla, fecha, usuario, dato)
--y crear un procedimiento almacenado que permita el registro y/o actualización de
--monedas en el sistema, el procedimiento almacenado deberá capturar los cambios que se
--realizaron en la tabla de monedas
CREATE TABLE generica_logs (
tabla SERIAL NOT NULL PRIMARY KEY,
fecha DATE,
usuario VARCHAR,
dato VARCHAR	
);
SELECT * FROM monedas;
CREATE OR REPLACE FUNCTION monedas(e_simbolo TEXT, e_nombre TEXT)
RETURNS void AS
$BODY$
BEGIN
-- verificar si existe el registro
IF NOT EXISTS (SELECT * FROM monedas where e_simbolo = e_simbolo)  THEN
-- insertar
INSERT INTO monedas values(e_simbolo,e_nombre);
ELSE
--actualizar
INSERT INTO monedas values(e_simbolo,e_nombre);
END IF;
END;
$BODY$
LANGUAGE plpgsql;
--5) Crear una función para obtener el valor de tasa más reciente de la moneda indicada
--(moneda)
CREATE OR REPLACE FUNCTION valorreciente(e_simbolo TEXT, e_nombre TEXT)
RETURNS void AS
$BODY$
BEGIN
SELECT simbolo,nombre,MAX(nombre) nombre FROM monedas
GROUP BY simbolo,nombre
ORDER BY simbolo;
END;
$BODY$
LANGUAGE plpgsql;
--6) Crear una función para convertir el valor de una moneda a otra, es decir, de Bs a $us o
--viceversa (moneda, moneda). Tomar en cuenta que la moneda base del sistema es en "Bs."
--y todas las conversiones son de esta moneda al tipo de moneda registrado
CREATE OR REPLACE FUNCTION convertir (monedaA numeric(8,5), monedaB TEXT, monedaC TEXT)
RETURNS numeric (8,5) AS
$$
DECLARE
monedaA numeric(8,5);
monedaB numeric (8,5);
monedaC numeric (8,5);
BEGIN
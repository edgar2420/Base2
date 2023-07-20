--Crear una función que genere un código único para los usuarios basándose en la fecha 
--y hora de creación del usuario según el siguiente formato:
--Últimos dos dígitos del año - tres primeras letras del nickname - dos dígitos de mes -
--inicial del nombre - dos dígitos de día - inicial de apellido 
create or replace function generar_codigo(
	p_fecha date,
	p_nickanme text,
	p_nombre text,
	p_dia date,
	p_apellido text
	) returns text as 
$$
declare 
	v_resultado text;

begin 	
	select UPPER(concat( to_char(p_fecha,'YY'), '-', 
	left(p_nickname,3),'-', to_char(p_fecha,'MM'),'-', 
	left(p_nombre,1),'-', to_char(p_fecha,'DD'), left(p_apellido,1))) 
	into v_resultado;
	
	return v_resultado;
end;
$$
language plpgsql;
--Crear una vista “login_daylies” que indique el total de incidentes de cualquier tipo
--registrados por día de semana, sin importar el mes y el año 
CREATE VIEW login_daylies AS
SELECT COUNT(*) AS total, DAYNAME(date) AS day
FROM login
GROUP BY DAYNAME(date)
ORDER BY total DESC;
--Crear una vista “login_total” que indique el total de inicios de sesión o logins por tipo 
--de incidente, agrupados por mes(incluir los meses que no tengan registros)
CREATE VIEW login_total AS
SELECT COUNT(*) AS total, type
FROM login
GROUP BY type
ORDER BY total DESC;
-- Crear un procedimiento almacenado (SP) para registrar o actualizar un usuario bajo las 
--siguientes condiciones:
--a. Si el código existe, actualizar los datos exceptuando el nickname y la fecha de 
--creación(fecha_creacion)
--b. Si el código no existe, registrar el usuario verificando que no exista ese nickname, 
--en caso de existir, enviar una excepción indicando que el nombre de usuario ya 
--se encuentra en uso.
--c. El procedimiento almacendo deberá recibir como parametros el nickname, nombre completo(nombre, apellido)
--email y contraseña.
--d. La fecha de creación, el codigo y el estado activo deben ser asignados automaticamente
create or replace function update_user(
	p_codigo_id text,    p_nickname text, p_password text,
    p_nombre text,    p_email text, p_dtcreacion date, p_activo boolean) 
	returns void as 
$$
begin 	
	update usuarios
	set codigo_id = p_codigo_id,
		snickname = p_nickname,
		spassword = p_password,
		snombre = p_nombre,
		sapellido = p_apellido,
		email = p_email,
		fecha_creacion = p_dtcreacion,
		activo = p_activo
	where p_codigo_id = codigo_id;
end;
$$
language plpgsql;
********************************************************************************************************************
CREATE OR REPLACE FUNCTION registrar_update(
    p_codigo_id text,    p_nickname text, p_password text,
    p_nombre text,    p_email text, p_dtcreacion date, p_activo boolean)
  RETURNS void AS
$BODY$
BEGIN
	IF NOT EXISTS(SELECT * FROM usuarios WHERE codigo_id = p_codigo_id) THEN
		INSERT INTO usuario VALUES (p_codigo_id, p_nickname, p_password, p_snombre,p_apellido, p_email, p_dtcreacion, p_activo);
		update usuarios set spassword where codigo_id = p_codigo_id;
		
	ELSE
		SELECT update_user(p_codigo_id,p_nickname, p_password, p_nombre ,p_email , p_dtcreacion, p_activo);
		update usuarios set spassword where codigo_id = p_codigo_id;
	END IF;
END;
$BODY$
  LANGUAGE plpgsql ;
--Adicionar una restricción a la tabla “login_logs” para que en la columna incident_type
--solamente se acepten los valores ‘Acceso’, ‘Error’ y ‘Disabled’.
select * from login_logs 
ALTER TABLE login_logs  
ADD CONSTRAINT check_login CHECK(UPPER(incident_type) IN ('Acceso','Error','Disable'));
--3) Crear una función de autenticar usuarios recibiendo como parámetros el nombre de
--usuario (nickname) y la contraseña. La función deberá verificar si el usuario existe y se
--encuentra activo.
--a. Si los parámetros son correctos indicar que el inicio de sesión fue exitoso y
--registrar 'Acceso' en la tabla “login_logs” junto a los campos requeridos.
--b. En caso que los datos sean correctos pero el usuario este inactivo se deberá
--registrar en la tabla “login_logs” el valor 'Disabled'.
--c. Si los datos son incorrectos registrar 'Error' en la tabla de logs.
--En los últimos dos casos la función deberá enviar una excepción indicando que el usuario
--esta inactivo o que los datos son erróneos.
CREATE OR REPLACE function InicioSesion(
     e_codigo_id text,
     e_nickname text, 
     e_password text)
  RETURNS void AS
$BODY$
BEGIN
	-- Verificar si existe el registro
	IF NOT EXISTS(SELECT * FROM usuarios WHERE e_nickname = snickname) THEN
	RAISE EXCEPTION 'EL usuario no existe'
		 USING HINT = 'Verificar los datos que ingresó';
	
	ELSE
		INSERT INTO login_logs VALUES (current_date,e_nickname,'Acceso');
		RAISE NOTICE 'Iniciaste correctamente :3';
	END IF;
	
	IF (SELECT * FROM usuarios WHERE e_nickname = snickname AND activo = false) THEN
		INSERT INTO login_logs VALUES (current_date,e_nickname,'Disabled');
		RAISE EXCEPTION 'Datos correctos pero se encuentra inactivo'
		 USING HINT = 'Verificar los datos que ingresó';
	END IF;
	
IF (SELECT * FROM usuarios WHERE e_nickname = snickname AND e_password <> spassowrd) THEN
		INSERT INTO login_logs VALUES (current_date,p_nickname,'Error');
		RAISE EXCEPTION 'El usuario o la contraseña no son correctos'
		 USING HINT = 'Revisar datos';
		
	END IF;
END;
$BODY$
  LANGUAGE plpgsql;




    

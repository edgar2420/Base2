--Proyecto

--Insertar repartidor SP
create extension pgcrypto

CREATE OR REPLACE FUNCTION ins_repartidor(
	r_ci_id int,
	r_nombre VARCHAR(30),
	r_apellido VARCHAR(30),
	r_telefono int,
	 r_contraseña text,
	r_dt_nacimiento date,
	r_modelo varchar(20),
	r_placa varchar(15),
	r_marca varchar(20)
)returns void as
$BODY$
BEGIN
	if exists(select * from repartidor where ci_id = r_ci_id) then
		--actualizar
		update repartidor set contraseña = crypt(r_contraseña, gen_salt('bf')), nombre = r_nombre,
		apellido = r_apellido, telefono = r_telefono, dt_nacimiento = r_dt_nacimiento, modelo = r_modelo, placa = r_placa, marca = r_marca where ci_id = r_ci_id;
	elsif not exists(select * from repartidor where ci_id = r_ci_id) then
			insert into repartidor values(r_ci_id, ,r_nombre, r_apellido, r_telefono, crypt(r_contraseña, gen_salt('bf')), r_dt_nacimiento, false, r_modelo, r_placa, r_marca);
		end if;
END;
$BODY$
LANGUAGE plpgsql; 
--Update repartidor SP
create or replace function upd_repartidor_estado(r_ci_id int)
RETURNS void AS
$BODY$
BEGIN
	IF (SELECT estado FROM repartidor WHERE estado = false and ci_id = r_ci_id) = false THEN
		UPDATE repartidor SET estado = true where ci_id =r_ci_id;
	ELSIF(SELECT estado FROM repartidor WHERE estado = true and ci_id = r_ci_id) = true THEN
		UPDATE repartidor SET estado = false where ci_id =r_ci_id;
	END IF;
END;
$BODY$
LANGUAGE plpgsql;

select upd_repartidor_estado(8994168);

--Actualizar vehiculo de repartidor

CREATE OR REPLACE FUNCTION upd_repartidor_vehiculo(
	r_ci_id int,
	r_modelo varchar(20),
	r_placa varchar(15),
	r_marca varchar(20)
)RETURNS void AS
$$
BEGIN
	UPDATE repartidor set modelo = r_modelo, placa = r_placa, marca = r_marca where ci_id = r_ci_id;
END;
$$
LANGUAGE plpgsql;

--Trigger

CREATE OR REPLACE FUNCTION logger_repartidor()
RETURNS TRIGGER AS
$$
BEGIN
	IF TG_OP = 'INSERT' THEN
		INSERT INTO repartidor_logs VALUES(DEFAULT,current_timestamp,NEW.ci_id,NEW.nombre,NEW.apellido,NEW.modelo,NEW.placa,NEW.marca);
	ELSIF TG_OP = 'UPDATE' THEN
		INSERT INTO repartidor_logs VALUES(DEFAULT,current_timestamp,NEW.ci_id,NEW.nombre,NEW.apellido,NEW.modelo,NEW.placa,NEW.marca);
	END IF;
  RETURN OLD;
END;
$$
LANGUAGE plpgsql;


 CREATE TRIGGER logs_vehiculo
 AFTER INSERT OR UPDATE ON repartidor
 FOR EACH ROW
 EXECUTE PROCEDURE logger_repartidor();

 --Insertar Cliente

 CREATE OR REPLACE FUNCTION ins_cliente(
	c_ci_id int,
	c_nombres varchar(30),
	c_apellidos varchar(30),
	c_telefono int,
	c_contraseña text
)returns void as
$BODY$
BEGIN
	if exists(select * from clientes where ci_id = c_ci_id) then
		--actualizar
		update clientes set contraseña = crypt(c_contraseña, gen_salt('bf')), nombres = c_nombres,
		apellidos = c_apellidos where ci_id = c_ci_id;
	elsif not exists(select * from clientes where ci_id = c_ci_id) then
			insert into clientes values(c_ci_id, c_nombres, c_apellidos, c_telefono, crypt(c_contraseña, gen_salt('bf')));
		end if;
END;
$BODY$
LANGUAGE plpgsql; 

--Autenticar

CREATE OR REPLACE FUNCTION autenticar (text,text)
RETURNS TEXT AS
$$
BEGIN
IF EXISTS (SELECT * FROM clientes WHERE nombres=$1 AND contraseña = crypt($2,contraseña))THEN
	RETURN 'Inicio de sesión correcto';
ELSE
	RAISE EXCEPTION 'USario y/o contraseña incorrectos';
	END IF;
END
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION autenticarRepartidor (text,text)
RETURNS TEXT AS
$$
BEGIN
IF EXISTS (SELECT * FROM repartidor WHERE nombre=$1 AND contraseña = crypt($2,contraseña))THEN
	RETURN 'Inicio de sesión correcto';
ELSE
	RAISE EXCEPTION 'USario y/o contraseña incorrectos';
	END IF;
END
$$
LANGUAGE plpgsql;


-- Trigger validacion clientes
CREATE OR REPLACE FUNCTION validar_clientes()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.ci_id IS NULL THEN
	raise exception 'El C.I no puede ser nulo';
	END IF;
	
	IF NEW.nombres !~* '^([A-Z]{1}[a-zñáéíóú]+[\s]*)+$' THEN
	raise exception 'Solo se pueden introducir letras en el nombre';
	END IF;
	
	IF NEW.apellidos !~* '^([A-Z]{1}[a-zñáéíóú]+[\s]*)+$' THEN
	raise exception 'Solo se pueden introducir letras de apellidos';
	END IF;
	
	IF NEW.telefono IS NULL THEN
	raise exception 'telefono no puede ser nulo';
	END IF;

RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER validar_clientes
 BEFORE INSERT OR UPDATE ON clientes
 FOR EACH ROW
 EXECUTE PROCEDURE validar_clientes();

--TRIGGER VALIDACION REPARTIDOR
CREATE OR REPLACE FUNCTION validar_repartidor()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.ci_id IS NULL THEN
	raise exception 'El C.I no puede ser nulo';
	END IF;
	
	IF NEW.nombre !~* '^([A-Z]{1}[a-zñáéíóú]+[\s]*)+$' THEN
	raise exception 'Solo se pueden introducir letras en el nombre';
	END IF;
	
	IF NEW.apellido !~* '^([A-Z]{1}[a-zñáéíóú]+[\s]*)+$' THEN
	raise exception 'Solo se pueden introducir letras de apellidos';
	END IF;
	
	IF NEW.telefono IS NULL THEN
	raise exception 'telefono no puede ser nulo';
	END IF;
	
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

 CREATE TRIGGER validar_repartidor
 BEFORE INSERT OR UPDATE ON repartidor
 FOR EACH ROW
 EXECUTE PROCEDURE validar_repartidor();


SELECT S.nombre, U.descripcion, P.detalle
FROM sucursal S, ubicacion U, pedido_factura P
where S.id_sucursal = P.sucursal_id and U.ubicacion_id = P.ubicacion_id


 

/*CREATE OR REPLACE FUNCTION iniciarSesion(text, text)
RETURNS TEXT AS
$$
DECLARE
	v_cliente int;
	v_repartidor int;
BEGIN
	
	SELECT ci_id INTO v_cliente FROM clientes WHERE nombres = $1;
	SELECT ci_id INTO v_repartidor FROM repartidor WHERE nombre = $1;
	
	IF EXISTS (SELECT * FROM clientes WHERE ci_id = v_cliente) THEN
		SELECT autenticar($1, $2);
		RETURN 'Cliente';
	ELSIF EXISTS (SELECT * FROM repartidor WHERE ci_id = v_repartidor) THEN
		SELECT autenticarRepartidor($1, $2);
		RETURN 'Repartidor';
	END IF;
	
END
$$
LANGUAGE plpgsql;*/
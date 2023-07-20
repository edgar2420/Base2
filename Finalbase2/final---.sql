--final--

--1--
CREATE OR REPLACE FUNCTION ver_listasPEP()
RETURNS TRIGGER AS
$$
	BEGIN
	
		if exists(select * from pep.tblclientes P, tblclientes C where P.snit = C.snit and P.snombre = C.snombre) then
			RAISE EXCEPTION 'Usuario esta en observación';	
			return old;
		end if;
		return new;
	END;
$$
LANGUAGE plpgsql;

 CREATE TRIGGER verificar_cliente
 AFTER INSERT on tblpolizas
 FOR EACH ROW
 EXECUTE PROCEDURE ver_listasPEP();


 CREATE USER base2 PASSWORD 'base2';
grant all privileges on schema public to base2


create schema pep;

CREATE EXTENSION postgres_fdw;

CREATE SERVER svr_remoto
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS(host '127.0.0.1', port'5432', dbname'PEP')

CREATE USER MAPPING FOR postgres
server svr_remoto OPTIONS(user'base2',password'base2')

IMPORT FOREIGN SCHEMA public
FROM SERVER svr_remoto INTO pep;

create user uif password 'root'

CREATE EXTENSION postgres_fdw

CREATE SERVER svr_remoto2
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS(host '127.0.0.1', port'5432', dbname'FINAL')

CREATE USER MAPPING FOR postgres
server svr_remoto2 OPTIONS(user'base2',password'base2')

CREATE SCHEMA dbfinal;

IMPORT foreign schema public

FROM SERVER svr_remoto2 INTO dbfinal;







--3--
CREATE TABLE pass_logs(
    log_id SERIAL PRIMARY KEY,
	dtoperacion TIMESTAMP,
	user_name varchar(30),
	operación varchar(30)
);

CREATE OR REPLACE FUNCTION log_password()
RETURNS TRIGGER AS
$$
BEGIN
	IF TG_OP = 'UPDATE' THEN
		INSERT INTO pass_logs VALUES(DEFAULT,current_timestamp, NEW.scuenta,TG_OP);
	END IF;
  RETURN OLD;
END;
$$
LANGUAGE plpgsql;

 CREATE TRIGGER logs_pass
 AFTER INSERT OR UPDATE ON tblusuarios
 FOR EACH ROW
 EXECUTE PROCEDURE log_password();


 CREATE OR REPLACE FUNCTION autenticar (text,text)
RETURNS TEXT AS
$$
BEGIN
IF EXISTS (SELECT * FROM tblusuarios WHERE scuenta=$1 AND spassword = crypt($2,spassword))THEN
	RETURN 'Inicio de sesión correcto';
ELSE
	RAISE EXCEPTION 'USario y/o contraseña incorrectos';
	END IF;
END
$$
LANGUAGE plpgsql;






CREATE USER base2 PASSWORD 'base2';
grant all privileges on schema public to base2


create schema pep;

CREATE EXTENSION postgres_fdw;

CREATE SERVER svr_remoto
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS(host '127.0.0.1', port'5432', dbname'PEP')

CREATE USER MAPPING FOR postgres
server svr_remoto OPTIONS(user'base2',password'base2')

IMPORT FOREIGN SCHEMA public
FROM SERVER svr_remoto INTO pep;



CREATE OR REPLACE FUNCTION ver_listasPEP()
RETURNS TRIGGER AS
$$
	BEGIN
	
		if exists(select * from pep.tblclientes P, tblclientes C where P.snit = C.snit and P.snombre = C.snombre) then
			RAISE EXCEPTION 'Usuario esta en observación';	
			return old;
		end if;
		return new;
	END;
$$
LANGUAGE plpgsql;

 CREATE TRIGGER verificar_cliente
 AFTER INSERT on tblpolizas
 FOR EACH ROW
 EXECUTE PROCEDURE ver_listasPEP();
 
select * from tblpolizas values

 insert into tblpolizas(default, 4, 6, 'asdf1', 'test',2014-09-15, 2021-07-15, 1563, 150, 162.36, 1231, 2, 2, null, 5, false, current_timestamp, current_timestamp,1, 'asdf', 'asdf', 200)


select * 
from pep.tblclientes P, tblclientes C, tblpolizas A
where P.snit = C.snit and P.snombre = C.snombre

select * from tblclientes where snit ='7848411'

select * from tblpolizas order by cliente_id asc

insert into tblpolizas values(default, )
select * from tblclientes


CREATE TABLE pass_logs(
    log_id SERIAL PRIMARY KEY,
	dtoperacion TIMESTAMP,
	user_name varchar(30),
	operación varchar(30)
);

CREATE OR REPLACE FUNCTION log_password()
RETURNS TRIGGER AS
$$
BEGIN
	IF TG_OP = 'UPDATE' THEN
		INSERT INTO pass_logs VALUES(DEFAULT,current_timestamp, NEW.scuenta,TG_OP);
	END IF;
  RETURN OLD;
END;
$$
LANGUAGE plpgsql;

 CREATE TRIGGER logs_pass
 AFTER INSERT OR UPDATE ON tblusuarios
 FOR EACH ROW
 EXECUTE PROCEDURE log_password();
 
 select * from pass_logs
 
 update tblusuarios set spassword = 'root' where codigo_id = 4

select * from tblusuarios

CREATE OR REPLACE FUNCTION autenticar (text,text)
RETURNS TEXT AS
$$
BEGIN
IF EXISTS (SELECT * FROM tblusuarios WHERE scuenta=$1 AND spassword = crypt($2,spassword))THEN
	RETURN 'Inicio de sesión correcto';
ELSE
	RAISE EXCEPTION 'USario y/o contraseña incorrectos';
	END IF;
END
$$
LANGUAGE plpgsql;

/*Asignar automáticamente el numero de boleta de manera correlativa según el tipo de boleta (planilla, nota cobranza, factura)*/
CREATE OR REPLACE FUNCTION asignar_numero_boleta()
RETURNS TRIGGER AS
$$
	BEGIN
		IF TG_OP = 'INSERT' THEN
			IF NEW.tipo_boleta = 'Planilla' THEN
				NEW.numero_boleta = (SELECT MAX(nro_boleta) FROM contable_gastos WHERE nro_boleta = 'Planilla') + 1;
			ELSIF NEW.tipo_boleta = 'Nota de cobranza' THEN
				NEW.numero_boleta = (SELECT MAX(nro_boleta) FROM contable_gastos WHERE nro_boleta = 'Nota de cobranza') + 1;
			ELSIF NEW.tipo_boleta = 'Factura' THEN
				NEW.numero_boleta = (SELECT MAX(nro_boleta) FROM contable_gastos WHERE nro_boleta = 'Factura') + 1;
			END IF;
		END IF;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

/*Eliminar la posibilidad de “eliminar registros”, solamente pueden darse de baja o ser anulados los registros por medio del “estado” (borrado lógico)*/
CREATE OR REPLACE FUNCTION eliminar_registro()
RETURNS TRIGGER AS
$$
	BEGIN
		IF TG_OP = 'DELETE' THEN
			RAISE EXCEPTION 'No se puede eliminar el registro';
		END IF;
		RETURN OLD;
	END;
$$
LANGUAGE plpgsql;
/*Adicionar la funcionalidad del registro automático en la tabla de gastos una vez la solicitud pasa a ser aprobada*/
CREATE OR REPLACE FUNCTION registrar_gasto()
RETURNS TRIGGER AS
$$
	BEGIN
		IF TG_OP = 'UPDATE' THEN
			IF NEW.estado = 'Aprobado' THEN
				INSERT INTO contable_solicitudpago VALUES(DEFAULT, NEW.create_at, NEW.update_at, NEW.tipo_gasto, NEW.total_gasto, NEW.total_pago_id, NEW.tramite_id, NEW.detalle, NEW.nro_boleta, NEW.estado);
			END IF;
		END IF;
		RETURN NEW;
	END;
$$
LANGUAGE plpgsql;

/*En base a los registros existentes, indicar cuanto es el tiempo promedió que hay entre el registro de una solicitud y su gasto asociado*/
SELECT AVG(fecha - tipo_solicitud) FROM contable_solicitudpago;

/*) Contar con una vista que indique los gastos desglosados de cada trámite de manera horizontal,*/
CREATE OR REPLACE VIEW vw_gastos_tramite AS
SELECT
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'TRAMITE') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'ALBO PAMPA') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'ALBO TAMBO QUEMADO') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'ALBO WARNES') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'DAB ALBO WARNES') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'PAGO DE TRIBUTOS') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'REEMBOLSO GATOS DESPACHO') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'SENASAG') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'SERVICIODAM') AS contable_gastos,
	(SELECT COUNT(*) FROM contable_gastos WHERE tipo_gasto = 'SERVICIO RESGUARDADO') AS contable_gastos
FROM contable_gastos;

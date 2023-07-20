--1) Se desea desarrollar un Trigger que al momento de registrar una póliza en la base de datos FINAL
--se conecte a la base de datos de la UIF y verifique en las listas PEP la existencia del cliente, en caso
--de encontrarse el cliente en la lista, el Trigger debe devolver un error o advertencia al momento de
--registrar indicando que ese cliente se encuentra en las listas y está en observación. Considerar que
--las personas registradas pueden variar su NIT o su nombre, pero no ambas.
----------------------------------------------------------------------------------------------------------------
Create extension postgres_fdw;
Create server svr_remoto_final
foreign data wrapper postgres_fdw
options (host '127.0.0.1', port '5432', dbname 'UIF');

create user mapping for postgres 
server svr_remoto_final options(user 'postgres', password '2424');

import foreign schema public
from server svr_remoto_final into pep;


CREATE OR REPLACE FUNCTION ver_listaPEP()
RETURNS TRIGGER AS
$$
BEGIN
      if exists (select * from pep_tblclientes P, tblClientes C where P.snit = snit and P.snombre = C.snombre)then
	  raise exception 'USUARIO EN OBSERBACION';
	  RETURN OLD;
END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER verificar_cliente
 AFTER INSERT ON tblpolizas
 FOR EACH ROW
 EXECUTE PROCEDURE ver_listaPEP();
---------------------------------------------------------------------------------------------------------------------------
--3) En la base de datos "LOCK" se requiere una función "vfy_usuario(cuenta text, passw text)" que
--cumpla la función de autenticar un usuario (verificar si el usuario existe y se encuentra activo):
--Si los parámetros son correctos se deberá retornar como resultado una tabla con los permisos de
--acceso asignados a ese usuario
-----------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ver_listaPEP()
RETURNS TRIGGER AS
$$
BEGIN
      if exists (select * from pep_tblclientes P, tblClientes C where P.snit = snit and P.snombre = C.snombre)then
	  raise exception 'USUARIO EN OBSERBACION';
	  RETURN OLD;
END IF;
RETURN NEW;
END;
$$
LANGUAGE plpgsql;
SELECT D.codigo_id as usuario,A.codigo_id as interfaz, B.sdescripcion as permisos, B.soperacion as permisos from tblinterfaces A 
join tblpermisos B ON A.codigo_id = B.interfaz_id
join tblroles C ON B.rol_id = C.codigo_id
join tblusuarios D ON C.codigo_id = D.rol_id
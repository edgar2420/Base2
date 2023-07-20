--Restaurar el respaldo de la base de datos Caso 1

--Analizar la estructura e indicar cual es el proposito de la base de datos

--Identificar los posibles modulos y segmentar en esquemas

--SE RESTAURO LA BASE DE DATOS Y TIENE 16 TABLAS, LA BASE DE DATOS SE TRATA DE SISTEMA DE ZONAS, TRABAJOS, EMPLEADOS, EQUIPOS, FORMULARIOS, USUARIOS, HORARIOS Y PERMISOS


CREATE EXTENSION postgres_fdw;
CREATE SERVER Caso1_BASE2
FOREIGN DATA WRAPPER postgres_fdw
OPTIONS(dbname 'Caso1', host '127.0.0.1');
CREATE USER MAPPING FOR current_user
SERVER Caso1_BASE2
OPTIONS(user 'postgres', password '2424');
IMPORT FOREIGN SCHEMA BASE2
FROM SERVER Caso1_BASE2 
INTO BASE2;
IMPORT FOREIGN SCHEMA BASE2 LIMIT TO(prmsistema,state)
FROM SERVER Caso1_BASE2 
INTO BASE2;
CREATE SCHEMA BASE2.prmsistema(
codigo_id int;
);

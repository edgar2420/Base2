---------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ins_sitios(
	p_codigo_id integer,
	p_sitio text)
    RETURNS void AS 
$BODY$
BEGIN 
	INSERT INTO tblsitios VALUES (p_codigo_id,p_sitio) ;  
END;
$BODY$
LANGUAGE plpgsql;
----------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION lista_usuarios()
    RETURNS SETOF tblusuarios AS
$BODY$
BEGIN  
 	RETURN QUERY SELECT * FROM tblusuarios WHERE bdeleted=false; 
END;
$BODY$
 LANGUAGE plpgsql
 ----------------------------------------------------------------------------------
 CREATE OR REPLACE FUNCTION delete_usuarios(
	p_codigo_id bigint,
	p_access_id integer)
RETURNS void AS 
$BODY$
BEGIN 
	UPDATE tblusuarios SET bdeleted=true, dcmodified=current_timestamp, access_id=p_access_id WHERE codigo_id=p_codigo_id;
END;
$BODY$
LANGUAGE plpgsql;
-------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION delete_formularios(
	p_codigo_id bigint,
	p_access_id integer)
    RETURNS void
   
AS $BODY$
BEGIN 
UPDATE tblformularios  
SET bdeleted=true, dcmodified=current_timestamp, access_id=p_access_id WHERE codigo_id=p_codigo_id;
END;
$BODY$;
LANGUAGE plpgsql;
--------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ins_prmzonas(
	p_codigo_id integer,
	p_subicacion text,
	p_idm integer,
	p_iuv integer,
	p_imzo integer,
	p_tipozona_id integer,
	p_iconcurrencia_id integer,
	p_bdeleted boolean,
	p_dtcreated timestamp without time zone,
	p_dcmodified timestamp without time zone,
	p_access_id integer)
    RETURNS integer
  

AS $BODY$
BEGIN  
INSERT INTO prmzonas(subicacion,idm,iuv,imzo,tipozona_id,iconcurrencia_id,bdeleted,dtcreated,dcmodified,access_id) 
VALUES (p_subicacion,p_idm,p_iuv,p_imzo,p_tipozona_id,p_iconcurrencia_id,p_bdeleted,p_dtcreated,p_dcmodified,p_access_id);  
END;
$BODY$
LANGUAGE plpgsql;
--------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ins_empleado(
	p_codigo text, p_nombre text, p_sci text, p_telefono text, p_direccion text,
	p_concurrencia int, p_deleted boolean, p_dtcreated date, p_modified date, p_acces_id int
) RETURNS void AS

$BODY$
BEGIN
	INSERT INTO tblempleados VALUES (p_codigo, p_nombre, p_sci, p_telefono, p_direccion, p_concurrencia, p_deleted,p_acces_id);

END;
$BODY$
LANGUAGE plpgsql;
--------------------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION ins_roles(
	p_codigo_id integer,
	p_snombre text,
	p_iestado_fl integer,
	p_iconcurrencia_id integer,
	p_bdeleted boolean,
	p_dtcreated text,
	p_dcmodified text,
	p_access_id integer)
    RETURNS void

AS $BODY$
DECLARE keyp INT;
  BEGIN
   INSERT INTO tblroles VALUES (p_codigo_id, p_snombre,p_iestado_fl,1,false,current_timestamp,current_timestamp,p_access_id);

	END;
$BODY$
 LANGUAGE plpgsql;
 --------------------------------------------------------------------------------------
 CREATE OR REPLACE FUNCTION delete_empleados(
	p_codigo_id bigint,
	p_access_id integer)
    RETURNS void AS 
$BODY$
BEGIN 
	UPDATE tblempleados 
	SET bdeleted=true,dcmodified=current_timestamp, access_id=p_access_id 
	WHERE codigo_id=p_codigo_id;
END;
$BODY$
LANGUAGE plpgsql;
 --------------------------------------------------------------------------------------
 CREATE OR REPLACE FUNCTION ins_equipos(
	p_codigo_id integer,
	p_snombre text,
	p_responsable_id integer,
	p_iconcurrencia_id integer,
	p_bdeleted boolean,
	p_dtcreated text,
	p_dcmodified text,
	p_access_id integer)
    RETURNS void AS


$BODY$
 BEGIN
   INSERT INTO tblequipos
   VALUES (p_codigo_id,p_snombre,p_responsable_id,p_iconcurrencia_id,p_bdeleted,current_timestamp,current_timestamp,p_access_id);
 END;
$BODY$
LANGUAGE plpgsql;
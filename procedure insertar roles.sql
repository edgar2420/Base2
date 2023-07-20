select * from tblempleados

CREATE OR REPLACE PROCEDURE mk_tblempleados(
p_codigo_id int,
p_snombre text,
p_sci text,
p_stelefono text,
p_sdireccion text
) AS
$$
BEGIN
IF NOT EXISTS(select * from tblempleados where codigo_id = p_codigo_id) then
call ins_empleado(p_codigo_id,p_snombre,p_sci,p_stelefono,p_sdireccion,3,true,current_timestamp,
				 current_timestamp,3);
ELSE
call upd_empleado(p_codigo_id,p_snombre,p_sci,p_stelefono,p_sdireccion,3,true,current_timestamp,
				 current_timestamp,3);
END IF;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE ins_empleado(
p_codigo_id int,
p_snombre text,
p_sci text,
p_stelefono text,
p_sdireccion text
)AS
$$
BEGIN
insert into tblempleados values(p_codigo_id,p_snombre,p_sci,p_stelefono,p_sdireccion,
							   2,false,current_timestamp,current_timestamp,0);
END
$$ LANGUAGE plpgsql;

call ins_empleado(90,'Jj','hola','78718908','ana barba');
select * from tblempleados

CREATE OR REPLACE PROCEDURE upd_empleado(
p_codigo_id int,
p_snombre text,
p_sci text,
p_stelefono text,
p_sdireccion text
)AS
$$
BEGIN
update tblempleados
set snombre = p_snombre, sci = p_sci, stelefono = p_stelefono, sdireccion = p_sdireccion,
iconcurrencia_id = 3, bdeleted = false, dtcreated = current_timestamp, dcmodified = current_timestamp,
access_id = 2
where codigo_id = p_codigo_id;
END
$$ LANGUAGE plpgsql;

call upd_empleado(6,'ch','124','45879','tahuichi');


CREATE OR REPLACE PROCEDURE ins_equipos(
p_codigo_id int,
p_snombre text,
p_responsable_id int
)AS
$$
BEGIN
IF NOT EXISTS(select * from tblequipos where codigo_id = p_codigo_id) THEN
RAISE EXCEPTION 'Responsable NO VÁLIDO';
ELSE
insert into tblequipos values(p_codigo_id,p_snombre,p_responsable_id,3,false,current_timestamp,current_timestamp,1);
END IF;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE upd_equipos(
p_codigo_id int,
p_snombre text,
p_responsable_id int
)AS
$$
BEGIN
IF NOT EXISTS(select * from tblempleados where codigo_id = p_responsable_id) THEN
RAISE EXCEPTION 'Responsable NO VÁLIDO';
ELSE
UPDATE tblequipos
SET snombre = p_snombre, iconcurrencia_id = 2,bdeleted = false,
dtcreated = current_timestamp, dcmodified = current_timestamp, access_id = 1 
WHERE codigo_id = p_codigo_id;
END IF;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE upd_integrantes(
p_codigo_id int,
p_equipo_id int,
p_integrante_id int
)AS
$$
BEGIN 
IF NOT EXISTS(select * from tblempleados where codigo_id = p_integrante_id) THEN
RAISE EXCEPTION 'Integrante NO VÁLIDO';
ELSE
UPDATE tblequipos_integrantes
SET equipo_id = p_equipo_id, integrante_id = p_integrante, integrante_id = p_integranye_id,
iconcurrencia_id = 1, bdeleted = false, dtcreated = current_timestamp,
dcmodified = current_timestamp, access_id = 1
WHERE codigo_id = p_codigo_id;
END IF;
END;
$$ LANGUAGE plpgsql;



CREATE OR REPLACE PROCEDURE ins_tipozona(
p_codigo_id int,
p_stipo text
)AS
$$
BEGIN
insert into prmtipozonas values(p_codigo_id,p_stipo,2,true,current_timestamp,current_timestamp,0);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE ins_sistema(
p_codigo_id int,
p_idlabel text,
p_svalue text
)AS
$$
BEGIN
insert into prmsistema values(p_codigo_id,p_idlabel,p_svalue,1,false,current_timestamp,current_timestamp,1);
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE upd_sistema(
p_codigo_id int,
p_idlabel text,
p_svalue text
)AS
$$
BEGIN
UPDATE prmsistema
SET idlabel = p_idlabel, svalue = p_svalue, iconcurrencia_id = 1, bdeleted = false,
dtcreated = current_timestamp, dcmodified = current_timestamp, access_id = 0
WHERE codigo_id = p_codigo_id;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE PROCEDURE ins_roles(
p_codigo_id int,
p_snombre text,
p_iestado int
)AS
$$
BEGIN
insert into tblroles values(p_codigo_id,p_snombre,p_iestado,0,true,current_timestamp,
current_timestamp,0);
END
$$ LANGUAGE plpgsql;
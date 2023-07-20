

-- practicando PROCEDURE

CREATE OR REPLACE PROCEDURE mk_paciente(
p_codigo_id text,
p_nombre text,
p_apellido text,
p_dtNacimiento date,
p_sangre text
) AS
$$
BEGIN
IF NOT EXISTS (SELECT * FROM personas WHERE codigo_id = p_codigo_id) THEN
INSERT INTO personas(codigo_id,snombre,sapellido,dtnacimiento)
VALUES (p_codigo_id,p_nombre,p_apellido,p_dtNacimiento);
INSERT INTO pacientes VALUES(p_codigo_id,p_sangre);
ELSE
UPDATE personas
SET snombre = p_nombre,
sapellido = p_apellido,
dtnacimiento = p_dtNacimiento
WHERE codigo_id = p_codigo_id;
UPDATE pacientes 
SET gsangre = p_sangre
WHERE codigo_id = p_codigo_id;
END IF;
END
$$
LANGUAGE plpgsql;

CALL mk_paciente ('19791001-JQ','Javier','Hitler','19990403','A-');

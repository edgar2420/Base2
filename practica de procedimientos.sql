SELECT ins_consulta('Hospital Frances','Antonio Rendon','Victor Gutierrez');


CREATE OR REPLACE FUNCTION ins_consulta(	
	p_nombre_clinica text, 	 
	p_nombre_pac text,  		
	p_nombre_doc text  			
) RETURNS void AS
$$
DECLARE
-- declarar variables
	v_clinica INT;
	v_paciente TEXT;
	v_doctor TEXT;
BEGIN
	-- 1) buscar ID clinica
	SELECT codigo_id INTO v_clinica FROM clinicas WHERE snombre = p_nombre_clinica;
	-- 2) buscar ID paciente
	SELECT codigo_id INTO v_paciente 
	FROM personas p NATURAL JOIN pacientes p2 
	WHERE CONCAT(snombre,' ',sapellido) = p_nombre_pac;
	-- 3) buscar ID doctor
	SELECT codigo_id INTO v_doctor 
	FROM personas p JOIN doctores d USING (codigo_id) 
	WHERE snombre = split_part(p_nombre_doc,' ',1) AND sapellido = split_part(p_nombre_doc,' ',2);
	-- 4) registrar la consulta (ID_cli,ID_doc,ID_pac, CURRENT_TIMESTAMP | NOW() )	
	IF v_clinica IS NOT NULL THEN
		INSERT INTO consultas VALUES (nextval('generador_consultas_id'), v_clinica, v_doctor, v_paciente, current_timestamp);
	ELSE
		RAISE EXCEPTION 'NO EXISTE LA CLINICA INDICADA';
	END IF;
END
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION ins_paciente(	
	p_nombre text, 
	p_apellido text, 
	p_fecha date, 
	p_grupo_sangre text
) RETURNS void AS
$HAPPYCODE$
DECLARE
 v_codigo TEXT;
 v_sangre TEXT;
BEGIN
	SELECT LEFT(p_nombre,2) || LEFT(p_apellido,2), CONCAT(p_grupo_sangre,'+') INTO v_codigo, v_sangre;
  INSERT INTO personas(codigo_id,snombre,sapellido,dtnacimiento) VALUES (v_codigo,p_nombre,p_apellido,p_fecha);
	INSERT INTO pacientes VALUES (v_codigo,v_sangre);
END
$HAPPYCODE$
LANGUAGE plpgsql;
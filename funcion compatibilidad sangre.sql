

CREATE OR REPLACE FUNCTION compatibilidad(
p_codigo_id_uno text,
p_codigo_id_dos text
) RETURNS boolean AS
$$
DECLARE
v_sangre_uno text;
v_sangre_dos text;
BEGIN
SELECT gsangre INTO v_sangre_uno FROM pacientes p
WHERE p_codigo_id = p_codigo_id_uno;
SELECT gsangre INTO v_sangre_dos FROM pacientes p
WHERE p-codigo_id = p_codigo_dos;
IF(v_sangre_uno = 'O-' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'O+' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'O+' AND v_sangre_dos = 'O+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'A-' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'A-' AND v_sangre_dos = 'A-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'A+' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'A+' AND v_sangre_dos = 'O+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'A+' AND v_sangre_dos = 'A-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'A+' AND v_sangre_dos = 'A+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'B-' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'B-' AND v_sangre_dos = 'B-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'B+' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'B+' AND v_sangre_dos = 'O+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'B+' AND v_sangre_dos = 'B-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'B+' AND v_sangre_dos = 'B+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB-' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB-' AND v_sangre_dos = 'A-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB-' AND v_sangre_dos = 'B-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB-' AND v_sangre_dos = 'AB-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'O-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'O+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'A-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'A+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'B-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'B+') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'AB-') THEN
RETURN TRUE;
END IF;
IF(v_sangre_uno = 'AB+' AND v_sangre_dos = 'AB+') THEN
RETURN TRUE;
END IF;
END
$$ LANGUAGE plpgsql;
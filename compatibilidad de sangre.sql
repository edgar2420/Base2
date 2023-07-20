--Utilizando la Base de Datos de Clínica, crear una función que reciba cómo parámetros  dos códigos de pacientes. 
--La función devolverá cómo resultado si el paciente A puede recibir sangre del paciente B, es decir, si es compatible con su grupo sanguineo.
CREATE OR REPLACE FUNCTION compatibilidad(codigoA TEXT, codigoB TEXT)
RETURNS BOOLEAN AS
$$
DECLARE 
sangreA TEXT;
sangreB TEXT;
BEGIN
SELECT gsangre INTO sangreA FROM pacientes WHERE codigo_id = codigoA;
SELECT gsangre INTO sangreB FROM pacientes WHERE codigo_id = codigoB;
IF(sangreA ='AB+') 
THEN RETURN TRUE;
ELSIF (sangreA = 'AB-' AND sangreB in('AB-','A-','B-','O-'))
THEN RETURN TRUE;
ELSIF (sangreA = 'A+' AND sangreB in('O+','O-','A+','O-'))
THEN RETURN TRUE;
ELSIF (sangreA = 'A-' AND sangreB in('0-','A-'))
THEN RETURN TRUE;
ELSIF (sangreA = 'B+' AND sangreB in('0-','O+','B-','B+'))
THEN RETURN TRUE;
ELSIF (sangreA = 'B-' AND sangreB in('O-','B-'))
THEN RETURN TRUE;
ELSIF (sangreA = 'O+' AND sangreB in('O-','O+'))
THEN RETURN TRUE;
ELSIF (sangreA = 'O-' AND sangreB = 'O-')
THEN RETURN TRUE;
ELSE RETURN FALSE;
END IF; 
END 
$$
LANGUAGE plpgsql;

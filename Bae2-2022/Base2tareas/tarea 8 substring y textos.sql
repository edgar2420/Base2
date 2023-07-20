

-- Tarea 8 Codificacion Empleados con formato:
-- Departamento(tres primeras letras), Iniciales del 
-- empleado (apellido, nombre), ultimos dos digitos del año, mes y día.
-- EJEMPLO -->   "SIS-PJ-89-06-02"

SELECT e.*, CONCAT(UPPER(substring (d.nombre,1,3))||'-'||
substring (e.sappaterno,1,1)||
substring (e.snombre,1,1)||'-'||
to_char (dtnacimiento,'YY')||'-'||
to_char (dtnacimiento, 'MM')||'-'||
to_char (dtnacimiento, 'DD')) AS codigo_id
FROM empleados e 
JOIN departamentos d ON e.dpto_id = d.numero_id;  



--1) Obtener todos los empleados que existen en A,B y C
--2) Obtener los empleados que son diferentes en A,B y C
--3) Obtener todos los empleados que existen solo en A

--1
select * from remoto.empleados re
JOIN remoto_uno.empleados ru on re.ci_id = ru.ci_id
JOIN remoto_tres.empleados rt on rt.ci_id = re.ci_id;

--2
SELECT *
FROM empleados a
LEFT JOIN empb.empleados b USING (ci_id)
LEFT JOIN empc.empleados c USING (ci_id)
WHERE b.ci_id IS NULL AND c.ci_id IS NULL
UNION
SELECT *
FROM empleados b
LEFT JOIN empb.empleados a USING (ci_id)
LEFT JOIN empc.empleados c USING (ci_id)
WHERE a.ci_id IS NULL AND c.ci_id IS NULL
UNION
SELECT *
FROM empleados c
LEFT JOIN empb.empleados b USING (ci_id)
LEFT JOIN empc.empleados a USING (ci_id)
WHERE b.ci_id IS NULL AND a.ci_id IS NULL;

--3
select * from remoto_uno.empleados ru
where ru.ci_id not in (select ci_id from remoto.empleados)
and ru.ci_id not in (select ci_id from remoto_tres.empleados);
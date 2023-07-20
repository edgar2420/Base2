--CONSULTA TAREA 5 BDII 

SELECT 'sistemas' AS "dptos", COUNT(q.ci_id) AS "total empleados"
FROM 
(SELECT *
FROM remoto_uno.empleados w
WHERE w.dpto_id = 1
UNION
SELECT *
FROM remoto.empleados e
WHERE e.dpto_id = 1
UNION
SELECT *
FROM remoto_tres.empleados r
WHERE r.dpto_id = 1)q
UNION
SELECT 'Contabilidad' AS "DEPARTAMENTOS", COUNT(c.ci_id) AS "TOTAL EMPLEADOS"
FROM
(SELECT *
FROM remoto_uno.empleados u
WHERE u.dpto_id = 2
UNION
SELECT *
FROM remoto.empleados d
WHERE d.dpto_id = 2
UNION
SELECT *
FROM remoto_tres.empleados t
WHERE t.dpto_id = 2)c
UNION
SELECT 'Marketing' AS "DEPARTAMENTOS", COUNT(m.ci_id) AS "TOTAL EMPLEADOS"
FROM 
(SELECT *
FROM remoto_uno.empleados u
WHERE u.dpto_id = 3
UNION
SELECT *
FROM remoto.empleados d
WHERE d.dpto_id = 3
UNION 
SELECT *
FROM remoto_tres.empleados t
WHERE t.dpto_id = 3)m
UNION
SELECT 'Gerencia' AS "DEPARTAMENTOS", COUNT(g.ci_id) AS "TOTAL EMPLEADOS"
FROM
(SELECT *
FROM remoto_uno.empleados u
WHERE u.dpto_id = 4
UNION
SELECT *
FROM remoto.empleados d
WHERE d.dpto_id = 4
UNION
SELECT *
FROM remoto_tres.empleados t
WHERE t.dpto_id = 4)g
UNION
SELECT 'Operaciones' AS "DEPARTAMENTOS", COUNT(o.ci_id) AS "TOTAL EMPLEADOS"
FROM
(SELECT *
FROM remoto_uno.empleados u
WHERE u.dpto_id = 5
UNION
SELECT *
FROM remoto.empleados d
WHERE d.dpto_id = 5
UNION
SELECT *
FROM remoto_tres.empleados t
WHERE t.dpto_id = 5)o
--EN BASE A LA ESTRUCTURA DE LAS TRES BASES DE DATOS DE EMPRESA, GENERADA EN LA Tarea 4: Consultas InterDBs 
--SE DESEA OBTENER LA CANTIDAD DE CUMPLEAÑEROS POR MES EN CADA DEPARTAMENTO DE LA EMPRESA, SE DEBERÁ ELIMINAR REGISTROS DUPLICADOS QUE EXISTAN DE EMPLEADOS EN DISTINTAS BASES DE DATOS

--1. EL RESULTADO DE LA CONSULTA DEBERÁ PRESENTAR EL SIGUIENTE FORMATO

 --    +--------------+-----+--------------------+
--     | DEPARTAMENTO | MES | TOTAL CUMPLEAÑEROS |
 --    +--------------+-----+--------------------+
 --    | SISTEMAS     | ENE | 24                 |
 --    +--------------+-----+--------------------+
--     | SISTEMAS     | FEB | 56                 |
--     +--------------+-----+--------------------+
--     | ...          | ... |                    |
--     +--------------+-----+--------------------+
--     | GERENCIA     | ENE | 12                 |
--     +--------------+-----+--------------------+
--     | ...          | ... | ...                |
 --    +--------------+-----+--------------------+
--     | OPERACIONES  | DIC | 106                |
 --    +--------------+-----+--------------------+

SELECT d.snombre AS departamento, TO_CHAR(dtnacimiento ,'TMMON') AS "MES" , count(*) AS "TOTAL CUMPLEAÑEROS" 
FROM ( 
SELECT * FROM empleados e  
UNION SELECT * FROM empresac.empleados e2  
UNION SELECT * FROM empresab.empleados e3) e  
JOIN departamentos d ON e.dpto_id =d.numero_id 
GROUP BY d.numero_id, 
TO_CHAR(dtnacimiento ,'TMMON')
ORDER BY d.numero_id, 2 DESC;
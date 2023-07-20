--Obtener todos los empleados que tienen un sueldo mayor al promedio
SELECT snombre, nsalario 
FROM empleados
WHERE nsalario > (SELECT AVG(nsalario)
FROM empleados);

--Obtener los tres primeros departamentos con mayor costo en salarios

SELECT d.snombre, SUM(e.nsalario) as costo_salarios
FROM empleados e
JOIN departamentos d ON e.dpto_id = d.numero_id
GROUP BY d.snombre
ORDER BY costo_salarios DESC
LIMIT 3;

--Obtener el total de ingresos de empleados con familiares y empleados sin familiares, mostrando la diferencia de montos entre ambos grupos

SELECT familiares, sinFamiliares, abs(familiares-sinFamiliares) as diferencia
FROM(SELECT 'a'::text as extra, sum(nsalario) as familiares FROM empleados E join familiares F ON E.ci_id = F-empleado_id) A
join
(SELECT 'a'::text as extra, sun(nsalario) as sin_familiares FROM empelados E WHERE E.ci_id NOT IN (select empleado_id from familiares)
) USING (extra)

--Si la hora trabajada por proyecto es de 55 Bs., ¿cuál sería el ingreso total de cada empleado?

SELECT ci_id, snombre ||' '||sappaterno, nsalario+(total_horas * 55) FROM empleados E JOIN (
    SELECT empleado_id, sum(ihoras) as total_horas FROM trabajos GROUP BY empleado_id)B
    ON E.ci_id=B.empleado_id ORDER BY 3 desc
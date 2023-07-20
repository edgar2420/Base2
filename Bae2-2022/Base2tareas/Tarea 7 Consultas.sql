


--Obtener todos los empleados que tienen un sueldo mayor al promedio

SELECT e.ci_id, (e.snombre, e.sappaterno) AS Empleado, e.nsalario
FROM empleados e
GROUP BY e.ci_id
HAVING e.nsalario > 2400;


--Obtener los tres primeros departamentos con mayor costo en salarios

SELECT d.numero_id, d.nombre, sum(e.nsalario) AS SumaSalario
FROM empleados e
JOIN departamentos d ON e.dpto_id = d.numero_id
GROUP BY d.numero_id
ORDER BY 3 DESC LIMIT 3;
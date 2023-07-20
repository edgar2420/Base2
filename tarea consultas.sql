

--Obtener el total de proyectos y horas trabajadas en las
--que participa cada empleado.


-- opcion 1
SELECT CONCAT(e.nombre,' ', e.appaterno) as Empleados, count(*)
FROM empleados e
JOIN trabajos t ON e.ci_id = t.empleado_id
GROUP BY e.nombre ORDER BY 2 DESC;


-- opcion 2
SELECT CONCAT(e.nombre,' ', e.appaterno) as Empleados, count(t.proyecto_id) as Proyectos, sum(t.horas) as Horas
FROM empleados e
JOIN trabajos t ON e.ci_id = t.empleado_id
GROUP BY e.ci_id;


--Obtener todos los proyectos controlados por departamentos
--que tienen mas de dos ubicaciones

select p.numero_id, p.nombre, d.dpto_id as departamento, count(d.dpto_id) as ubicaciones
from proyectos p 
join dpto_ubicaciones d on p.dpto_id = d.dpto_id
group by p.numero_id
HAVING ubicaciones > 1;



--Obtener la lista de empleados que nacieron en el mes de marzo


SELECT * FROM empleados
WHERE dtnacimiento LIKE '___-03-__';


--Obtener todos los departamentos que tienen un costo mayor
--al promedio de todos los departamentos

select d.numero_id, d.snombre as departamentos, avg(nsalario) as promedioDelDepartamento, (select avg(nsalario) from empleados where dpto_id is not null) as promedioGeneral
from empleados e 
join departamentos d on e.dpto_id = d.numero_id
group by e.dpto_id
HAVING promedioDelDepartamento > promedioGeneral;



--Mostrar todos los administradores que no participan
--en un proyecto

select e.ci_id, e.nombre 
from empleados e
join departamentos d on e.ci_id = d.admin_id
left join trabajos t on e.ci_id = t.empleado_id
where t.empleado_id is null;

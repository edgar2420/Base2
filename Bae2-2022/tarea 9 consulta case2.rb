--Utilizando la DB de empleados, diseñar una consulta que agregue una columna al inicio de la tabla
--empleados, indicando si el empleado es 'Supervisor', 'Administrador' u 'Operador'

--Los operadores son los empleados que no supervisan a nadie
--Los administradores son los empleados a cargo de algún departamento
--Los supervisores son los empleados que controlan a otros empleados

SELECT ci_id,concat(e.snombre,e.sappaterno) as nombre,
  case when E.ci_id in (select D.numero_id from departamentos D) then 'admin'
  when E.ci_id in(select supervisor_id from empleados) then 'supervisor'
  else 'operador' end as tipo From empleados E 
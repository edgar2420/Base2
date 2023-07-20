---Utilizando la base de datos Empresa, diseñar una consulta SQL 
---que obtenga la información de empleados, adicionando una columna que indique el 
---total de empleados que supervisa esa persona

select count(S.ci_id)as Empleados, concat(S.snombre,'',S.sappaterno) as Supervisa 
from empleados S join empleados E on S.ci_id = E.supervisor_id group by S.ci_id
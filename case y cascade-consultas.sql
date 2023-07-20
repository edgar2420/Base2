
-- practica de case y cascade 

ALTER TABLE empleados
DROP CONSTRAINT empleados_supervisor_id_fkey;

ALTER TABLE empleados
ALTER COLUMN supervisor_id TYPE text;

alter table familiares 
drop constraint familiares_empleado_id_fkey;

alter table familiares
alter column empleado_id type text;

alter table trabajos 
drop constraint trabajos_empleado_id_fkey;

alter table trabajos
alter column empleado_id type text;

alter table departamentos 
drop constraint departamentos_admin_id_fkey;

alter table departamentos
alter column admin_id type text;

alter table empleados
alter column ci_id type text;

alter table empleados
add foreign key (supervisor_id) references empleados(ci_id) on update cascade;

alter table familiares
add foreign key (empleado_id) references empleados(ci_id) on update cascade on delete cascade;

alter table trabajos
add foreign key (empleado_id) references empleados(ci_id) on update cascade on delete cascade;

alter table departamentos
add foreign key (admin_id) references empleados(ci_id) on update cascade on delete set null;

UPDATE empleados e
SET ci_id = X.codigo
FROM (
    SELECT UPPER(CONCAT_WS('-',
        LEFT(D.nombre, 3),
        LEFT(E.sappaterno, 1)||LEFT(E.snombre, 1),
        to_char(E.dtnacimiento, 'yy-mm-dd'))) as Codigo,ci_id
FROM empleados E
JOIN departamentos D ON E.dpto_id=D.numero_id) X
WHERE e.ci_id = X.ci_id;

select * from empleados;
select * from trabajos;

alter table empleados
add column sexo char(1);

update empleados
set sexo = 'M'
where snombre ilike '%o'

select ci_id, concat(snombre, ' ' , sappaterno),
case sexo 
when 'M' then 'Masculino' 
when 'F' then 'Femenino'
else 'no se sabe'
end as genero
from empleados e

update empleados 
set sexo = 'N'
where ci_id = 'OPE-CA-98-08-04'

select * from empleados;

select ci_id, concat(snombre, ' ' , sappaterno),
case when supervisor_id is null then 'jefe'
else 'esclavo'
end as cargo
from empleados e 

select ci_id, concat(snombre, ' ' , sappaterno),
case 
when nsalario < 2160 then 'Vago'
when nsalario > 2160 and nsalario < 8000 then 'Bien Pagau´'
else 'Millonete'
end as "estatus social"
from empleados e











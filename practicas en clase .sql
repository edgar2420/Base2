
-- prácticas en clase

-- activo de doctores

select codigo_id, concat(snombre,' ',sapellido) as "Nombre y Apellido", sespecialidad,nsalario,
case bactivo when true then 'Activo' else 'Inactivo' end as Estado
from personas p
natural join doctores d 


-- mayoría de edad de empleados

select e.* ,
case
when age(current_timestamp,dtnacimiento) >= interval'18 year' then 'Mayor de edad'
when age(current_timestamp,dtnacimiento) <= interval'18 year' then 'Menor de edad'
else 'Sin especificar'
end as edad
from empleados e

update empleados
set dtnacimiento = dtnacimiento + interval '6 years'


-- grupo sanguineo con expresiones regulares

alter table pacientes
add constraint check_sangre(gsangre ~ 'expre regular')


-- generando codigo_id

create or replace function gen_codigo(
p_nombre text,
p_apellido text,
p_dtnacimiento date
)
returns text as
$$
declare
v_resultado text;
begin
v_resultado := concat(to_char(p_dtnacimiento,'yyyymmdd'),'-', Upper(left(snombre,1)), upper(left(sapellido,1)));
return v_resultado;
end
$$
language plpgsql;

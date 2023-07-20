
-- SEGUIR PRACTICANDO

ALTER TABLE familiares
DROP CONSTRAINT empleado_id;

ALTER TABLE departamentos
DROP CONSTRAINT departamentos_admin_id_fkey;

ALTER TABLE empleados
DROP CONSTRAINT empleados_supervisor_id_fkey;

SELECT ci_id, CONCAT (snombre, ' ', sappaterno),
CASE  
WHEN nsalario < 2160 THEN 'Vago'
WHEN nsalario > 2160 AND nsalario < 8000 THEN 'Bien Nomas'
ELSE 'Millonete'
END as pagos
FROM empleados e




select * from personas; 
select * from doctores;

select *,
case
when not EXISTS(select codigo_id from personas  (select codigo_id from doctores)) then 'Paciente'
else 'nada'
end as tipo
from personas;


select to_char(c.dtfecha,'dd/MM/YY'),c2.snombre as clinica, concat(d.snombre,' ',d.sapellido) as doctor,
p.snombre ||' '|| p.sapellido as paciente
from consultas c
join clinicas c2 on c2.codigo_id = c.clinica_id
join personas d on c.doctor_id = d.codigo_id
join personas p on c.paciente_id = p.codigo_id order by c.dtfecha asc;
